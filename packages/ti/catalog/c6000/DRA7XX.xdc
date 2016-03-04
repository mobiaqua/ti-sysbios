/*
 *  Copyright (c) 2016 by Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 *
 *  Contributors:
 *      Texas Instruments - initial implementation
 *
 * */

/*
 *  ======== DRA7XX.xdc ========
 *
 */

package ti.catalog.c6000;

/*!
 *  ======== DRA7XX ========
 *  The DRA7XX device data sheet module.
 *
 *  This module implements the ICpuDataSheet interface and is
 *  used by platforms to obtain "data sheet" information about this device.
 */ 
metaonly module DRA7XX inherits ti.catalog.ICpuDataSheet
{

    config long cacheSizeL1[string] = [
        ["0k",  0x0000],
        ["4k",  0x1000],
        ["8k",  0x2000],
        ["16k", 0x4000],
        ["32k", 0x8000]
    ];

    config long cacheSizeL2[string] = [
        ["0k",    0x000000],
        ["32k",   0x008000],
        ["64k",   0x010000],
        ["128k",  0x020000],
        ["256k",  0x040000]
    ];

    readonly config ti.catalog.c6000.ICacheInfo.CacheDesc cacheMap[string] =  [
             ['l1PMode',{desc:"L1P Cache",
                         base: 0x00E00000,
                         map : [["0k" ,0x0000],
                                ["4k" ,0x1000],
                                ["8k" ,0x2000],
                                ["16k",0x4000],
                                ["32k",0x8000]],
                         defaultValue: "32k",
                         memorySection: "L1PSRAM"}],

             ['l1DMode',{desc:"L1D Cache",
                         base: 0x00F00000,
                         map : [["0k"  ,0x0000],
                                ["4k"  ,0x1000],
                                ["8k"  ,0x2000],
                                ["16k" ,0x4000],
                                ["32k" ,0x8000]],
                         defaultValue: "32k",
                         memorySection: "L1DSRAM"}],

             ['l2Mode',{desc:"L2 Cache",
                         base: 0x00800000,
                         map : [["0k"   ,0x0000],
                                ["32k"  ,0x8000],
                                ["64k"  ,0x10000],
                            ["128k" ,0x020000],
                                ["256k" ,0x040000]],
                         defaultValue: "0k",
                         memorySection: "L2SRAM"}],

    ];

instance:
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp0;
    override config string   cpuCore        = "6600";
    override config string   isa = "66";
    override config string   cpuCoreRevision = "1.0";

    override config int     minProgUnitSize = 1;
    override config int     minDataUnitSize = 1;
    override config int     dataWordSize    = 4;

    /*!
     *  ======== memMap ========
     *  The default memory map for this device
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [
        ["L2SRAM", {
            comment:    "256KB L2 SRAM/CACHE",
            name:       "L2SRAM",
            base:       0x00800000,
            len:        0x00040000,
            space:      "code/data",
            access:     "RWX"
        }],

        ["L1PSRAM", {
            comment:    "32KB RAM/CACHE L1 program memory",
            name:       "L1PSRAM",
            base:       0x00E00000,
            len:        0x00008000,
            space:      "code",
            access:     "RWX"
        }],

        ["L1DSRAM", {
            comment:    "32KB RAM/CACHE L1 data memory",
            name:       "L1DSRAM",
            base:       0x00F00000,
            len:        0x00008000,
            space:      "data",
            access:     "RW"
        }],

        ["OCMC_RAM1", {
            comment:    "OCMC (On-chip RAM) Bank 1 (512KB)",
            name:       "OCMC_RAM1",
            base:       0x40300000,
            len:        0x00080000,
            space:      "code/data",
            access:     "RWX"
        }],

        ["OCMC_RAM2", {
            comment:    "OCMC (On-chip RAM) Bank 2 (1MB)",
            name:       "OCMC_RAM2",
            base:       0x40400000,
            len:        0x00100000,
            space:      "code/data",
            access:     "RWX"
        }],

        ["OCMC_RAM3", {
            comment:    "OCMC (On-chip RAM) Bank 3 (1MB)",
            name:       "OCMC_RAM3",
            base:       0x40500000,
            len:        0x00100000,
            space:      "code/data",
            access:     "RWX"
        }],
    ];
};
/*
 *  @(#) ti.catalog.c6000; 1, 0, 0, 0,2; 1-29-2016 10:00:42; /db/ztree/library/trees/platform/platform-q17/src/
 */

