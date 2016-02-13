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
requires ti.catalog.msp430.peripherals.clock;

/*!
 *  ======== ti.catalog.msp430.peripherals.timer ========
 *  MSP430 Timer_A and Timer_B peripherals
 */
package ti.catalog.msp430.peripherals.timer [1, 0, 0] {
    module Timer_A2, Timer1_A2;
    module Timer_A5, Timer0_A5;
    module Timer_A3, Timer0_A3, Timer1_A3, Timer2_A3;
    module Timer_B3;
    module Timer_B7, Timer0_B7;
    module Timer0_B3, Timer1_B3, Timer2_B3;
    module Timer2_A2, Timer3_A2, Timer3_A5;
    interface ITimer, ITimer_A, ITimer_B;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,; 12-4-2015 21:40:22; /db/ztree/library/trees/platform/platform-q16/src/
 */

