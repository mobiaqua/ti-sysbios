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

/*
 *  ======== EUSCI_B0.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(clock)
{
    this.clock = clock;
    
    this.interruptSource[0].registerName = "UCTXIE0";
    this.interruptSource[0].registerDescription = "eUSCI_B0 SPI/I2C Transmit Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;
    
    this.interruptSource[1].registerName = "UCRXIE0";
    this.interruptSource[1].registerDescription = "eUSCI_B0 SPI/I2C Receive Interrupt Enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;
    
    this.interruptSource[2].registerName = "UCTXIE1";
    this.interruptSource[2].registerDescription = "eUSCI_B0 I2C Transmit Interrupt Enable 1";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;
    
    this.interruptSource[3].registerName = "UCRXIE1";
    this.interruptSource[3].registerDescription = "eUSCI_B0 I2C Receive Interrupt Enable 1";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;
    
    this.interruptSource[4].registerName = "UCTXIE2";
    this.interruptSource[4].registerDescription = "eUSCI_B0 I2C Transmit Interrupt Enable 2";
    this.interruptSource[4].interruptEnable = false;
    this.interruptSource[4].interruptHandler = false;
    
    this.interruptSource[5].registerName = "UCRXIE2";
    this.interruptSource[5].registerDescription = "eUSCI_B0 I2C Receive Interrupt Enable 2";
    this.interruptSource[5].interruptEnable = false;
    this.interruptSource[5].interruptHandler = false;
    
    this.interruptSource[6].registerName = "UCTXIE3";
    this.interruptSource[6].registerDescription = "eUSCI_B0 I2C Transmit Interrupt Enable 3";
    this.interruptSource[6].interruptEnable = false;
    this.interruptSource[6].interruptHandler = false;
    
    this.interruptSource[7].registerName = "UCRXIE3";
    this.interruptSource[7].registerDescription = "eUSCI_B0 I2C Receive Interrupt Enable 3";
    this.interruptSource[7].interruptEnable = false;
    this.interruptSource[7].interruptHandler = false;
    
    this.interruptSource[8].registerName = "UCSTTIE";
    this.interruptSource[8].registerDescription = "eUSCI_B0 I2C START Condition Interrupt Enable";
    this.interruptSource[8].interruptEnable = false;
    this.interruptSource[8].interruptHandler = false;
    
    this.interruptSource[9].registerName = "UCSTPIE";
    this.interruptSource[9].registerDescription = "eUSCI_B0 I2C STOP Condition Interrupt Enable";
    this.interruptSource[9].interruptEnable = false;
    this.interruptSource[9].interruptHandler = false;
    
    this.interruptSource[10].registerName = "UCNACKIE";
    this.interruptSource[10].registerDescription = "eUSCI_B0 I2C Not-acknowledge Interrupt Enable";
    this.interruptSource[10].interruptEnable = false;
    this.interruptSource[10].interruptHandler = false;
    
    this.interruptSource[11].registerName = "UCALIE";
    this.interruptSource[11].registerDescription = "eUSCI_B0 I2C Arbitration Lost Interrupt Enable";
    this.interruptSource[11].interruptEnable = false;
    this.interruptSource[11].interruptHandler = false;
    
    this.interruptSource[12].registerName = "UCCLTOIE";
    this.interruptSource[12].registerDescription = "eUSCI_B0 I2C Clock Low Timeout Interrupt Enable";
    this.interruptSource[12].interruptEnable = false;
    this.interruptSource[12].interruptHandler = false;
    
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:48; /db/ztree/library/trees/platform/platform-q17/src/
 */

