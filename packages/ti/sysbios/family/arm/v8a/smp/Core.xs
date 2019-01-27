/*
 * Copyright (c) 2018, Texas Instruments Incorporated
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
 *  ======== Core.xs ========
 */

var Hwi = null;
var Core = null;
var BIOS = null;
var Task = null;
var Build = null;
var Reset = null;
var HalHwi = null;
var Memory = null;
var System = null;
var Startup = null;

if (xdc.om.$name == "cfg") {
    var deviceTable = {
        "SIMMAXWELL": {
            numCores         : 4
        }
    };

    deviceTable["AM65.*"] = deviceTable["SIMMAXWELL"];
    deviceTable["J7ES"]   = deviceTable["SIMMAXWELL"];
}

/*
 * ======== getAsmFiles ========
 * return the array of assembly language files associated
 * with targetName (ie Program.build.target.$name)
 */
function getAsmFiles(targetName)
{
    switch(targetName) {
        case "gnu.targets.arm.A53F":
            return (["Core_asm_gnu.sv8A"]);
            break;

        default:
            return (null);
            break;
    }
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

    this.$private.getAsmFiles = getAsmFiles;

    Core = this;

    for (device in deviceTable) {
        if (device == Program.cpu.deviceName ||
            Program.cpu.deviceName.match(device)) {
            Core.numCores = deviceTable[device].numCores;
            Core.CPUMASK = (0x1 << Core.numCores) - 1;
            return;
        }
    }

    /*
     * Cant throw an error here as this code gets executed when any
     * module from this package is used.
     */
    Core.CPUMASK = Core.numCores = 1;
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    Hwi = xdc.module('ti.sysbios.family.arm.gicv3.Hwi');
    Task = xdc.module('ti.sysbios.knl.Task');
    Build = xdc.module('ti.sysbios.Build');
    Reset = xdc.useModule('xdc.runtime.Reset');
    Memory = xdc.module('xdc.runtime.Memory');
    System = xdc.useModule('xdc.runtime.System');
    Startup = xdc.useModule('xdc.runtime.Startup');
    HalHwi = xdc.module('ti.sysbios.hal.Hwi');

    Core.common$.fxntab = false;

    /* Create inter-core interrupts */
    var hwiParams = new Hwi.Params();

    for (var idx = 0; idx <= Core.numCores; idx++) {
        hwiParams.arg = idx;
        Hwi.create(idx, Core.hwiFunc, hwiParams);
    }

    var GateSmp = xdc.useModule('ti.sysbios.family.arm.v8a.smp.GateSmp');
    Core.gate = GateSmp.create();

    /* install func to start all secondary cores */
    Task.startupHookFunc = Core.startCoreX;

    /* install our atexit func */
    System.atexitMeta(Core.atexit);

    if (Core.$written("numCores") == true) {
        Core.CPUMASK = (0x1 << Core.numCores) - 1;
    }

    Core.initStackFlag = HalHwi.initStackFlag;
}

/*
 *  ======== module$static$init ========
 */
function module$static$init(mod, params)
{
    mod.schedulerInts.length = Core.numCores;
    mod.interrupts.length = Core.numCores + 1;
    mod.gateEntered.length = Core.numCores;
    mod.syncCores.length = Core.numCores;
    mod.ipcMsg.length = Core.numCores;

    for (var i = 0; i <= Core.numCores; i++) {
        mod.interrupts[i].length = Core.numCores;
        for (var j = 0; j < Core.numCores; j++) {
            mod.interrupts[i][j] = 0;
        }
    }

    for (var i = 0; i < Core.numCores; i++) {
        mod.schedulerInts[i] = 0;
        mod.gateEntered[i] = false;
        mod.ipcMsg[i].func = null;
        mod.ipcMsg[i].arg = 0;
        mod.syncCores[i].length = Core.numCores;
        for (var j = 0; j < Core.numCores; j++) {
            mod.syncCores[i][j] = false;
        }
    }

    mod.notifyLock = false;
    mod.startupCalled = false;

    /* add -D to compile line to optimize exception code */
    Build.ccArgs.$add("-Dti_sysbios_family_arm_v8a_smp_Core_initStackFlag__D=" +
        (Core.initStackFlag ? "TRUE" : "FALSE"));
}
