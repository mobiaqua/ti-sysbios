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
metaonly interface IUSCI_SPI inherits IUSCI {

    //*****************************************************************
    //* REGISTER BIT DEFINITIONS                                      *
    //*****************************************************************
    
    /*! Clock phase select. */
    enum UCCKPH_t {
        UCCKPH_OFF = 0x00,      /*! Data is changed on the first UCLK edge and captured on the following edge. */
        UCCKPH = 0x80           /*! Data is captured on the first UCLK edge and changed on the following edge. */
    };
    
    /*! Clock polarity select. */
    enum UCCKPL_t {
        UCCKPL_OFF = 0x00,      /*! Inactive state is low */
        UCCKPL = 0x40           /*! Inactive state is high */
    };
          
    /*! Master mode select */
    enum UCMST_t {
        UCMST_OFF = 0x00,       /*! Slave mode */
        UCMST = 0x40            /*! Master mode */
    };
    
    /*! USCI clock source select. These bits select the BRCLK source clock. */
    enum UCSSEL_SPI_t {
        UCSSEL_0 = 0x00,        /*! NA */
        UCSSEL_1 = 0x01,        /*! ACLK */
        UCSSEL_2 = 0x02         /*! SMCLK */
/*        UCSSEL_3 = 0x04      /*! SMCLK */
    };
    
    struct UCxCTL0_t {
        UCCKPH_t    UCCKPH;     /*! Clock phase select.
                                 *  0  Data is changed on the first UCLK edge and captured on the
                                 *     following edge.
                                 *  1  Data is captured on the first UCLK edge and changed on the
                                 *     following edge. */
        UCCKPL_t    UCCKPL;     /*! Clock polarity select
                                 *  0  The inactive state is low
                                 *  1  The inactive state is high */
        UCMSB_t     UCMSB;      /*! MSB first select. Controls the direction of the receive and transmit shift
                                 *register.
                                 *  0  LSB first
                                 *  1  MSB first */
        UC7BIT_t    UC7BIT;     /*! Character length. Selects 7-bit or 8-bit character length.
                                 *  0  8-bit data
                                 *  1  7-bit data */
        UCMST_t     UCMST;      /*! Master mode select
                                 *  0  Slave mode
                                 *  1  Master mode */
        UCMODE_SYNC_t UCMODE;   /*! USCI mode. The UCMODEx bits select the synchronous mode when
                                 *UCSYNC = 1.
                                 *  00  3-Pin SPI
                                 *  01  4-Pin SPI with UCxSTE active high: slave enabled when UCxSTE = 1
                                 *  10  4-Pin SPI with UCxSTE active low: slave enabled when UCxSTE = 0
                                 *  11  I2C Mode */
        UCSYNC_t    UCSYNC;     /*! Synchronous mode enable
                                 *  0  Asynchronous mode
                                 *  1  Synchronous Mode */
    }

    struct UCxCTL1_t {
        UCSSEL_SPI_t UCSSEL;    /*! USCI clock source select. These bits select the BRCLK source clock in
                                 *master mode. UCxCLK is always used in slave mode.
                                 *  00  NA
                                 *  01  ACLK
                                 *  10  SMCLK
                                 *  11  SMCLK */
        UCSWRST_t    UCSWRST;   /*! Software reset enable
                                 *  0  Disabled. USCI reset released for operation.
                                 *  1  Enabled. USCI logic held in reset state. */
    }
    
    struct UCxSTAT_t {
        UCLISTEN_t  UCLISTEN;   /*! Listen enable. The UCLISTEN bit selects loopback mode.
                                 *  0  Disabled
                                 *  1  Enabled. UCAxTXD is internally fed back to the receiver. */
        UCFE_t      UCFE;       /*! Framing error flag. This bit indicates a bus conflict in 4-wire master mode.
                                 *UCFE is not used in 3-wire master or any slave mode.
                                 *  0  No error
                                 *  1  Bus conflict occurred */
        UCOE_t      UCOE;       /*! Overrun error flag. This bit is set when a character is transferred into
                                 *UCAxRXBUF before the previous character was read. UCOE is cleared
                                 *automatically when UCxRXBUF is read, and must not be cleared by
                                 *software. Otherwise, it will not function correctly.
                                 *  0  No error
                                 *  1  Overrun error occurred */
        UCBUSY_t    UCBUSY;     /*! USCI busy. This bit indicates if a transmit or receive operation is in
                                 *progress.
                                 *  0  USCI inactive
                                 *  1  USCI transmitting or receiving */
    }
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:48; /db/ztree/library/trees/platform/platform-q17/src/
 */

