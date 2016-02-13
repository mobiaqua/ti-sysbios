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
 * Universal Serial Communication Interface A1 SPI 2xx
 */
metaonly interface IUSCI_A1_SPI inherits IUSCI_SPI {

instance:
    /*! Control Register 0 */
    config UCxCTL0_t UCA1CTL0 = {
        UCCKPH      : UCCKPH_OFF,
        UCCKPL      : UCCKPL_OFF,
        UCMSB       : UCMSB_OFF,
        UC7BIT      : UC7BIT_OFF,
        UCMST       : UCMST_OFF,
        UCMODE      : UCMODE_0,
        UCSYNC      : UCSYNC,
    };

    /*! Control Register 1 */    
    config UCxCTL1_t UCA1CTL1 = {
        UCSSEL      : UCSSEL_0,
        UCSWRST     : UCSWRST,
    };
  
    /*! Status Register */
    config UCxSTAT_t UCA1STAT = {
        UCLISTEN    : UCLISTEN_OFF,
        UCFE        : UCFE_OFF,
        UCOE        : UCOE_OFF,
        UCBUSY      : UCBUSY,
    };

    /*! Bit Rate Control Register 0 */
    config Bits8 UCA1BR0 = 0;
    
    /*! Bit Rate Control Register 1 */
    config Bits8 UCA1BR1 = 0;
    
    /*! Receive Buffer Register */
    config Bits8 UCA1RXBUF = 0;
    
    /*! Transmit Buffer Register */
    config Bits8 UCA1TXBUF = 0;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:12; /db/ztree/library/trees/platform/platform-q16/src/
 */

