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

requires xdc.platform;
requires ti.catalog.peripherals.hdvicp2;

/*!
 *  ======== ti.catalog.arm.cortexa8 ========
 *  Package of devices for the Cortex A8 family of Arm processors.
 *
 *  Each module in this package implements the xdc.platform.ICpuDataSheet
 *  interface. This interface is used by platforms (modules that implement
 *  xdc.platform.IPlatform) to obtain the memory map supported by each CPU.
 */
package ti.catalog.arm.cortexa8 [1,0,0] {
    interface IOMAP3xxx;
    module OMAP3403, OMAP3405, OMAP3503, OMAP3505, OMAP3515, OMAP3517;
    module OMAP3425, OMAP3525, TMS320C3430, OMAP3530;

    interface ITI8168;
    module TMS320TI816X;
    module TMS320DM8168;
    module TMS320C6A8168;

    interface ITI8148;
    module TMS320TI814X;
    module TMS320DM8148;

    interface IAM335X;
    module AM3358, AM3359;

    module AM3505, AM3517;

    interface ITI813X;
    module TMS320TI813X;

    interface ITI811X;
    module TMS320TI811X;

    module TMS320C6A8149;
}
/*
 *  @(#) ti.catalog.arm.cortexa8; 1, 0, 0,; 12-4-2015 21:39:55; /db/ztree/library/trees/platform/platform-q16/src/
 */

