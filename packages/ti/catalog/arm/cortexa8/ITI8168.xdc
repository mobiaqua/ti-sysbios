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

/*!
 *  ======== ITI8168 ========
 *  An interface implemented by all TI8168 devices
 *
 *  This interface is defined to factor common data about all TI8168 type devices
 *  into a single place; they all have the same internal memory.
 */
metaonly interface ITI8168 inherits ti.catalog.ICpuDataSheet
{
instance:
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp0;
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp1;
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp2;

    override config string cpuCore           = "v7A";
    override config string isa               = "v7A";
    override config string cpuCoreRevision   = "1.0";
    override config int    minProgUnitSize   = 1;
    override config int    minDataUnitSize   = 1;
    override config int    dataWordSize      = 4;

    /*!
     *  ======== memMap ========
     *  The memory map returned be getMemoryMap().
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [
        ["SRAM", {
            comment:    "On-Chip SRAM",
            name:       "SRAM",
            base:       0x402F0000,
            len:        0x10000,
            space:      "code/data",
            access:     "RWX"
        }],
    
        /* 
         * OCMC (On-chip RAM) Bank 0
         * Size is 256K
         */
        ["OCMC_0", {
            name: "OCMC_0",
            base: 0x40300000, 
            len:  0x40000
        }],
        
        /* 
         * OCMC (On-chip RAM) Bank 1
         * Size is 256K
         */
        ["OCMC_1", {
            name: "OCMC_1",
            base: 0x40400000, 
            len:  0x40000
        }],

    ];
}
/*
 *  @(#) ti.catalog.arm.cortexa8; 1, 0, 0,; 12-4-2015 21:39:55; /db/ztree/library/trees/platform/platform-q16/src/
 */

