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
 *  ======== DMA ========
 *  MSP430 DMA controller
 */
metaonly module DMA inherits IDMA {

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
    
    /*! DMA interrupt enables */
    config regIntVect_t interruptSource[8];

    config regTriggerVect_t triggerSource[8][32];
    
    config UInt numberOfChannels;
    
    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
    ];

}
/*
 *  @(#) ti.catalog.msp430.peripherals.dma; 1, 0, 0,2; 1-29-2016 10:00:51; /db/ztree/library/trees/platform/platform-q17/src/
 */

