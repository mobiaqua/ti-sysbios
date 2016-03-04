/* 
 *  Copyright (c) 2009 by Texas Instruments and others.
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
 *  ======== MSP430F2274.xdc ========
 *
 */

/*!
 *  ======== MSP430F2274 ========
 *  MSP430F2274 Cpu definition
 *
 *  This device has 32KB + 256B of Flash Memory and 1KB RAM.  The
 *  MSP430F2274 has two op-amps (OA).
 */
metaonly module MSP430F2274 inherits IMSP430x22xx
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
            base:       0x200,
            len:        0x400,
            space:      "code/data",
            access:     "RWX"
        }],

        ["FLASH", {
            comment:    "Program FLASH",
            name:       "FLASH",
            base:       0x8000,
            len:        0x7FDE,
            space:      "code",
            access:     "RWX"
        }],
    ];
};
/*
 *  @(#) ti.catalog.msp430.f22xx; 1, 0, 0,2; 1-29-2016 10:00:44; /db/ztree/library/trees/platform/platform-q17/src/
 */

