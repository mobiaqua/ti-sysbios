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
 *  ======== TMS320C6211B.xdc ========
 *
 */
package ti.catalog.c6000;

/*!
 *  ======== TMS320C6211B ========
 *  The C6211B device data sheet module.
 *
 *  This module implements the xdc.platform.ICpuDataSheet interface and is 
 *  used by platforms to obtain "data sheet" information about this device.
 */
metaonly module TMS320C6211B inherits ITMS320C6x1x
{

instance:
    override config string   cpuCore        = "6200";
    override config string   isa = "62";

    /*!
     *  ======== memMap ========
     *  The default memory map for this device
     */
 
    override config xdc.platform.IPlatform.Memory memMap[string] =
        TMS320C6211.memMap;
};
/*
 *  @(#) ti.catalog.c6000; 1, 0, 0, 0,; 12-4-2015 21:40:07; /db/ztree/library/trees/platform/platform-q16/src/
 */

