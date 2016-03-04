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
 *  ======== ITMS320C28021.xdc ========
 */
package ti.catalog.c2800;

/*!
 *  ======== TMS320C28021 ========
 *  The C28021 device data sheet module.
 *
 *  This module implements the xdc.platform.ICpuDataSheet interface and is used
 *  by platforms to obtain "data sheet" information about this device.
 */
metaonly module TMS320C28021 inherits ITMS320C28xx
{
instance:
    override config string   cpuCoreRevision = "1.0";

    /*!
     *  ======== memMap ========
     *  The default memory map for this device
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [
        ["MSARAM", {
            comment: "On-Chip RAM Memory",
            name: "MSARAM",
            base: 0x0,
            len:  0x800,
            page: 0,
            space: "code/data"
        }],
    
        ["PIEVECT", {
            comment: "On-Chip PIEVECT RAM Memory",
            name:    "PIEVECT",
            base:    0xD00,
            len:     0x100,
            page: 1,
            space:   "data"
        }],
    
        ["LSARAM", {
            comment: "L0 SARAM (3K x 16)",
            name: "LSARAM",
            base: 0x8000,
            len:  0x0c00,
            page: 0,
            space: "code/data"
        }],

        ["FLASH", {
            comment: "32K X 16 Flash memory",
            name: "FLASH",
            base: 0x3f0000,
            len:  0x007f80,
            page: 0,
            space: "code"
        }],

        ["BEGIN", {
            comment: "FLASH boot entry point",
            name: "BEGIN",
            base: 0x3f7ff6,
            len:  0x000002,
            page: 0,
            space: "code"
        }],
    
        ["BOOTROM", {
            comment: "On-Chip Boot ROM",
            name: "BOOTROM",
            base: 0x3fe000,
            len:  0x001fc0, 
            page: 0,
            space: "code"
        }],
    ];
}
/*
 *  @(#) ti.catalog.c2800; 1, 0, 0, 0,2; 1-29-2016 10:00:38; /db/ztree/library/trees/platform/platform-q17/src/
 */

