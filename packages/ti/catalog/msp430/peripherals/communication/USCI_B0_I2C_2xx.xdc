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
 * Universal Serial Communication Interface B0 I2C 2xx
 */
metaonly module USCI_B0_I2C_2xx inherits IUSCI_B0_I2C {

    /*
     *  ======== create ========
     */
    create(IClock.Instance clock);

    /*! Not-acknowledge interrupt enable */
    enum UCNACKIE_t {
        UCNACKIE_OFF = 0x00,    /*! Interrupt disabled */
        UCNACKIE = 0x80         /*! Interrupt enabled */
    };

    /*! Stop condition interrupt enable */
    enum UCSTPIE_t {
        UCSTPIE_OFF = 0x00,     /*! Interrupt disabled */
        UCSTPIE = 0x80          /*! Interrupt enabled */
    };

    /*! Start condition interrupt enable */
    enum UCSTTIE_t {
        UCSTTIE_OFF = 0x00,     /*! Interrupt disabled */
        UCSTTIE = 0x80          /*! Interrupt enabled */
    };

    /*! Arbitration lost interrupt enable */
    enum UCALIE_t {
        UCALIE_OFF = 0x00,      /*! Interrupt disabled */
        UCALIE = 0x80           /*! Interrupt enabled */
    };

    /*! USCI_Bx I2C Interrupt Enable Register */
    struct UCBxI2CIE_t {
        UCNACKIE_t  UCNACKIE;   /*! Not-acknowledge interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
        UCSTPIE_t   UCSTPIE;    /*! Stop condition interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
        UCSTTIE_t   UCSTTIE;    /*! Start condition interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
        UCALIE_t    UCALIE;    /*! Arbitration lost interrupt enable
                                 *  0  Interrupt disabled
                                 *  1  Interrupt enabled */
    }

instance:
    /*! @_nodoc */
    config IClock.Instance clock;

    /*! USCI_Bx I2C Interrupt Enable Register */
    config UCBxI2CIE_t UCB0I2CIE = {
        UCNACKIE    : UCNACKIE_OFF,
        UCSTPIE     : UCSTPIE_OFF,
        UCSTTIE     : UCSTTIE_OFF,
        UCALIE      : UCALIE_OFF,
    };

   /*!
    *  ======== setUCNACKIE ========
    *  Sets UCNACKIE bit
    *
    *  @see #setUCNACKIE
    */
    Bool setUCNACKIE(Bool set);

   /*!
    *  ======== getUCNACKIE ========
    *  Gets UCNACKIE bit
    *
    *  @see #getUCNACKIE
    */
    Bool getUCNACKIE();

   /*!
    *  ======== setUCSTPIE ========
    *  Sets UCSTPIE bit
    *
    *  @see #setUCSTPIE
    */
    Bool setUCSTPIE(Bool set);

   /*!
    *  ======== getUCSTPIE ========
    *  Gets UCSTPIE bit
    *
    *  @see #getUCSTPIE
    */
    Bool getUCSTPIE();

   /*!
    *  ======== setUCSTTIE ========
    *  Sets UCSTTIE bit
    *
    *  @see #setUCSTTIE
    */
    Bool setUCSTTIE(Bool set);

   /*!
    *  ======== getUCSTTIE ========
    *  Gets UCSTTIE bit
    *
    *  @see #getUCSTTIE
    */
    Bool getUCSTTIE();

   /*!
    *  ======== setUCALIE ========
    *  Sets UCALIE bit
    *
    *  @see #setUCALIE
    */
    Bool setUCALIE(Bool set);

   /*!
    *  ======== getUCALIE ========
    *  Gets UCALIE bit
    *
    *  @see #getUCALIE
    */
    Bool getUCALIE();

    /*! USCI_B0 I2C interrupt enables */
    config regIntVect_t interruptSource[4];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "UCB0CTL0"   , regForceSet : false },
        { register : "UCB0CTL1"   , regForceSet : false },
        { register : "UCB0BR0"    , regForceSet : false },
        { register : "UCB0BR1"    , regForceSet : false },
        { register : "UCB0STAT"   , regForceSet : false },
        { register : "UCB0RXBUF"  , regForceSet : false },
        { register : "UCB0TXBUF"  , regForceSet : false },
        { register : "UCB0I2COA"  , regForceSet : false },
        { register : "UCB0I2CSA"  , regForceSet : false },
        { register : "UCB0I2CIE"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:13; /db/ztree/library/trees/platform/platform-q16/src/
 */

