/* 
 *  Copyright (c) 2008 Texas Instruments and others.
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
 *  ======== CC430F6137.xdc ========
 *
 */

/*!
 *  ======== CC430F6137 ========
 *  CC430F6137 CPU definition
 */
metaonly module CC430F6137 inherits IMSP430F55xx
{
instance:
    override config string   cpuCoreRevision = "1.0";

    /*!
     *  ======== memMap ========
     *  The default memory map for this device
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [

        ["RAM", {
            comment:    "Data RAM",
            name:       "RAM",
            base:       0x1C00,
            len:        0x1000,
            space:      "code/data",
            access:     "RWX"
        }],

        ["FLASH", {
            comment:    "Program FLASH",
            name:       "FLASH",
            base:       0x8000,
            len:        0x7F80,
            space:      "code",
            access:     "RWX"
        }],
    ];
};
/*
 *  @(#) ti.catalog.msp430.f55xx; 1, 0, 0,2; 1-29-2016 10:00:44; /db/ztree/library/trees/platform/platform-q17/src/
 */

