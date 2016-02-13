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

requires xdc.platform;
requires ti.catalog;

/*!
 *  ======== ti.catalog.msp430.f54xx ========
 *  Package of devices for the msp430.f54xx family
 *
 *  Each module in this package implements the xdc.platform.ICpuDataSheet
 *  interface. This interface is used by platforms (modules that implement
 *  xdc.platform.IPlatform) to obtain the memory map supported by each CPU.
 */
package ti.catalog.msp430.f54xx [1,0,0] {
    interface IMSP430F54xx;
    module MSP430F5418;
    module MSP430F5419;
    module MSP430F5435;
    module MSP430F5436;
    module MSP430F5437;
    module MSP430F5438;
}
/*
 *  @(#) ti.catalog.msp430.f54xx; 1, 0, 0,; 12-4-2015 21:40:09; /db/ztree/library/trees/platform/platform-q16/src/
 */

