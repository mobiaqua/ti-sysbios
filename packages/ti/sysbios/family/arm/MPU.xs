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
 *  ======== MPU.xs ========
 */

var BIOS = null;
var Build = null;
var Core = null;
var Cache = null;
var device = null;
var MPU = null;

/*
 * ======== getAsmFiles ========
 * return the array of assembly language files associated
 * with targetName (ie Program.build.target.$name)
 */
function getAsmFiles(targetName)
{
    switch(targetName) {
        case "ti.targets.arm.elf.R4F":
        case "ti.targets.arm.elf.R5F":
            return (["MPU_asm.sv7R"]);
            break;

        default:
            return (null);
	    break;
    }
}

/*
 *  Note: On single core devices like MSP432, only "Core0"
 *        needs to be added to devicetale[device] array.
 *
 *        On multi core devices, "Core0", "Core1", ... needs
 *        to be added to deviceTable[device] for each core.
 */
if (xdc.om.$name == "cfg" || typeof(genCdoc) != "undefined") {
    var deviceTable = {
        "RM57D8xx": {
            "Core0": {
                isMemoryMapped  : false,
                numRegions      : 16,
                regionSettings  : [
                    {
                        regionId             : 0,
                        baseAddress          : 0x00000000,
                        regionSize           : 0x3E, /* MPU.RegionSize_4G */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : false,
                        accPerm              : 0,    /* No access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0xFF
                    },
                    {
                        regionId             : 1,
                        baseAddress          : 0x00000000,
                        regionSize           : 0x2A, /* MPU.RegionSize_4M */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : true,
                        noExecute            : false,
                        accPerm              : 6,    /* R-only access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 2,
                        baseAddress          : 0x08000000,
                        regionSize           : 0x22, /* MPU.RegionSize_256K */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 3,
                        baseAddress          : 0x08040000,
                        regionSize           : 0x22, /* MPU.RegionSize_256K */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 0,    /* No acces at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0xC0
                    },
                    {
                        regionId             : 4,
                        baseAddress          : 0x08040000,
                        regionSize           : 0x22, /* MPU.RegionSize_256K */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : true,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0x3F
                    },
                    {
                        regionId             : 5,
                        baseAddress          : 0x60000000,
                        regionSize           : 0x36, /* MPU.RegionSize_256M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : true,
                        noExecute            : false,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 0,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 6,
                        baseAddress          : 0x80000000,
                        regionSize           : 0x38, /* MPU.RegionSize_512M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : false,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 7,
                        baseAddress          : 0xF0000000,
                        regionSize           : 0x2A, /* MPU.RegionSize_4M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 8,
                        baseAddress          : 0xFB000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 9,
                        baseAddress          : 0xFC000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 10,
                        baseAddress          : 0xFE000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0xE0
                    },
                    {
                        regionId             : 11,
                        baseAddress          : 0xFF000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0xC0
                    },
                    {
                        regionId             : 15,
                        baseAddress          : 0xFFF80000,
                        regionSize           : 0x24, /* MPU.RegionSize_512K */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    }
                ]
            },
            "Core1": {
                isMemoryMapped  : false,
                numRegions      : 16,
                regionSettings  : [
                    {
                        regionId             : 0,
                        baseAddress          : 0x00000000,
                        regionSize           : 0x3E, /* MPU.RegionSize_4G */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : false,
                        accPerm              : 0,    /* No access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0xFF
                    },
                    {
                        regionId             : 1,
                        baseAddress          : 0x00000000,
                        regionSize           : 0x2A, /* MPU.RegionSize_4M */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : true,
                        noExecute            : false,
                        accPerm              : 6,    /* R-only access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 2,
                        baseAddress          : 0x08000000,
                        regionSize           : 0x22, /* MPU.RegionSize_256K */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 0,    /* No access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 3,
                        baseAddress          : 0x08040000,
                        regionSize           : 0x22, /* MPU.RegionSize_256K */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0xC0
                    },
                    {
                        regionId             : 4,
                        baseAddress          : 0x08040000,
                        regionSize           : 0x22, /* MPU.RegionSize_256K */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : true,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0x3F
                    },
                    {
                        regionId             : 5,
                        baseAddress          : 0x60000000,
                        regionSize           : 0x36, /* MPU.RegionSize_256M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : true,
                        noExecute            : false,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 0,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 6,
                        baseAddress          : 0x80000000,
                        regionSize           : 0x38, /* MPU.RegionSize_512M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : false,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 7,
                        baseAddress          : 0xF0000000,
                        regionSize           : 0x2A, /* MPU.RegionSize_4M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 8,
                        baseAddress          : 0xFB000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 9,
                        baseAddress          : 0xFC000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 10,
                        baseAddress          : 0xFE000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0xE0
                    },
                    {
                        regionId             : 11,
                        baseAddress          : 0xFF000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0xC0
                    },
                    {
                        regionId             : 15,
                        baseAddress          : 0xFFF80000,
                        regionSize           : 0x24, /* MPU.RegionSize_512K */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and
                                                        R-only at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    }
                ]
            }
        },
        "RM57L8xx": {
            "Core0": {
                isMemoryMapped  : false,
                numRegions      : 16,
                regionSettings  : [
                    {
                        regionId             : 0,
                        baseAddress          : 0x00000000,
                        regionSize           : 0x3E, /* MPU.RegionSize_4G */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : false,
                        accPerm              : 0,    /* No access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0xFF
                    },
                    {
                        regionId             : 1,
                        baseAddress          : 0x00000000,
                        regionSize           : 0x2A, /* MPU.RegionSize_4M */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : true,
                        noExecute            : false,
                        accPerm              : 6,    /* R-only access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 2,
                        baseAddress          : 0x08000000,
                        regionSize           : 0x24, /* MPU.RegionSize_512K */
                        enable               : true,
                        bufferable           : true,
                        cacheable            : true,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and
                                                        PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 3,
                        baseAddress          : 0x60000000,
                        regionSize           : 0x36, /* MPU.RegionSize_256M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : true,
                        noExecute            : false,
                        accPerm              : 3,    /* RW access at PL1 and PL0 */
                        tex                  : 0,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 4,
                        baseAddress          : 0x80000000,
                        regionSize           : 0x38, /* MPU.RegionSize_512M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : false,
                        accPerm              : 3,    /* RW access at PL1 and PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 5,
                        baseAddress          : 0xF0000000,
                        regionSize           : 0x2A, /* MPU.RegionSize_4M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and R-only
                                                        at PL0 */
                        tex                  : 1,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 6,
                        baseAddress          : 0xFB000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 7,
                        baseAddress          : 0xFC000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and R-only
                                                        at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    },
                    {
                        regionId             : 8,
                        baseAddress          : 0xFE000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 3,    /* RW access at PL1 and PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0xE0
                    },
                    {
                        regionId             : 9,
                        baseAddress          : 0xFF000000,
                        regionSize           : 0x2E, /* MPU.RegionSize_16M */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and R-only
                                                        at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0xC0
                    },
                    {
                        regionId             : 15,
                        baseAddress          : 0xFFF80000,
                        regionSize           : 0x24, /* MPU.RegionSize_512K */
                        enable               : true,
                        bufferable           : false,
                        cacheable            : false,
                        shareable            : false,
                        noExecute            : true,
                        accPerm              : 2,    /* RW access at PL1 and R-only
                                                        at PL0 */
                        tex                  : 2,
                        subregionDisableMask : 0
                    }
                ]
            }
        },
        "MSP432P401R": {
            "Core0": {
                isMemoryMapped  : true,
                numRegions      : 8,
                regionSettings  : [
                ]
            },
        },
        "TM4C129CNCPDT": {
            "Core0": {
                isMemoryMapped  : true,
                numRegions      : 8,
                regionSettings  : [
                ]
            },
        },
    };

    /* Cortex-R devices */
    deviceTable["RM57D8.*"] = deviceTable["RM57D8xx"];
    deviceTable["RM57L8.*"] = deviceTable["RM57L8xx"];
    deviceTable["RM48L.*"]  = deviceTable["RM57L8xx"];

    /* MSP432 devices */
    deviceTable["MSP432.*"] = deviceTable["MSP432P401R"];

    /* Tiva devices */
    deviceTable["TM4.*"]    = deviceTable["TM4C129CNCPDT"];
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

    this.$private.getAsmFiles = getAsmFiles;

    MPU = this;

    /* set fxntab default */
    MPU.common$.fxntab = false;

    device = deviceSupportCheck();

    if (device != null) {
        MPU.isMemoryMapped = deviceTable[device]["Core0"].isMemoryMapped;
        MPU.numRegions = deviceTable[device]["Core0"].numRegions;
        MPU.regionEntry.length = MPU.numRegions;
        for (var i = 0; i < MPU.numRegions; i++) {
            /*
             *  Initialize baseAddress to 0xFFFFFFFF so we can check
             *  if baseAddress is still 0xFFFFFFFF in module$use.
             *  This would serve as a way to determine if the application
             *  set a particular memory region.
             */
            MPU.regionEntry[i].baseAddress = 0xFFFFFFFF;
            MPU.regionEntry[i].sizeAndEnable = 0;
            MPU.regionEntry[i].regionAttrs = 0;
        }
    }
    else {
        MPU.numRegions = 0;
        MPU.isMemoryMapped = true;
        MPU.regionEntry.length = 0;
    }
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    BIOS = xdc.module('ti.sysbios.BIOS');
    Build = xdc.useModule('ti.sysbios.Build');

    if (Program.build.target.name == "R5F") {
        Cache  = xdc.useModule('ti.sysbios.family.arm.v7r.Cache');
    }
    else {
        Cache  = xdc.useModule('ti.sysbios.hal.Cache');
        Cache.CacheProxy = xdc.useModule('ti.sysbios.hal.CacheNull');

        Startup = xdc.useModule('xdc.runtime.Startup');
        Startup.firstFxns.$add(MPU.startup);
    }

    if (device != null) {
        var coreId, regionArray, coreDelegate, settings;
        settings = xdc.module('ti.sysbios.family.Settings');
        coreDelegate = settings.getDefaultCoreDelegate();
        if ((coreDelegate === undefined) || (coreDelegate == null)) {
            coreId = 0;
        }
        else {
            Core = xdc.useModule(coreDelegate);
            coreId = Core.id;
        }
        if (coreId == 0) {
            regionArray = deviceTable[device]["Core0"].regionSettings;
        }
        else {
            regionArray = deviceTable[device]["Core1"].regionSettings;
        }

        var attrs = new MPU.RegionAttrs();
        initRegionAttrsMeta(attrs);
        for (var i = 0; i < regionArray.length; i++) {
            /*  Init any region not initialized by the application. */
            var regionId = regionArray[i].regionId;
            if (MPU.regionEntry[regionId].baseAddress == 0xFFFFFFFF) {
                attrs.enable = regionArray[i].enable;
                attrs.bufferable = regionArray[i].bufferable;
                attrs.cacheable = regionArray[i].cacheable;
                attrs.shareable = regionArray[i].shareable;
                attrs.noExecute = regionArray[i].noExecute;
                attrs.accPerm = regionArray[i].accPerm;
                attrs.tex = regionArray[i].tex;
                attrs.subregionDisableMask =
                    regionArray[i].subregionDisableMask;
                setRegionMeta(regionArray[i].regionId,
                    regionArray[i].baseAddress,
                    regionArray[i].regionSize, attrs);
            }
        }

        for (var i = 0; i < MPU.numRegions; i++) {
            /*
             *  Clear base address for any entry not set by user or the
             *  device table.
             */
            if (MPU.regionEntry[i].baseAddress == 0xFFFFFFFF) {
                MPU.regionEntry[i].baseAddress = 0;
            }
        }
    }
    else {
        /*
         * no match, print all catalog devices supported
         * and then raise an error
         */
        var catalog = xdc.loadPackage(Program.cpu.catalogName);

        /* build associative array of supported devices */
        var supportedDevices = new Object();

        for (var i = 0; i < catalog.$modules.length; i++) {
            catalogName = catalog.$modules[i].$name.substring(
                Program.cpu.catalogName.length + 1);

            for (device in deviceTable) {
                if (catalogName.match(device)) {
                    supportedDevices[catalogName] = catalogName;
                }
            }
        }

        /* copy it into a sortable array */
        var sd = new Array();

        for (var i in supportedDevices) {
            sd[sd.length++] = i;
        }

        /* sort it for a nicer report */
        sd.sort();

        print("The " + Program.cpu.deviceName +
              " device is not currently supported.");
        print("The following devices are supported for the " +
            Program.build.target.name + " target:");

        for (var i=0; i<sd.length; i++) {
            print("\t" + sd[i]);
        }

        throw new Error ("Unsupported device!");
    }

    /* add -D to compile line to optimize MPU_isMemoryMapped check */
    Build.ccArgs.$add("-Dti_sysbios_family_arm_MPU_isMemoryMapped__D=" +
        (MPU.isMemoryMapped ? "TRUE" : "FALSE"));
}

/*
 *  ======== module$static$init ========
 */
function module$static$init(mod, params)
{
    mod.regionEntry.length = MPU.numRegions;

    for (var i = 0; i < MPU.numRegions; i++) {
        mod.regionEntry[i].baseAddress =
            MPU.regionEntry[i].baseAddress;
        mod.regionEntry[i].sizeAndEnable =
            MPU.regionEntry[i].sizeAndEnable;
        mod.regionEntry[i].regionAttrs =
            MPU.regionEntry[i].regionAttrs;
    }
}

/*
 *  ======== initRegionAttrsMeta ========
 */
function initRegionAttrsMeta(attrs)
{
    /* Set all fields to their default value */
    attrs.enable = MPU.defaultAttrs.enable;
    attrs.bufferable = MPU.defaultAttrs.bufferable;
    attrs.cacheable = MPU.defaultAttrs.cacheable;
    attrs.shareable = MPU.defaultAttrs.shareable;
    attrs.noExecute = MPU.defaultAttrs.noExecute;
    attrs.accPerm = MPU.defaultAttrs.accPerm;
    attrs.tex = MPU.defaultAttrs.tex;
    attrs.subregionDisableMask = MPU.defaultAttrs.subregionDisableMask;
}

/*
 *  ======== setiRegionMeta ========
 */
function setRegionMeta(regionId, regionBaseAddr, regionSize, attrs)
{
    var index;

    if (MPU.numRegions == 0) {
        MPU.$logError("MPU_setRegionMeta: Number of MPU regions " +
              "(MPU.numRegions) is set to 0. The number of regions must be " +
              "non-zero.", MPU);
    }

    /* Set enable field to default if undefined */
    if (attrs.enable === undefined) {
        attrs.enable = MPU.defaultAttrs.enable;
    }

    /* Set bufferable field to default if undefined */
    if (attrs.bufferable === undefined) {
        attrs.bufferable = MPU.defaultAttrs.bufferable;
    }

    /* Set cacheable field to default if undefined */
    if (attrs.cacheable === undefined) {
        attrs.cacheable = MPU.defaultAttrs.cacheable;
    }

    /* Set shareable field to default if undefined */
    if (attrs.shareable === undefined) {
        attrs.shareable = MPU.defaultAttrs.shareable;
    }

    /* Set noExecute field to default if undefined */
    if (attrs.noExecute === undefined) {
        attrs.noExecute = MPU.defaultAttrs.noExecute;
    }

    /* Set accPerm field to default if undefined */
    if (attrs.accPerm === undefined) {
        attrs.accPerm = MPU.defaultAttrs.accPerm;
    }

    /* Set tex field to default if undefined */
    if (attrs.tex === undefined) {
        attrs.tex = MPU.defaultAttrs.tex;
    }

    /* Set subregionDisableMask to default if undefined */
    if (attrs.subregionDisableMask === undefined) {
        attrs.subregionDisableMask = MPU.defaultAttrs.subregionDisableMask;
    }

    if ((regionId >= 0) && (regionId < MPU.numRegions)) {
        var alignMask;
        if (regionSize == MPU.RegionSize_4G) {
            alignMask = 0x0;
        }
        else {
            alignMask = convertToUInt32(~0 << ((regionSize >>> 1) + 1));
        }

        if (regionBaseAddr != (regionBaseAddr & alignMask)) {
            MPU.$logWarning("Region base address not aligned to region size",
                MPU);
        }

        MPU.regionEntry[regionId].baseAddress = regionBaseAddr;

        MPU.regionEntry[regionId].sizeAndEnable =
            ((attrs.subregionDisableMask << 8) | regionSize | attrs.enable);

        MPU.regionEntry[regionId].regionAttrs =
            convertToUInt32((attrs.noExecute << 12) | (attrs.accPerm << 8) |
            (attrs.tex << 3) | (attrs.shareable << 2) | (attrs.cacheable << 1) |
            (attrs.bufferable));
    }
    else {
        MPU.$logError("MPU Region number (" + regionId + ") passed is " +
            "invalid.", MPU);
    }
}

/*
 *  ======== convertToUInt32 ========
 */
function convertToUInt32(value)
{
    /*
     *  Provide this workaround here due to javascript.
     *  Note: Javascript converts numbers to 32-bit signed numbers before
     *        evaluating bitwise operators.
     */
    if (value < 0) {
        value = value + 0xffffffff + 1;
    }

    return (value);
}

/*
 *  ======== viewPopulateRegionAttrs ========
 */
function viewPopulateRegionAttrs(regionIdx, elem, baseAddress, sizeAndEnable,
    regionAttrs)
{
    elem.RegionIdx = regionIdx;
    elem.Enabled = sizeAndEnable & 0x1;

    if (elem.Enabled) {
        elem.BaseAddress = "0x" + baseAddress.toString(16);
        elem.SubregionDisableMask = "0x" +
            ((sizeAndEnable >>> 8) & 0xFF).toString(16);

        /* Determine MPU region size */
        var sizeIdx = (sizeAndEnable >>> 1) & 0x1F;

        if (sizeIdx < 31) {
            var regionSize = 1 << (sizeIdx + 1);

            if ((regionSize / 1024) < 1) {
                regionSize = Number(regionSize).toString(10) + " Bytes";
            }
            else if ((regionSize / (1024*1024)) < 1) {
                regionSize = Number(regionSize/1024).toString(10) + " KBytes";
            }
            else if ((regionSize / (1024*1024*1024)) < 1) {
                regionSize = Number(regionSize/(1024*1024)).toString(10) +
                             " MBytes";
            }
            else {
                regionSize = Number(regionSize/(1024*1024*1024)).toString(10) +
                             " GBytes";
            }
        }
        else {
            var regionSize = "4 GBytes";
        }

        elem.Size = regionSize;
        elem.Bufferable = regionAttrs & 0x1;
        elem.Cacheable = (regionAttrs >>> 1) & 0x1;
        elem.Shareable = (regionAttrs >>> 2) & 0x1;
        elem.Noexecute = (regionAttrs >>> 12) & 0x1;
        elem.Tex = "0x" + ((regionAttrs >>> 3) & 0x7).toString(16);

        /* Determine MPU region access permissions */
        var accPerm = (regionAttrs >>> 8) & 0x7;
        switch (accPerm) {
            case 0: elem.AccessPerm = "No Access at any Privilege Level";
                    break;
            case 1: elem.AccessPerm = "Supervisor RW access";
                    break;
            case 2: elem.AccessPerm = "Supervisor RW and User R-only access";
                    break;
            case 3: elem.AccessPerm = "Supervisor and User RW access";
                    break;
            case 4: elem.AccessPerm = "Unpredictable";
                    break;
            case 5: elem.AccessPerm = "Supervisor R-only";
                    break;
            case 6: elem.AccessPerm = "Supervisor and User R-only access";
                    break;
            case 7: elem.AccessPerm = "Unpredictable";
                    break;
            default:
                    elem.AccessPerm = "Unpredictable";
        }
    }
    else {
        elem.BaseAddress = "";
        elem.SubregionDisableMask = "";
        elem.Size = "";
        elem.Bufferable = undefined;
        elem.Cacheable = undefined;
        elem.Shareable = undefined;
        elem.Noexecute = undefined;
        elem.Tex = "";
        elem.AccessPerm = "";
    }
}

/*
 *  ======== viewMpuRegionAttrs ========
 */
function viewMpuRegionAttrs(view)
{
    var mpuRegionEntry;
    var Program = xdc.useModule('xdc.rov.Program');
    var MPU = xdc.useModule('ti.sysbios.family.arm.MPU');
    var MPUCfg = Program.getModuleConfig(MPU.$name);

    /* Scan the raw view in order to obtain the module state. */
    var rawView;
    try {
        rawView = Program.scanRawView('ti.sysbios.family.arm.MPU');
    }
    catch (e) {
        this.$logWarning("Caught exception while retrieving raw view: " + e,
                this);
    }

    /* Get the module state */
    var mod = rawView.modState;

    /* Retrieve the MMU descriptor table */
    try {
        mpuRegionEntry = Program.fetchArray(
            {
                type: 'xdc.rov.support.ScalarStructs.S_UInt32',
                isScalar: true
            },
            mod.regionEntry,
            (MPUCfg.numRegions * 3),
            false);
    }
    catch (e) {
        this.$logWarning(
            "Caught exception while trying to retrieve descriptor table: " +
            e, this);
    }

    /* Walk through the level 1 descriptor table */
    for (var i = 0; i < MPUCfg.numRegions; i++) {
        var elem = Program.newViewStruct('ti.sysbios.family.arm.MPU',
                'MpuRegionAttrsView');

        viewPopulateRegionAttrs(i, elem, mpuRegionEntry[i*3],
            mpuRegionEntry[i*3 + 1], mpuRegionEntry[i*3 + 2]);

        /* Add the element to the list. */
        view.elements.$add(elem);
    }
}
