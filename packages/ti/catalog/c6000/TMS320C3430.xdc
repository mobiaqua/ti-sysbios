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
 *  ======== TMS320C3430.xdc ========
 *
 */
package ti.catalog.c6000;

/*!
 *  ======== TMS320C3430 ========
 *  The C64P device data sheet module.
 *
 *  This module implements the xdc.platform.ICpuDataSheet interface and is 
 *  used by platforms to obtain "data sheet" information about this device.
 */
metaonly module TMS320C3430 inherits IOMAP3xxx
{

instance:
    override config string   cpuCoreRevision = "2.1";
};
/*
 *  @(#) ti.catalog.c6000; 1, 0, 0, 0,; 12-4-2015 21:40:07; /db/ztree/library/trees/platform/platform-q16/src/
 */

