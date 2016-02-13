/*
 * Copyright (c) 2015, Texas Instruments Incorporated
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
 *  ======== Timer.xs ========
 */

var Hwi = null;
var BIOS = null;
var Core = null;
var Timer = null;

if (xdc.om.$name == "cfg" || typeof(genCdoc) != "undefined") {
    var deviceTable = {
        "RM57D8xx": {
            "Core0": {
                rtiBaseAddress  : 0xFFFFFC00
            },
            "Core1": {
                rtiBaseAddress  : 0xFFFFEE00
            }
        },
        "RM57L8xx": {
            "Core0": {
                rtiBaseAddress  : 0xFFFFFC00
            }
        }
    };

    deviceTable["RM57D8[a-zA-Z0-9]+"] = deviceTable["RM57D8xx"];
    deviceTable["RM57L8[a-zA-Z0-9]+"] = deviceTable["RM57L8xx"];
    deviceTable["RM48L.*"] = deviceTable["RM57L8xx"];
}

/*
 *  ======== deviceSupportCheck ========
 *  Check validity of device
 */
function deviceSupportCheck()
{
    /* look for exact match first */
    for (device in deviceTable) {
        if (device == Program.cpu.deviceName) {
            return (device);
        }
    }

    /* now look for a wildcard match */
    for (device in deviceTable) {
        if (Program.cpu.deviceName.match(device)) {
            return (device);
        }
    }

    return (null);
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    /* Only process during "cfg" phase */
    if (xdc.om.$name != "cfg") {
        return;
    }

    Timer = this;

    /*
     * set fxntab to false because ti.sysbios.hal.Timer can be used
     * instead of an abstract intsance
     */
    Timer.common$.fxntab = false;

    Timer.intNumDef[0]= 2;
    Timer.intNumDef[1]= 3;
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    BIOS = xdc.useModule('ti.sysbios.BIOS');
    Core = xdc.useModule('ti.sysbios.family.arm.v7r.tms570.Core');
    Hwi = xdc.useModule('ti.sysbios.family.arm.v7r.vim.Hwi');

    device = deviceSupportCheck();

    if (device == null) {
        print("The " + Program.cpu.deviceName +
            " device is not currently supported.");
        print("The following devices are supported for the " +
            Program.build.target.name + " target:");
        for (device in deviceTable) {
                print("\t" + device);
        }
        throw new Error ("Unsupported device!");
    }

    if (!Timer.$written("rtiBaseAddress")) {
        if (Core.id == 0) {
            Timer.rtiBaseAddress = deviceTable[device]["Core0"].rtiBaseAddress;
        }
        else {
            Timer.rtiBaseAddress = deviceTable[device]["Core1"].rtiBaseAddress;
        }
    }
}

/*
 *  ======== module$static$init ========
 */
function module$static$init(mod, params)
{
    /* availMask has 2 bits set for the two timers */
    mod.availMask = 0x3;

    if (params.anyMask > mod.availMask) {
        Timer.$logError("Incorrect anyMask (" + params.anyMask
            + "). Should be <= " + mod.availMask + ".", Timer, "anyMask");
    }

    mod.handles.length = Timer.NUM_TIMER_DEVICES;
    for (var i = 0; i < Timer.NUM_TIMER_DEVICES; i++) {
        mod.handles[i] = null;
    }

    /* Initialize Timer.intFreq if not set by cfg. */
    if (Timer.intFreq.$written("lo") != true) {
        var cpuFreq = BIOS.getCpuFreqMeta();
        Timer.intFreq.lo = cpuFreq.lo / 2;
    }

    /*
     * plug Timer.startup into BIOS.startupFxns array
     */
    BIOS.addUserStartupFunction(Timer.startup);
}

/*
 *  ======== instance$static$init ========
 */
function instance$static$init(obj, id, tickFxn, params)
{
    var modObj = this.$module.$object;

    /* set flag because static instances need to be started */
    Timer.startupNeeded = true;

    obj.staticInst = true;

    if ((id >= Timer.NUM_TIMER_DEVICES)) {
        if (id != Timer.ANY) {
            Timer.$logFatal("Invalid Timer ID " + id + "!", this);
        }
    }

    if (id == Timer.ANY) {
        for (var i = 0; i < Timer.NUM_TIMER_DEVICES; i++) {
            if ((Timer.anyMask & (1 << i)) && (modObj.availMask & (1 << i))) {
                modObj.availMask &= ~(1 << i);
                obj.id = i;
                break;
            }
        }
    }
    else if (modObj.availMask & (1 << id)) {
        modObj.availMask &= ~(1 << id);
        obj.id = id;
    }

    if (obj.id == undefined) {
        Timer.$logFatal("Timer device unavailable.", this);
    }

    obj.runMode = params.runMode;
    obj.startMode = params.startMode;
    obj.prescale = params.prescale;
    obj.period = params.period;
    obj.periodType = params.periodType;
    obj.intNum = Timer.intNumDef[obj.id];
    obj.arg = params.arg;
    obj.tickFxn = tickFxn;
    obj.extFreq.lo = params.extFreq.lo;
    obj.extFreq.hi = params.extFreq.hi;

    if (obj.tickFxn) {
        if (!params.hwiParams) {
            params.hwiParams = new Hwi.Params();
        }
        var hwiParams = params.hwiParams;

        if (obj.runMode == Timer.RunMode_ONESHOT) {
            if (hwiParams.maskSetting == Hwi.MaskingOption_NONE) {
                Timer.$logFatal("Mask in hwiParams cannot" +
                    "enable self.", this);
            }
        }

        if (hwiParams.type == Hwi.Type_IRQ) {
            hwiParams.arg = this;

            if (obj.runMode == Timer.RunMode_CONTINUOUS) {
                obj.hwi = Hwi.create(obj.intNum, Timer.periodicStub, hwiParams);
            }
            else {
                obj.hwi = Hwi.create(obj.intNum, Timer.oneShotStub , hwiParams);
            }
        }
        else {
            /* FIQ interrupts go straight to ISR, no stub */
            obj.hwi = Hwi.create(obj.intNum, obj.tickFxn , hwiParams);
        }
    }
    else {
        obj.hwi = null;
    }

    modObj.handles[obj.id] = this;
}

/*
 *  ======== getEnumString ========
 *  Get the enum value string name, not 0, 1, 2 or 3, etc.  For an enumeration
 *  type property.
 *
 *  Example usage:
 *  if obj contains an enumeration type property "Enum enumProp"
 *
 *  view.enumString = getEnumString(obj.enumProp);
 *
 */
function getEnumString(enumProperty)
{
    /*
     *  Split the string into tokens in order to get rid of the huge package
     *  path that precedes the enum string name. Return the last 2 tokens
     *  concatenated with "_"
     */
    var enumStrArray = String(enumProperty).split(".");
    var len = enumStrArray.length;
    return (enumStrArray[len - 1]);
}

/*
 *  ======== viewInitBasic ========
 *  Initialize the 'Basic' Timer view.
 */
function viewInitBasic(view)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var halTimer = xdc.useModule('ti.sysbios.hal.Timer');
    var Timer = xdc.useModule('ti.sysbios.family.arm.v7r.rti.Timer');

    /* Scan the raw view in order to obtain the module state. */
    var biosRawView;

    try {
        biosRawView = Program.scanRawView('ti.sysbios.BIOS');
    }
    catch (e) {
        this.$logWarning("Caught exception while retrieving raw view: " + e,
                this);
    }

    /* Get the module state */
    var biosMod = biosRawView.modState;

    /* Get the Timer module config to get the number of timer devices. */
    var modCfg = Program.getModuleConfig('ti.sysbios.family.arm.v7r.rti.Timer');

    var numTimers = modCfg.NUM_TIMER_DEVICES;

    /*
     * Retrieve the raw view to get at the module state.
     * This should just return, we don't need to catch exceptions.
     */
    var rawView = Program.scanRawView('ti.sysbios.family.arm.v7r.rti.Timer');

    var timerHandlesAddr = rawView.modState.handles;

    var ScalarStructs = xdc.useModule('xdc.rov.support.ScalarStructs');

    /* Retrieve the array of timer handles */
    var timerHandles = Program.fetchArray(ScalarStructs.S_Ptr$fetchDesc,
                                          timerHandlesAddr, numTimers);

    /*
     * Scan the timerHandles array for non-zero Timer handles
     */
    for (var i = 0; i < numTimers; i++) {
        var timerHandle = timerHandles[i];
        if (Number(timerHandle.elem) != 0) {
            /* Retrieve the embedded instance */
            var obj = Program.fetchStruct(Timer.Instance_State$fetchDesc,
                                          timerHandle.elem);
            var elem = Program.newViewStruct(
                            'ti.sysbios.family.arm.v7r.rti.Timer',
                            'Basic');

            if ((obj.__name != undefined) && obj.__name) {
                elem.label      = Program.fetchString(obj.__name, true);
            }

            var freqKHz =
                ((biosMod.cpuFreq.lo / 2) / (obj.prescale + 1)) / 1000;
            if (obj.periodType == Timer.PeriodType_COUNTS) {
                elem.periodInCounts = obj.period;
                elem.periodInMicroSecs = (obj.period * 1000) / (freqKHz);
            }
            else {
                elem.periodInMicroSecs = obj.period;
                elem.periodInCounts = (freqKHz * obj.period) / 1000;
            }

            elem.halTimerHandle = halTimer.viewGetHandle(obj.$addr);
            elem.id             = obj.id;
            elem.startMode      = getEnumString(obj.startMode);
            elem.runMode        = getEnumString(obj.runMode);
            elem.intNum         = obj.intNum;
            elem.tickFxn        = Program.lookupFuncName(Number(obj.tickFxn));
            elem.arg            = obj.arg;
            elem.extFreq        = Number(obj.extFreq.lo).toString(10);
            elem.hwiHandle      = "0x" + Number(obj.hwi).toString(16);

            /* Add the element to the list. */
            view.elements.$add(elem);
        }
    }
}

/*
 *  ======== viewInitDevice ========
 */
function viewInitDevice(view, obj)
{
    var deviceRegs;
    var Program = xdc.useModule('xdc.rov.Program');
    var Timer = xdc.useModule('ti.sysbios.family.arm.v7r.rti.Timer');
    var modCfg = Program.getModuleConfig('ti.sysbios.family.arm.v7r.rti.Timer');

    view.id          = obj.id;
    view.device      = "timer"+view.id;
    view.intNum      = obj.intNum;
    view.runMode     = getEnumString(obj.runMode);

    var timerAddr    = modCfg.rtiBaseAddress;
    view.devAddr     = "0x" + timerAddr.toString(16);

    try {
        if (deviceRegs === undefined) {
            deviceRegs = Program.fetchStruct(
                            Timer.DeviceRegs$fetchDesc,
                            timerAddr,
                            false
                         );
        }
    }
    catch (e) {
        print("Error: Problem fetching Timer Registers: " + e.toString());
    }

    if (view.id == 0) {
        /* udcp0 */
        view.period = deviceRegs.RTIUDCP0;
        /* comp0 - frc0 */
        view.remainingCount = deviceRegs.RTICOMP0 - deviceRegs.RTIFRC0;

        /* gctrl */
        if (deviceRegs.RTIGCTRL & 1) {
            view.state = "Enabled";
        }
        else {
            view.state = "Disabled";
        }
    }
    else {
        /* udcp1 */
        view.period = deviceRegs.RTIUDCP1;
        /* comp1 - frc1 */
        view.remainingCount = deviceRegs.RTICOMP1 - deviceRegs.RTIFRC1;

        /* gctrl */
        if (deviceRegs.RTIGCTRL & 2) {
            view.state = "Enabled";
        }
        else {
            view.state = "Disabled";
        }
    }
    view.currCount = view.period - view.remainingCount;
}

/*
 *  ======== viewInitModule ========
 *  Initialize the Timer 'Module' view.
 */
function viewInitModule(view, obj)
{
    view.availMask = Number(obj.availMask).toString(2);
}
