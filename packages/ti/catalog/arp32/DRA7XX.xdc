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

package ti.catalog.arp32;

/*!
 *  ======== DRA7XX ========
 *  The DRA7XX device data sheet module.
 *
 *  This module implements the xdc.platform.ICpuDataSheet interface and is
 *  used by platforms to obtain "data sheet" information about this device.
 *
 */
metaonly module DRA7XX inherits ti.catalog.ICpuDataSheet
{
instance:
    override config string cpuCore           = "ARP32";
    override config string isa               = "arp32";
    override config string cpuCoreRevision   = "1.0";
    override config int    minProgUnitSize   = 1;
    override config int    minDataUnitSize   = 1;
    override config int    dataWordSize      = 4;

    /*!
     *  ======== memMap ========
     *  The memory map returned be getMemoryMap().
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [

        ["DMEM", {
            comment: "32KB data memory",
            name: "DMEM",
            base: 0x40020000,
            len:  0x8000,
            space: "data",
            page: 1,
            access: "RW"
        }],

        ["WBUF", {
            comment: "VCOP work buffer",
            name: "WBUF",
            base: 0x40040000,
            len:  0x8000,
            space: "data",
            page: 1,
            access: "RW"
        }],

        ["IBUFLA", {
            comment: "Image buffer low copy A",
            name: "IBUFLA",
            base: 0x40050000,
            len:  0x4000,
            space: "data",
            page: 1,
            access: "RW"
        }],

        ["IBUFHA", {
            comment: "Image buffer high copy A",
            name: "IBUFHA",
            base: 0x40054000,
            len:  0x4000,
            space: "data",
            page: 1,
            access: "RW"
        }],

        ["IBUFLB", {
            comment: "Image buffer low copy B",
            name: "IBUFLB",
            base: 0x40070000,
            len:  0x4000,
            space: "data",
            page: 1,
            access: "RW"
        }],

        ["IBUFHB", {
            comment: "Image buffer high copy B",
            name: "IBUFHB",
            base: 0x40074000,
            len:  0x4000,
            space: "data",
            page: 1,
            access: "RW"
        }],

        ["OCMC_RAM1", {
            comment:    "OCMC (On-chip RAM) Bank 1 (512KB)",
            name:       "OCMC_RAM1",
            base:       0x40300000,
            len:        0x00080000,
            space:      "code/data",
            page: 1,
            access:     "RWX"
        }],

        ["OCMC_RAM2", {
            comment:    "OCMC (On-chip RAM) Bank 2 (1MB)",
            name:       "OCMC_RAM2",
            base:       0x40400000,
            len:        0x00100000,
            space:      "code/data",
            page: 1,
            access:     "RWX"
        }],

        ["OCMC_RAM3", {
            comment:    "OCMC (On-chip RAM) Bank 3 (1MB)",
            name:       "OCMC_RAM3",
            base:       0x40500000,
            len:        0x00100000,
            space:      "code/data",
            page: 1,
            access:     "RWX"
        }],

    ];
};
/*
 *  @(#) ti.catalog.arp32; 1, 0, 0, 0,2; 1-29-2016 10:00:37; /db/ztree/library/trees/platform/platform-q17/src/
 */

