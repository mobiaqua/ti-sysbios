/*
 * Copyright (c) 2018-2019, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
/*
 *  ======== Boot.xs ========
 *
 */

var Boot = null;
var BIOS = null;
var Program = null;

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    /* Only process during "cfg" phase */
    if (xdc.om.$name != "cfg") {
        return;
    }

    Boot = this;
    Program = xdc.module("xdc.cfg.Program");

    /* set default loadSegment */
    Boot.loadSegment = "FLASH0 PAGE = 0";

    /* default runSegment */
    Boot.runSegment = "RAMLS0_5 PAGE = 0";

    /* assign setters to the Clock configuration parameters */
    var GetSet = xdc.module("xdc.services.getset.GetSet");

    GetSet.init(Boot);

    GetSet.onSet(this, "configureClocks", updateFrequency);
    GetSet.onSet(this, "OSCCLK", updateFrequency);
    GetSet.onSet(this, "SPLLIMULT", updateFrequency);
    GetSet.onSet(this, "SPLLREFDIV", updateFrequency);
    GetSet.onSet(this, "SPLLODIV", updateFrequency);
    GetSet.onSet(this, "SYSCLKDIVSEL", updateFrequency);
    GetSet.onSet(this, "configureFlashController", updateFrequency);
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    BIOS = xdc.module('ti.sysbios.BIOS');

    /* only install Boot_init if using XDC runtime */
    if (Program.build.rtsName === null) {
        return;
    }

    /* disable watchdog */
    if (Boot.disableWatchdog == true) {
        /* install Reset function */
        var Reset = xdc.useModule('xdc.runtime.Reset');
        Reset.fxns[Reset.fxns.length++]
            = '&ti_sysbios_family_c28_f2838x_init_Boot_init';
    }

    /* if the Limp abort function is undefined, use a default */
    if (Boot.limpAbortFunction === undefined) {
            Boot.limpAbortFunction =
            '&ti_sysbios_family_c28_f2838x_init_Boot_defaultLimpAbortFunction';
    }

    /* if booting from Flash place initial branch to c_int00 */
    if ( (Boot.bootFromFlash == true) &&
         (Program.sectMap[".ti_sysbios_family_c28_f2838x_init_begin"] ===
              undefined)) {
            Program.sectMap[".ti_sysbios_family_c28_f2838x_init_begin"] =
                new Program.SectionSpec();
            Program.sectMap[".ti_sysbios_family_c28_f2838x_init_begin"].loadSegment = "BEGIN";
    }

    /* if configuring Flash controller calculate wait states*/
    if (Boot.configureFlashController == true) {
        updateFlashWaitStates(BIOS.cpuFreq.lo);
    }

    /* conditionally create a Startup function */
    if ((Boot.configureClocks == true) ||
        (Boot.configureFlashController == true) ||
        (Boot.configureSharedRAMs == true)) {
        /* install Startup first function (runs as ramfunc) */
        var Startup = xdc.useModule('xdc.runtime.Startup');
        Startup.firstFxns[Startup.firstFxns.length++] =
            '&ti_sysbios_family_c28_f2838x_init_Boot_initStartup';
    }
}

/*
 *  ======== module$static$init ========
 */
function module$static$init(mod, params)
{
}

/*
 *  ======== module$validate ========
 */
function module$validate()
{
    if (Boot.configureClocks == true) {
        var freq = getFrequency();
        if (BIOS.cpuFreq.lo != freq) {
            this.$logError(
                "BIOS.cpuFreq (" + BIOS.cpuFreq.lo + " Hz) does not match " +
                "the actual CPU frequency (" + freq + " Hz). Please program " +
                "the Boot module's PLL settings to ensure the actual CPU " +
                "frequency matches BIOS.cpuFreq.", this);
        }
        if (freq > 200000000) {
            this.$logError(
                "Resulting CPU frequency (" + freq + " Hz) is too high, " +
                "the Boot module's PLL settings must be corrected.", this);
        }
    }
}

/*
 *  ======== viewInitModule ========
 *  Display the module properties in ROV
 */
function viewInitModule(view, obj)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var Boot = xdc.useModule('ti.sysbios.family.c28.f2838x.init.Boot');
    var modCfg = Program.getModuleConfig(Boot.$name);

    view.disableWatchdog = modCfg.disableWatchdog;
    view.configureClocks = modCfg.configureClocks;
    view.configureFlashController = modCfg.configureFlashController;
    view.configureFlashWaitStates = modCfg.configureFlashWaitStates;
    view.enableFlashProgramCache = modCfg.enableFlashProgramCache;
    view.enableFlashDataCache = modCfg.enableFlashDataCache;
    view.configureSharedRAMs = modCfg.configureSharedRAMs;
    view.bootFromFlash = modCfg.bootFromFlash;
}

/*
 *  ======== updateFlashWaitStates ========
 */
function updateFlashWaitStates(freq)
{
    /* if using external oscillator (XTAL) */
    if (Boot.OSCCLKSRCSEL == Boot.OscClk_XTAL) {
        if (freq <= 50000000) {
            Boot.flashWaitStates = 0;
        }
        else if (freq <= 100000000) {
            Boot.flashWaitStates = 1;
        }
        else if (freq <= 150000000) {
            Boot.flashWaitStates = 2;
        }
        else {
            Boot.flashWaitStates = 3;
        }
    }
    /* else, internal oscillator */
    else {
        if (freq <= 48000000) {
            Boot.flashWaitStates = 0;
        }
        else if (freq <= 97000000) {
            Boot.flashWaitStates = 1;
        }
        else if (freq <= 145000000) {
            Boot.flashWaitStates = 2;
        }
        else {
            Boot.flashWaitStates = 3;
        }
    }
}

/*
 *  ======== getFrequency ========
 */
function getFrequency()
{
    var frequency;

    if (Boot.configureClocks) {
        if (Boot.SPLLIMULT == 0) {  /* multiplier bypasses PLL ? */
            frequency = Boot.OSCCLK;
        }
        else {
            frequency = (Boot.OSCCLK * Boot.SPLLIMULT) /
                ((Boot.SPLLREFDIV + 1) * (Boot.SPLLODIV + 1));
        }

        /* convert to Hz */
        frequency *= 1000000;

        /* apply sys clock dividers */
        if (Boot.SYSCLKDIVSEL) {
            frequency /= Boot.SYSCLKDIVSEL << 1;
        }

        Boot.timestampFreq = frequency;

    }
    else {
        BIOS = xdc.module("ti.sysbios.BIOS");
        frequency = BIOS.cpuFreq.lo;
    }

    return (frequency);
}

/* Array of listeners, used by 'registerFreqListener' and 'updateFrequency'. */
var listeners = new Array();

/*
 *  ======== registerFreqListener ========
 *  Called by other modules (e.g., BIOS), to register themselves to listen
 *  for changes to the device frequency configured by the Boot module.
 */
function registerFreqListener(listener)
{
    listeners[listeners.length] = listener;

    /*
     * Invoke updateFrequency in case changes were made before the module
     * was registered (e.g., if the Platform meta$init ran before BIOS
     * meta$init)
     */
    updateFrequency();
}

/*
 *  ======== updateFrequency ========
 *  Update all of the listeners whenever the PLL configuration changes
 *  (assuming configureClocks is true).
 */
function updateFrequency(field, val)
{
    /* Compute the new frequency. */
    var newFreq = getFrequency();

    /* update the flash wait state with new frequency */
    updateFlashWaitStates(newFreq);

    /* Update the displayed frequency values. */
    Boot.displayFrequency = freqToString(newFreq);

    /* Notify each of the listeners of the new frequency value. */
    for each (var listener in listeners) {
        listener.fireFrequencyUpdate(newFreq);
    }
}

/*
 *  ======== freqToString ========
 *  Convert the frequency to a string with appropriate MHz / KHz label.
 */
function freqToString(freq)
{
    if ((freq / 1000000) >= 1) {
        var mhz = freq / 1000000.0;
        return (String(mhz) + " MHz");
    }
    else if ((freq / 1000) >= 1) {
        var khz = freq / 1000.0;
        return (String(khz) + " KHz");
    }
    else {
        return (freq + " Hz");
    }
}
