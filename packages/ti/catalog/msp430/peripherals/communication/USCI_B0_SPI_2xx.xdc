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
 * Universal Serial Communication Interface B0 SPI 2xx
 */
metaonly module USCI_B0_SPI_2xx inherits IUSCI_B0_SPI {

    /*
     *  ======== create ========
     */
    create(IClock.Instance clock);
    
instance:
    /*! @_nodoc */
    config IClock.Instance clock;

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "UCB0CTL0"   , regForceSet : false },
        { register : "UCB0CTL1"   , regForceSet : false },
        { register : "UCB0BR0"    , regForceSet : false },
        { register : "UCB0BR1"    , regForceSet : false },
        { register : "UCB0STAT"   , regForceSet : false },
        { register : "UCB0RXBUF"  , regForceSet : false },
        { register : "UCB0TXBUF"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:49; /db/ztree/library/trees/platform/platform-q17/src/
 */

