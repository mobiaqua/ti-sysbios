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
 *  ======== IE2 ========
 *  MSP430 Interrupt Enable Register 2
 */
metaonly module IE2 inherits xdc.platform.IPeripheral {

    /* USCI_B0 transmit interrupt enable */
    enum UCB0TXIE_t {
        UCB0TXIE_OFF = 0x00,            /*! Interrupt disabled */
        UCB0TXIE     = 0x08             /*! Interrupt enabled */
    };

    /* USCI_B0 receive interrupt enable */
    enum UCB0RXIE_t {
        UCB0RXIE_OFF = 0x00,            /*! Interrupt disabled */
        UCB0RXIE     = 0x04             /*! Interrupt enabled */
    };

    /* USCI_A0 transmit interrupt enable */
    enum UCA0TXIE_t {
        UCA0TXIE_OFF = 0x00,            /*! Interrupt disabled */
        UCA0TXIE     = 0x02             /*! Interrupt enabled */
    };

    /* USCI_A0 receive interrupt enable */
    enum UCA0RXIE_t {
        UCA0RXIE_OFF = 0x00,            /*! Interrupt disabled */
        UCA0RXIE     = 0x01             /*! Interrupt enabled */
    };

    /* USCI_B0 transmit interrupt flag */
    enum UCB0TXIFG_t {
        UCB0TXIFG_OFF = 0x00,           /*! No interrupt pending */
        UCB0TXIFG     = 0x08            /*! Interrupt pending */
    };

    /* USCI_B0 receive interrupt flag */
    enum UCB0RXIFG_t {
        UCB0RXIFG_OFF = 0x00,           /*! No interrupt pending */
        UCB0RXIFG     = 0x04            /*! Interrupt pending */
    };

    /* USCI_A0 transmit interrupt flag */
    enum UCA0TXIFG_t {
        UCA0TXIFG_OFF = 0x00,           /*! No interrupt pending */
        UCA0TXIFG     = 0x02            /*! Interrupt pending */
    };

    /* USCI_A0 receive interrupt flag */
    enum UCA0RXIFG_t {
        UCA0RXIFG_OFF = 0x00,           /*! No interrupt pending */
        UCA0RXIFG     = 0x01            /*! Interrupt pending */
    };

    /*! IE2, Interrupt Enable Register 2 */
    struct IE2_t {
        UCB0TXIE_t  UCB0TXIE;           /*! USCI_B0 transmit interrupt enable
                                         *  0 Interrupt disabled
                                         *  1 Interrupt enabled */
        UCB0RXIE_t  UCB0RXIE;           /*! USCI_B0 receive interrupt enable
                                         *  0 Interrupt disabled
                                         *  1 Interrupt enabled */
        UCA0TXIE_t  UCA0TXIE;           /*! USCI_A0 transmit interrupt enable
                                         *  0 Interrupt disabled
                                         *  1 Interrupt enabled */
        UCA0RXIE_t  UCA0RXIE;           /*! USCI_A0 receive interrupt enable
                                         *  0 Interrupt disabled
                                         *  1 Interrupt enabled */
    }

    /*! IFG2, Interrupt Flag Register 2 */
    struct IFG2_t {
        UCB0TXIFG_t  UCB0TXIFG;         /*! USCI_B0 transmit interrupt flag
                                         *  0 No interrupt pending
                                         *  1 Interrupt pending */
        UCB0RXIFG_t  UCB0RXIFG;         /*! USCI_B0 receive interrupt flag
                                         *  0 No interrupt pending
                                         *  1 Interrupt pending */
        UCA0TXIFG_t  UCA0TXIFG;         /*! USCI_A0 transmit interrupt flag
                                         *  0 No interrupt pending
                                         *  1 Interrupt pending */
        UCA0RXIFG_t  UCA0RXIFG;         /*! USCI_A0 receive interrupt flag
                                         *  0 No interrupt pending
                                         *  1 Interrupt pending */
    }

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

instance:
    /*! IE2, Interrupt Enable Register 2 */
    config IE2_t IE2 = {
        UCB0TXIE    : UCB0TXIE_OFF,
        UCB0RXIE    : UCB0RXIE_OFF,
        UCA0TXIE    : UCA0TXIE_OFF,
        UCA0RXIE    : UCA0RXIE_OFF,
    };

    /*! IFG2, Interrupt Flag Register 2 */
    config IFG2_t IFG2 = {
        UCB0TXIFG   : UCB0TXIFG_OFF,
        UCB0RXIFG   : UCB0RXIFG_OFF,
        UCA0TXIFG   : UCA0TXIFG_OFF,
        UCA0RXIFG   : UCA0RXIFG_OFF,
    };

   /*!
    *  ======== getUCB0TXIE ========
    *  Gets UCB0TXIE bit
    *
    *  @see #getUCB0TXIE
    */
    Bool    getUCB0TXIE();

   /*!
    *  ======== setUCB0TXIE ========
    *  Sets UCB0TXIE bit
    *
    *  @see #setUCB0TXIE
    */
    Bool    setUCB0TXIE(Bool set);

   /*!
    *  ======== getUCB0RXIE ========
    *  Gets UCB0RXIE bit
    *
    *  @see #getUCB0RXIE
    */
    Bool    getUCB0RXIE();

   /*!
    *  ======== setUCB0RXIE ========
    *  Sets UCB0RXIE bit
    *
    *  @see #setUCB0RXIE
    */
    Bool    setUCB0RXIE(Bool set);

   /*!
    *  ======== getUCA0TXIE ========
    *  Gets UCA0TXIE bit
    *
    *  @see #getUCA0TXIE
    */
    Bool    getUCA0TXIE();

   /*!
    *  ======== setUCA0TXIE ========
    *  Sets UCA0TXIE bit
    *
    *  @see #setUCA0TXIE
    */
    Bool    setUCA0TXIE(Bool set);

   /*!
    *  ======== getUCA0RXIE ========
    *  Gets UCA0RXIE bit
    *
    *  @see #getUCA0RXIE
    */
    Bool    getUCA0RXIE();

   /*!
    *  ======== setUCA0RXIE ========
    *  Sets UCA0RXIE bit
    *
    *  @see #setUCA0RXIE
    */
    Bool    setUCA0RXIE(Bool set);

    /*! IE2 interrupt enables
     */
    config regIntVect_t interruptSource[8];

    /*!
     *  ======== forceSetDefaultRegister ========
     *  Determine if each Register needs to be forced set or not
     */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "IE2" , regForceSet : false },
        { register : "IFG2" , regForceSet : false },
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.special_function; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

