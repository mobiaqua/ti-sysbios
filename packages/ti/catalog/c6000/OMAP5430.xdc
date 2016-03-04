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
 *  ======== OMAP5430.xdc ========
 *
 */
package ti.catalog.c6000;

/*!
 *  ======== OMAP5430 ========
 *  The C64T device data sheet module.
 */
metaonly module OMAP5430 inherits ti.catalog.ICpuDataSheet
{

instance:
    config ti.catalog.peripherals.hdvicp2.HDVICP2.Instance hdvicp0;

    override config int     minProgUnitSize = 1;
    override config int     minDataUnitSize = 1;    
    override config int     dataWordSize    = 4;

    override config string   cpuCore         = "64T";
    override config string   isa             = "64T";
    override config string   cpuCoreRevision = "1.0";

    config xdc.platform.IPlatform.Memory memMap[string]  = [
        
        ["L2SRAM", {
            comment:    "Shared 256KB SRAM",
            name:       "L2SRAM",
            base:       0x10900000,
            len:        0x00040000,
            space:      "code/data",
            access:     "RWX"
        }],
    ];
};
/*
 *  @(#) ti.catalog.c6000; 1, 0, 0, 0,2; 1-29-2016 10:00:43; /db/ztree/library/trees/platform/platform-q17/src/
 */

