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
 * */
/*
 *  ======== Boot.xs ========
 */

var Boot = null;
var BIOS = null;
var Program = null;
var Build = null;

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    /* only process during "cfg" phase */
    if (xdc.om.$name != "cfg") {
        return;
    }
    Boot = this;

    /* set default loadSegment */
    Boot.loadSegment = "CMBANK0_SECTOR0";

    /* default runSegment */
    Boot.runSegment = "S0RAM";
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    Program = xdc.useModule('xdc.cfg.Program');
    Build = xdc.useModule('ti.sysbios.Build');
    BIOS = xdc.module("ti.sysbios.BIOS");

    /* only install Boot_init if using XDC runtime */
    if (Program.build.rtsName === null) {
        return;
    }

    /* disable watchdog */
    if (Boot.disableWatchdog == true) {
        /* install Reset function */
        var Reset = xdc.useModule('xdc.runtime.Reset');
        Reset.fxns[Reset.fxns.length++] =
            '&ti_sysbios_family_arm_f2838x_init_Boot_init';
    }

    /* configure Flash controller */
    if (Boot.configureFlashController == true) {
        updateFlashWaitStates(BIOS.cpuFreq.lo);
        /* install Startup first function (runs as ramfunc) */
        var Startup = xdc.useModule('xdc.runtime.Startup');
        Startup.firstFxns[Startup.firstFxns.length++] =
            '&ti_sysbios_family_arm_f2838x_init_Boot_initStartup';
    }
}

/*
 *  ======== viewInitModule ========
 *  Display the module properties in ROV
 */
function viewInitModule(view, obj)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var Boot = xdc.useModule('ti.sysbios.family.arm.f2838x.init.Boot');
    var modCfg = Program.getModuleConfig(Boot.$name);

    view.disableWatchdog          = modCfg.disableWatchdog;
    view.configureFlashController = modCfg.configureFlashController;
    view.configureFlashWaitStates = modCfg.configureFlashWaitStates;
    view.enableFlashProgramCache  = modCfg.enableFlashProgramCache;
    view.enableFlashDataCache     = modCfg.enableFlashDataCache;
    view.pllSourcedINTOSC         = modCfg.pllSourcedINTOSC;
    view.bootFromFlash            = modCfg.bootFromFlash;
}

/*
 *  ======== updateFlashWaitStates ========
 */
function updateFlashWaitStates(freq)
{
    /* if using internal oscillator as source for OSCCLK */
    if (Boot.pllSourcedINTOSC == true) {
        if (freq <= 48000000) {
            Boot.flashWaitStates = 0;
        }
        else if (freq <= 97000000) {
            Boot.flashWaitStates = 1;
        }
        else {
            Boot.flashWaitStates = 2;
        }
    }
    /* else, external oscillator */
    else {
        if (freq <= 50000000) {
            Boot.flashWaitStates = 0;
        }
        else if (freq <= 100000000) {
            Boot.flashWaitStates = 1;
        }
        else {
            Boot.flashWaitStates = 2;
        }
    }
}
