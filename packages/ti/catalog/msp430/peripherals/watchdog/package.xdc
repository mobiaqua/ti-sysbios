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

requires ti.catalog.msp430.peripherals.clock;
requires ti.catalog.msp430.peripherals.special_function;

/*!
 *  ======== ti.catalog.msp430.peripherals.watchdog ========
 *  MSP430 WDT+ (watchdog timer) peripheral
 */
package ti.catalog.msp430.peripherals.watchdog [1, 0, 0] {
    module WDTplus;
    module WDT_A;
    interface IWDT;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.watchdog; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

