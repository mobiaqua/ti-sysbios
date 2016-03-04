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
 * Universal Serial Communication Interface B0 I2C 2xx
 */
metaonly interface IUSCI_B0_I2C inherits IUSCI_I2C {

instance:
    /*! Control Register 0 */
    config UCxCTL0_t UCB0CTL0 = {
        UCA10       : UCA10_OFF,
        UCSLA10     : UCSLA10_OFF,
        UCMM        : UCMM_OFF,
        UCMST       : UCMST_OFF,
        UCMODE      : UCMODE_0,
        UCSYNC      : UCSYNC,
    };

    /*! Control Register 1 */
    config UCxCTL1_t UCB0CTL1 = {
        UCSSEL      : UCSSEL_0,
        UCTR        : UCTR_OFF,
        UCTXNACK    : UCTXNACK_OFF,
        UCTXSTP     : UCTXSTP_OFF,
        UCTXSTT     : UCTXSTT_OFF,
        UCSWRST     : UCSWRST,
    };

    /*! Status Register */
    config UCxSTAT_t UCB0STAT = {
        UCSCLLOW    : UCSCLLOW,
        UCGC        : UCGC,
        UCBBUSY     : UCBBUSY,
        UCNACKIFG   : UCNACKIFG,
        UCSTPIFG    : UCSTPIFG,
        UCSTTIFG    : UCSTTIFG,
        UCALIFG     : UCALIFG,
    };
    
    /*! I2C Own Address Register */
    config UCBxI2COA_t UCB0I2COA = {
        UCGCEN      : UCGCEN_OFF,
        I2COA       : 0,
    };

    /*! I2C Slave Address Register */
    config Bits8 UCB0I2CSA = 0;
    
    /*! Receive Buffer Register */
    config Bits8 UCB0RXBUF = 0;
    
    /*! Transmit Buffer Register */
    config Bits8 UCB0TXBUF = 0;
    
    /*! Bit Rate Control Register 0 */
    config Bits8 UCB0BR0 = 0;
    
    /*! Bit Rate Control Register 1 */
    config Bits8 UCB0BR1 = 0;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:48; /db/ztree/library/trees/platform/platform-q17/src/
 */

