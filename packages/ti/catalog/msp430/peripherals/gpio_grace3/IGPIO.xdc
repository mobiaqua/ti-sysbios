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
 *  ======== IGPIO ========
 *  MSP430 General Purpose Input Output Ports
 */
metaonly interface IGPIO inherits xdc.platform.IPeripheral {

    /*!
    *  ======== regIntVect_t ========
    *  Interrupt vector description
    *
    *  Type to describe a single interrupt vector pin and all its possible
    *  configurations.
    *
    *  @see #regIntVect_t
    */
    struct regIntVect_t {
        String                    registerName;
        String                    registerDescription;
        String                    isrToggleString;
        String                    priorityName;
        Bool                      interruptEnable;
        Bool                      interruptHandler;
        Int                       priority;
    }

instance:
    /*! GPIO interrupt source */
    config regIntVect_t interruptSource[32];

}
/*
 *  @(#) ti.catalog.msp430.peripherals.gpio_grace3; 1, 0, 0,; 12-4-2015 21:40:15; /db/ztree/library/trees/platform/platform-q16/src/
 */

