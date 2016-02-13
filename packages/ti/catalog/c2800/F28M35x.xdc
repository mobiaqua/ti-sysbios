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
 *  ======== F28M35x.xdc ========
 *
 */
package ti.catalog.c2800;

/*!
 *  ======== F28M35x ========
 *  The F28M35x device data sheet module.
 *
 *  This module implements the xdc.platform.ICpuDataSheet interface and is used
 *  by platforms to obtain "data sheet" information about this device.
 */
metaonly module F28M35x inherits ITMS320C283xx
{
instance:
    override config string   cpuCoreRevision = "1.0";

    /*!
     *  ======== memMap ========
     *  The default memory map for this device
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [
        ["M01SARAM", {
            comment: "On-Chip RAM Memory",
            name: "M01SARAM",
            base: 0x0,
            len:  0x800,
            page: 1,
            space: "code/data",
            access: "RWX"
        }],
    
        ["PIEVECT", {
            comment: "On-Chip PIEVECT RAM Memory",
            name: "PIEVECT",
            base: 0xD00,
            len:  0x100,
            page: 0,
            space: "data",
            access: "RW"
        }],
    
        ["L03SARAM", {
            comment: "On-Chip RAM Memory",
            name: "L03SARAM",
            base: 0x8000,
            len:  0x4000,
            page: 1,
            space: "code/data",
            access: "RWX"
        }],
    
        ["S07SHRAM", {
            comment: "On-Chip Shared RAM Memory",
            name: "S07SHRAM",
            base: 0xC000,
            len:  0x8000,
            page: 1,
            space: "code/data",
            access: "RWX"
        }],
    
        ["CTOMMSGRAM", {
            comment: "C28 to M3 MSG RAM Memory",
            name: "CTOMMSGRAM",
            base: 0x3F800,
            len:  0x00400,
            page: 1,
            space: "data",
            access: "RW"
        }],
    
        ["MTOCMSGRAM", {
            comment: "M3 to C28 MSG RAM Memory",
            name: "MTOCMSGRAM",
            base: 0x3FC00,
            len:  0x00400,
            page: 1,
            space: "data",
            access: "R"
        }],
    
        ["OTP", {
            comment: "1K X 16 OTP memory",
            name: "OTP",
            base: 0x240400,
            len:  0x000400,
            page: 0,
            space: "code",
            access: "RWX"
        }],
    
        ["FLASH", {
            comment: "256K X 16 Flash memory",
            name: "FLASH",
            base: 0x100000,
            len:  0x03fffe,
            page: 0,
            space: "code/data",
            access: "RWX"
        }],
    
        ["BEGIN", {
            comment: "Used for Flash boot",
            name: "BEGIN",
            base: 0x13fffe,
            len:  0x000002,
            page: 0,
            space: "code/data",
            access: "RWX"
        }],

        ["BOOTROM", {
            comment: "On-Chip Boot ROM",
            name: "BOOTROM",
            base: 0x3f8000,
            len:  0x008000, 
            page: 0,
            space: "code",
            access: "RX"
        }],
    ];
};
/*
 *  @(#) ti.catalog.c2800; 1, 0, 0, 0,; 12-4-2015 21:40:02; /db/ztree/library/trees/platform/platform-q16/src/
 */

