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
 *  ======== ti.catalog.msp430.f22xx ========
 *  Package of devices for the msp430.f22xx family.
 *
 *  Each module in this package implements the xdc.platform.ICpuDataSheet
 *  interface. This interface is used by platforms (modules that implement
 *  xdc.platform.IPlatform) to obtain the memory map supported by each CPU.
 */
package ti.catalog.msp430.f22xx [1,0,0] {
    interface IMSP430x22xx;
    module MSP430F223x;
    module MSP430F225x;
    module MSP430F2274;
}
/*
 *  @(#) ti.catalog.msp430.f22xx; 1, 0, 0,2; 1-29-2016 10:00:44; /db/ztree/library/trees/platform/platform-q17/src/
 */

