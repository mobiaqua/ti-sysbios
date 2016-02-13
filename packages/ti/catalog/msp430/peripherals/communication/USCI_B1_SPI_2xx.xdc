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
 * Universal Serial Communication Interface B1 SPI 2xx
 */
metaonly module USCI_B1_SPI_2xx inherits IUSCI_B1_SPI {
    /*
     *  ======== create ========
     */
    create(IClock.Instance clock);

    /*! USCI_B1 transmit interrupt enable */
    enum UCB1TXIE_t {
        UCB1TXIE_OFF = 0x00,    /*! Interrupt disabled */
        UCB1TXIE = 0x08         /*! Interrupt enabled */
    };

    /*! USCI_B1 receive interrupt enable */
    enum UCB1RXIE_t {
        UCB1RXIE_OFF = 0x00,     /*! Interrupt disabled */
        UCB1RXIE = 0x04          /*! Interrupt enabled */
    };

    /*! USCI_xx SPI Interrupt Enable Register */
    struct UC1IE_t {
        UCB1TXIE_t  UCB1TXIE;   /*! USCI_B1 transmit interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
        UCB1RXIE_t  UCB1RXIE;   /*! USCI_B1 receive interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
    }

instance:
    /*! @_nodoc */
    config IClock.Instance clock;

    /*! USCI_B1 Interrupt Enable Register */
    config UC1IE_t UC1IE = {
        UCB1TXIE    : UCB1TXIE_OFF,
        UCB1RXIE    : UCB1RXIE_OFF
    };

    /*! USCI_A1 SPI interrupt enables */
    config regIntVect_t interruptSource[2];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "UCB1CTL0"   , regForceSet : false },
        { register : "UCB1CTL1"   , regForceSet : false },
        { register : "UCB1BR0"    , regForceSet : false },
        { register : "UCB1BR1"    , regForceSet : false },
        { register : "UCB1STAT"   , regForceSet : false },
        { register : "UCB1RXBUF"  , regForceSet : false },
        { register : "UCB1TXBUF"  , regForceSet : false },
        { register : "UC1IE"      , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:13; /db/ztree/library/trees/platform/platform-q16/src/
 */

