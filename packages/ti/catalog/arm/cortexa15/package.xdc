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
 *  ======== ti.catalog.arm.cortexa15  ========
 *  Package of devices for the arm Cortex A15 family of Arm processors.
 *
 *  Each module in this package implements the xdc.platform.ICpuDataSheet
 *  interface. This interface is used by platforms (modules that implement
 *  xdc.platform.IPlatform) to obtain the memory map supported by each CPU.
 */
package ti.catalog.arm.cortexa15 [1,0,0] {
    interface ITCI663X;
    module OMAP5430;
    module Vayu;
    module DRA7XX;
    module C66AK2E05;
    module TCI6630K2L;
    module TCI6636K2H;
    module TCI6638K2K;
    module TCI66AK2G02;
}
/*
 *  @(#) ti.catalog.arm.cortexa15; 1, 0, 0,; 12-4-2015 21:39:55; /db/ztree/library/trees/platform/platform-q16/src/
 */

