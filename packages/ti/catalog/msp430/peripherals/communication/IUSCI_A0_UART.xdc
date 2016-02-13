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
 * Universal Serial Communication Interface A0 UART 2xx
 */
metaonly interface IUSCI_A0_UART inherits IUSCI_UART {

instance:
    /*! Control Register 0 */
    config UCxCTL0_t UCA0CTL0 = {
        UCPEN       : UCPEN_OFF,
        UCPAR       : UCPAR_OFF,
        UCMSB       : UCMSB_OFF,
        UC7BIT      : UC7BIT_OFF,
        UCSPB       : UCSPB_OFF,
        UCMODE      : UCMODE_0,
        UCSYNC      : UCSYNC_OFF,
    };
    
    /*! Control Register 1 */
    config UCxCTL1_t UCA0CTL1 = {
        UCSSEL      : UCSSEL_0,
        UCRXEIE     : UCRXEIE_OFF,
        UCBRKIE     : UCBRKIE_OFF,
        UCDORM      : UCDORM_OFF,
        UCTXADDR    : UCTXADDR_OFF,
        UCTXBRK     : UCTXBRK_OFF,
        UCSWRST     : UCSWRST,
    };

    /*! Modulation Control Register */
    config UCxMCTL_t UCA0MCTL = {
        UCBRF       : UCBRF_0,
        UCBRS       : UCBRS_0,
        UCOS16      : UCOS16_OFF,
    };
    
    /*! Status Register */
    config UCxSTAT_t UCA0STAT = {
        UCLISTEN    : UCLISTEN_OFF,
        UCFE        : UCFE_OFF,
        UCOE        : UCOE_OFF,
        UCPE        : UCPE_OFF,
        UCBRK       : UCBRK_OFF,
        UCRXERR     : UCRXERR_OFF,
        UCADDR      : UCADDR_OFF,
        UCIDLE      : UCIDLE_OFF,
        UCBUSY      : UCBUSY,
    };
    
    /*! IrDA Transmit Control Register */
    config UCxIRTCTL_t UCA0IRTCTL = {
        UCIRTXPL5   : UCIRTXPL5_OFF,
        UCIRTXPL4   : UCIRTXPL4_OFF,
        UCIRTXPL3   : UCIRTXPL3_OFF,
        UCIRTXPL2   : UCIRTXPL2_OFF,
        UCIRTXPL1   : UCIRTXPL1_OFF,
        UCIRTXPL0   : UCIRTXPL0_OFF,
        UCIRTXCLK   : UCIRTXCLK_OFF,
        UCIREN      : UCIREN_OFF,
    };
    
    /*! IrDA Receive Control Register */
    config UCxIRRCTL_t UCA0IRRCTL = {
        UCIRRXFL5   : UCIRRXFL5_OFF,
        UCIRRXFL4   : UCIRRXFL4_OFF,
        UCIRRXFL3   : UCIRRXFL3_OFF,
        UCIRRXFL2   : UCIRRXFL2_OFF,
        UCIRRXFL1   : UCIRRXFL1_OFF,
        UCIRRXFL0   : UCIRRXFL0_OFF,
        UCIRRXPL    : UCIRRXPL_OFF,
        UCIRRXFE    : UCIRRXFE_OFF,
    };

    /*! Auto Baud Rate Control Register */
    config UCxABCTL_t UCA0ABCTL = {
        UCDELIM1    : UCDELIM1_OFF,
        UCDELIM0    : UCDELIM0_OFF,
        UCSTOE      : UCSTOE_OFF,
        UCBTOE      : UCBTOE_OFF,
        UCABDEN     : UCABDEN_OFF,
    };
    
    /*! Receive Buffer Register */
    config Bits8 UCA0RXBUF = 0;
    
    /*! Transmit Buffer Register */
    config Bits8 UCA0TXBUF = 0;
    
    /*! Baud rate control register 0 */
    config Bits8 UCA0BR0 = 0;
    
    /*! Baud rate control register 1 */
    config Bits8 UCA0BR1 = 0;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:12; /db/ztree/library/trees/platform/platform-q16/src/
 */

