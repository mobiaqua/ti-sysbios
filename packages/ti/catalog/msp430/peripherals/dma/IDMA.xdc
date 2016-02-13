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
 *  ======== IDMA ========
 *  MSP430 DMA controller
 */
metaonly interface IDMA inherits xdc.platform.IPeripheral {

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

    /*!
    *  ======== regTriggerVect_t ========
    *  Trigger vector description
    *
    */
    struct regTriggerVect_t {
        Int    channel;
        String triggerName;
        Int    value;
    }

    /*!
    *  ======== ForceSetDefaultRegister_t ========
    *  Force Set Default Register
    *
    *  Type to store if each register needs to be forced initialized
    *  even if the register is in default state.
    *
    *  @see #ForceSetDefaultRegister_t
    */
    struct ForceSetDefaultRegister_t {
        String     register;
        Bool       regForceSet;
    }
    
    
instance:
}


/*
 *  @(#) ti.catalog.msp430.peripherals.dma; 1, 0, 0,; 12-4-2015 21:40:13; /db/ztree/library/trees/platform/platform-q16/src/
 */

