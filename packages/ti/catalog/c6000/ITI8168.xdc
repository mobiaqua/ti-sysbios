/*
 *  Copyright (c) 2015 by Texas Instruments and others.
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
 *  ======== ITI8168.xdc ========
 *
 */
package ti.catalog.c6000;

/*!
 *  ======== ITI8168 ========
 *  An interface implemented by all TI8168 devices
 *
 *  This interface is defined to factor common data about all TI8168 type devices
 *  into a single place; they all have the same internal memory.
 */
metaonly interface ITI8168 inherits ti.catalog.ICpuDataSheet
{

    config long cacheSizeL1[string] = [
        ["0k",  0x0000],
        ["4k",  0x1000],
        ["8k",  0x2000],
        ["16k", 0x4000],
        ["32k", 0x8000],
    ];

    config long cacheSizeL2[string] = [
        ["0k",   0x00000],
        ["32k",  0x08000],
        ["64k",  0x10000],
        ["128k", 0x20000],
        ["256k", 0x40000],
    ];

    readonly config ti.catalog.c6000.ICacheInfo.CacheDesc cacheMap[string] =  [
             ['l1PMode', {desc: "L1P Cache",
                         base: 0x10E00000,
                         map : [["0k",  0x0000],
                                ["4k",  0x1000],
                                ["8k",  0x2000],
                                ["16k", 0x4000],
                                ["32k", 0x8000]],
                         defaultValue: "32k",
                         memorySection: "L1PSRAM"}],
         
                 ['l1DMode', {desc: "L1D Cache",
                         base: 0x10F00000,
                         map : [["0k",  0x0000],
                                ["4k",  0x1000],
                                ["8k",  0x2000],
                                ["16k", 0x4000],
                                ["32k", 0x8000]],
                         defaultValue: "32k",
                         memorySection: "L1DSRAM"}],
                     
             ['l2Mode', {desc: "L2 Cache",
                         base: 0x10800000,
                         map : [["0k",   0x00000],
                                ["32k",  0x08000],
                                ["64k",  0x10000],
                                ["128k", 0x20000],
                                ["256k", 0x40000]],
                         defaultValue: "0k",
                         memorySection: "IRAM"}], 

    ];

instance:
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp0;
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp1;
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp2;

    override config int     minProgUnitSize = 1;
    override config int     minDataUnitSize = 1;    
    override config int     dataWordSize    = 4;

    override config string   cpuCore        = "674";
    override config string   isa            = "674";
    override config string   cpuCoreRevision = "1.0";

    config xdc.platform.IPlatform.Memory memMap[string]  = [

        ["IRAM", {
            comment:    "Internal 256KB L2 memory",
            name:       "IRAM",
            base:       0x10800000,
            len:        0x40000,
            space:      "code/data",
            access:     "RWX"
        }],
        
        ["L1PSRAM", {
            comment:    "Internal 32KB L1 program memory",
            name:       "L1PSRAM",
            base:       0x10E00000,
            len:        0x8000,
            space:      "code",
            access:     "RWX"
        }],

        ["L1DSRAM", {
            comment:    "Internal 32KB L1 data memory",
            name:       "L1DSRAM",
            base:       0x10F00000,
            len:        0x8000,
            space:      "data",
            access:     "RW"
        }],
        
        ["OCMC_0", {
            comment:    "OCMC (On-chip RAM) Bank 0 (256KB)",
            name:       "OCMC_0",
            base:       0x40300000, 
            len:        0x40000,
            space:      "code/data",
            access:     "RWX"
        }],
        
        ["OCMC_1", {
            comment:    "OCMC (On-chip RAM) Bank 1 (256KB)",
            name:       "OCMC_1",
            base:       0x40400000, 
            len:        0x40000,
            space:      "code/data",
            access:     "RWX"
        }],
    ];
};
/*
 *  @(#) ti.catalog.c6000; 1, 0, 0, 0,; 12-4-2015 21:40:06; /db/ztree/library/trees/platform/platform-q16/src/
 */

