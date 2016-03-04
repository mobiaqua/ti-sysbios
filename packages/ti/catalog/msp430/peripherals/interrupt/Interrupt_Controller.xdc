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
/*!
 *  ======== Interrupt_Controller ========
 *  MSP430 Interrupt_Controller
 */
metaonly module Interrupt_Controller inherits xdc.platform.IPeripheral {

instance:

    config UInt baseAddr;
    config UInt numInterrupts;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.interrupt; 1, 0, 0,2; 1-29-2016 10:00:53; /db/ztree/library/trees/platform/platform-q17/src/
 */

