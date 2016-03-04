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
 * Universal Serial Communication Interface A1 SPI 2xx
 */
metaonly module USCI_A1_SPI_2xx inherits IUSCI_A1_SPI {
    /*
     *  ======== create ========
     */
    create(IClock.Instance clock);

    /*! USCI_A1 transmit interrupt enable */
    enum UCA1TXIE_t {
        UCA1TXIE_OFF = 0x00,    /*! Interrupt disabled */
        UCA1TXIE = 0x02         /*! Interrupt enabled */
    };

    /*! USCI_A1 receive interrupt enable */
    enum UCA1RXIE_t {
        UCA1RXIE_OFF = 0x00,     /*! Interrupt disabled */
        UCA1RXIE = 0x01          /*! Interrupt enabled */
    };

    /*! USCI_A1 SPI Interrupt Enable Register */
    struct UC1IE_t {
        UCA1TXIE_t  UCA1TXIE;   /*! USCI_A1 transmit interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
        UCA1RXIE_t  UCA1RXIE;   /*! USCI_A1 receive interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
    }

instance:
    /*! @_nodoc */
    config IClock.Instance clock;

    /*! USCI_A1 Interrupt Enable Register */
    config UC1IE_t UC1IE = {
        UCA1TXIE    : UCA1TXIE_OFF,
        UCA1RXIE    : UCA1RXIE_OFF
    };

    /*! USCI_A1 UART interrupt enables */
    config regIntVect_t interruptSource[2];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "UCA1CTL0"   , regForceSet : false },
        { register : "UCA1CTL1"   , regForceSet : false },
        { register : "UCA1BR0"    , regForceSet : false },
        { register : "UCA1BR1"    , regForceSet : false },
        { register : "UCA1STAT"   , regForceSet : false },
        { register : "UCA1RXBUF"  , regForceSet : false },
        { register : "UCA1TXBUF"  , regForceSet : false },
        { register : "UC1IE"      , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:49; /db/ztree/library/trees/platform/platform-q17/src/
 */

