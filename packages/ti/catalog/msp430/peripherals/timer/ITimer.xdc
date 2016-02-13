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
import ti.catalog.msp430.peripherals.clock.IClock;

/*!
 *  ======== ITimer ========
 *  MSP430 ITimer interface
 */
metaonly interface ITimer inherits xdc.platform.IPeripheral {

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

    create(IClock.Instance clock);

instance:
    /*!
     *  ======== baseAddr ========
     *  Address of the peripheral's control register.
     *
     *  A peripheral's registers are commonly accessed through a structure
     *  that defines the offsets of a particular register from the lowest
     *  address mapped to a peripheral. That lowest address is specified by
     *  this parameter.
     */
    config UInt baseAddr;

    /*!
     *  ======== intNum ========
     *  Interrupt source number
     *
     */
    config UInt intNum;

    /*!
     *  ======== numberOfTimers ========
     *  Stores the number of available timer capture compare blocks
     *
     */
    config UChar numberOfTimers;

    /*!
    *  ======== setTxxCCRx ========
    *  Sets TxxCCRx register value based on which CCR register
    *
    *  @see #setTxxCCRx
    */
    void setTxxCCRx(UChar ccrNumber , Bits16 value);

   /*!
    *  ======== getTxxCCRx ========
    *  Returns TxxCCRx register value based on which CCR register
    *
    *  @see #getTxxCCRx
    */
    Bits16 getTxxCCRx(UChar ccrNumber);

   /*!
    *  ======== isInternal ========
    *  Boolean that is true if a Timer is internal, meaning
    *  it has no external inputs or outputs
    *
    */
    config Bool isInternal = false;

    /*! @_nodoc */
    config IClock.Instance clock;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

