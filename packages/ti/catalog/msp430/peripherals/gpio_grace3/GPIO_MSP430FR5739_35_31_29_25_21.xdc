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
import ti.catalog.msp430.peripherals.clock.CS as CS;

/*!
 *  ======== GPIO for MSP430FR5739_35_31_29_25_21 ========
 *  MSP430 General Purpose Input Output Ports
 */
metaonly module GPIO_MSP430FR5739_35_31_29_25_21 inherits IGPIO {
    /*!
     *  ======== create ========
     *  Create an instance of this peripheral. Use a customized
     *  init function so that we can get access to the CS
     *  instances.
     */
    create(CS.Instance clock);

instance:
    /*! @_nodoc */
    config CS.Instance clock;
    
    config Int numPortInterrupts = 4;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.gpio_grace3; 1, 0, 0,; 12-4-2015 21:40:15; /db/ztree/library/trees/platform/platform-q16/src/
 */

