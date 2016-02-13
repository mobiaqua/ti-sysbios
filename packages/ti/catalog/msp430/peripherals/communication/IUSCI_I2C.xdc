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
 * Universal Serial Communication Interface
 */
metaonly interface IUSCI_I2C inherits IUSCI {

    //*****************************************************************
    //* REGISTER BIT DEFINITIONS                                      *
    //*****************************************************************

    /*! Own addressing mode select */
    enum UCA10_t {
        UCA10_OFF = 0x00,       /*! Own address is a 7-bit address */
        UCA10 = 0x80            /*! Own address is a 10-bit address */
    };
    
    /*! Slave addressing mode select */
    enum UCSLA10_t {
        UCSLA10_OFF = 0x00,     /*! Address slave with 7-bit address */
        UCSLA10 = 0x40          /*! Address slave with 10-bit address */
    };
    
    /*! Multi-master environment select */
    enum UCMM_t {
        UCMM_OFF = 0x00,        /*! Single master environment. There is no other master in the system. The address compare unit is disabled. */
        UCMM = 0x20             /*! Multi master environment */
    };
    
    /*! Master mode select */
    enum UCMST_t {
        UCMST_OFF = 0x00,       /*! Slave mode */
        UCMST = 0x40            /*! Master mode */
    };
    
    /*! USCI clock source select. These bits select the BRCLK source clock. */
    enum UCSSEL_I2C_t {
        UCSSEL_0 = 0x00,        /*! UCLK */
        UCSSEL_1 = 0x01,        /*! ACLK */
        UCSSEL_2 = 0x02         /*! SMCLK */
/*      UCSSEL_3 = 0x04         /*! SMCLK */
    };
    
    /*! Transmitter/Receiver */
    enum UCTR_t {
        UCTR_OFF = 0x00,        /*! Receiver */
        UCTR = 0x10             /*! Transmitter */
    };
    
    /*! Transmit a NACK */
    enum UCTXNACK_t {
        UCTXNACK_OFF = 0x00,    /*! Acknowledge normally */
        UCTXNACK = 0x08         /*! Generate NACK */
    };
    
    /*! Transmit STOP condition in master mode */
    enum UCTXSTP_t {
        UCTXSTP_OFF = 0x00,     /*! No STOP generated */
        UCTXSTP = 0x10          /*! Generate STOP */
    };
    
    /*! Transmit START condition in master mode */
    enum UCTXSTT_t {
        UCTXSTT_OFF = 0x00,     /*! Do not generate START condition */
        UCTXSTT = 0x10          /*! Generate START condition */
    };
    
    /*! SCL low */
    enum UCSCLLOW_t {
        UCSCLLOW_OFF = 0x00,    /*! SCL is not held low */
        UCSCLLOW = 0x10         /*! SCL is held low */
    };
    
    /*! General call address received */
    enum UCGC_t {
        UCGC_OFF = 0x00,        /*! No general call address received */
        UCGC = 0x10             /*! General call address received */
    };
    
    /*! Bus busy */
    enum UCBBUSY_t {
        UCBBUSY_OFF = 0x00,     /*! Bus inactive */
        UCBBUSY = 0x10          /*! Bus busy */
    };
    
    /*! Not-acknowledge received interrupt flag */
    enum UCNACKIFG_t {
        UCNACKIFG_OFF = 0x00,   /*! No interrupt pending */
        UCNACKIFG = 0x10        /*! Interrupt pending */
    };
    
    /*! Stop condition interrupt flag */
    enum UCSTPIFG_t {
        UCSTPIFG_OFF = 0x00,    /*! No interrupt pending */
        UCSTPIFG = 0x10         /*! Interrupt pending */
    };
    
    /*! Start condition interrupt flag */
    enum UCSTTIFG_t {
        UCSTTIFG_OFF = 0x00,    /*! No interrupt pending */
        UCSTTIFG = 0x10         /*! Interrupt pending */
    };
    
    /*! Arbitration lost interrupt flag */
    enum UCALIFG_t {
        UCALIFG_OFF = 0x00,     /*! No interrupt pending */
        UCALIFG = 0x10          /*! Interrupt pending */
    };
    
    /*! General call response enable */
    enum UCGCEN_t {
        UCGCEN_OFF = 0x00,      /*! Do not respond to a general call */
        UCGCEN = 0x80           /*! Respond to a general call */
    };
    
    struct UCxCTL0_t {
        UCA10_t     UCA10;      /*! Own addressing mode select
                                 *  0  Own address is a 7-bit address
                                 *  1  Own address is a 10-bit address */
        UCSLA10_t   UCSLA10;    /*! Slave addressing mode select
                                 *  0  Address slave with 7-bit address
                                 *  1  Address slave with 10-bit address */
        UCMM_t      UCMM;       /*! Multi-master environment select
                                 *  0  Single master environment. There is no other master in the system.
                                 *     The address compare unit is disabled.
                                 *  1  Multi master environment */
        UCMST_t     UCMST;      /*! Master mode select. When a master looses arbitration in a multi-master
                                 *environment (UCMM = 1) the UCMST bit is automatically cleared and the
                                 *module acts as slave.
                                 *  0  Slave mode
                                 *  1  Master mode */
        UCMODE_SYNC_t UCMODE;   /*! USCI Mode. The UCMODEx bits select the synchronous mode when
                                 *UCSYNC = 1.
                                 *  00  3-pin SPI
                                 *  01  4-pin SPI (master/slave enabled if STE = 1)
                                 *  10  4-pin SPI (master/slave enabled if STE = 0)
                                 *  11  I2C mode */
        UCSYNC_t    UCSYNC;     /*! Synchronous mode enable
                                 *  0  Asynchronous mode
                                 *  1  Synchronous mode */
    }

    struct UCxCTL1_t {
        UCSSEL_I2C_t UCSSEL;    /*! USCI clock source select. These bits select the BRCLK source clock.
                                 *  00  UCLKI
                                 *  01  ACLK
                                 *  10  SMCLK
                                 *  11  SMCLK */
        UCTR_t      UCTR;       /*! Transmitter/Receiver
                                 *  0  Receiver
                                 *  1  Transmitter */
        UCTXNACK_t  UCTXNACK;   /*! Transmit a NACK. UCTXNACK is automatically cleared after a NACK is
                                 *transmitted.
                                 *  0  Acknowledge normally
                                 *  1  Generate NACK */
        UCTXSTP_t   UCTXSTP;    /*! Transmit STOP condition in master mode. Ignored in slave mode. In
                                 *master receiver mode the STOP condition is preceded by a NACK.
                                 *UCTXSTP is automatically cleared after STOP is generated.
                                 *  0  No STOP generated
                                 *  1  Generate STOP */
        UCTXSTT_t   UCTXSTT;    /*! Transmit START condition in master mode. Ignored in slave mode. In
                                 *master receiver mode a repeated START condition is preceded by a
                                 *NACK. UCTXSTT is automatically cleared after START condition and
                                 *address information is transmitted.
                                 *Ignored in slave mode.
                                 *  0  Do not generate START condition
                                 *  1  Generate START condition */
        UCSWRST_t   UCSWRST;    /*! Software reset enable
                                 *  0  Disabled. USCI reset released for operation.
                                 *  1  Enabled. USCI logic held in reset state. */
    }

    struct UCxSTAT_t {
        UCSCLLOW_t  UCSCLLOW;   /*! SCL low
                                 *  0  SCL is not held low
                                 *  1  SCL is held low */
        UCGC_t      UCGC;       /*! General call address received. UCGC is automatically cleared when a
                                 *START condition is received.
                                 *  0  No general call address received
                                 *  1  General call address received */
        UCBBUSY_t   UCBBUSY;    /*! Bus busy
                                 *  0  Bus inactive
                                 *  1  Bus busy */
        UCNACKIFG_t UCNACKIFG;  /*! Not-acknowledge received interrupt flag. UCNACKIFG is automatically
                                 *cleared when a START condition is received.
                                 *  0  No interrupt pending
                                 *  1  Interrupt pending */
        UCSTPIFG_t  UCSTPIFG;   /*!  Stop condition interrupt flag. UCSTPIFG is automatically cleared when a
                                 *START condition is received.
                                 *  0  No interrupt pending
                                 *  1  Interrupt pending */
        UCSTTIFG_t  UCSTTIFG;   /*! Start condition interrupt flag. UCSTTIFG is automatically cleared if a STOP
                                 *condition is received.
                                 *  0  No interrupt pending
                                 *  1  Interrupt pending */
        UCALIFG_t   UCALIFG;    /*! Arbitration lost interrupt flag
                                 *  0  No interrupt pending
                                 *  1  Interrupt pending */
    }
    
    struct UCBxI2COA_t {
        UCGCEN_t    UCGCEN;     /*! General call response enable
                                 *  0  Do not respond to a general call
                                 *  1  Respond to a general call */
        Bits16      I2COA;      /*! I2C own address. The I2COAx bits contain the local address of the USCI_Bx
                                 *I2C controller. The address is right-justified. In 7-bit addressing mode Bit 6 is
                                 *the MSB, Bits 9-7 are ignored. In 10-bit addressing mode Bit 9 is the MSB. */
    }

instance:
    /*!
    *  ======== getUCBxI2CSA ========
    *  Returns UCBxI2CSA register value based on which module
    *
    *  @see #getUCBxI2CSA
    */
    Bits8 getUCBxI2CSA();

    /*!
    *  ======== setUCBxI2CSA ========
    *  Sets UCxxI2CSA register value based on which module
    *
    *  @see #setUCBxI2CSA
    */
    void setUCBxI2CSA(Bits8 value);
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:12; /db/ztree/library/trees/platform/platform-q16/src/
 */

