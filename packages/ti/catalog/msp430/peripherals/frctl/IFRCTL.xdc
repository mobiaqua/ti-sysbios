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
 *  ======== IFRCTL ========
 *  MSP430 FRAM controller (FRCTL)
 */
metaonly interface IFRCTL inherits xdc.platform.IPeripheral {

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

    /*! @_nodoc */
    config IClock.Instance clock;
}


/*
 *  @(#) ti.catalog.msp430.peripherals.frctl; 1, 0, 0,2; 1-29-2016 10:00:51; /db/ztree/library/trees/platform/platform-q17/src/
 */

