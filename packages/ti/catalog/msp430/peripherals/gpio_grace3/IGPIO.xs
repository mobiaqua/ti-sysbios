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
 *  ======== IGPIO.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
    this.interruptSource[0].registerName = "P1IE.0";
    this.interruptSource[0].registerDescription = "Port1 Interrupt Enable Bit 0";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "P1IE.1";
    this.interruptSource[1].registerDescription = "Port1 Interrupt Enable Bit 1";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "P1IE.2";
    this.interruptSource[2].registerDescription = "Port1 Interrupt Enable Bit 2";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "P1IE.3";
    this.interruptSource[3].registerDescription = "Port1 Interrupt Enable Bit 3";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;

    this.interruptSource[4].registerName = "P1IE.4";
    this.interruptSource[4].registerDescription = "Port1 Interrupt Enable Bit 4";
    this.interruptSource[4].interruptEnable = false;
    this.interruptSource[4].interruptHandler = false;

    this.interruptSource[5].registerName = "P1IE.5";
    this.interruptSource[5].registerDescription = "Port1 Interrupt Enable Bit 5";
    this.interruptSource[5].interruptEnable = false;
    this.interruptSource[5].interruptHandler = false;

    this.interruptSource[6].registerName = "P1IE.6";
    this.interruptSource[6].registerDescription = "Port1 Interrupt Enable Bit 6";
    this.interruptSource[6].interruptEnable = false;
    this.interruptSource[6].interruptHandler = false;

    this.interruptSource[7].registerName = "P1IE.7";
    this.interruptSource[7].registerDescription = "Port1 Interrupt Enable Bit 7";
    this.interruptSource[7].interruptEnable = false;
    this.interruptSource[7].interruptHandler = false;

    this.interruptSource[8].registerName = "P2IE.0";
    this.interruptSource[8].registerDescription = "Port2 Interrupt Enable Bit 0";
    this.interruptSource[8].interruptEnable = false;
    this.interruptSource[8].interruptHandler = false;

    this.interruptSource[9].registerName = "P2IE.1";
    this.interruptSource[9].registerDescription = "Port2 Interrupt Enable Bit 1";
    this.interruptSource[9].interruptEnable = false;
    this.interruptSource[9].interruptHandler = false;

    this.interruptSource[10].registerName = "P2IE.2";
    this.interruptSource[10].registerDescription = "Port2 Interrupt Enable Bit 2";
    this.interruptSource[10].interruptEnable = false;
    this.interruptSource[10].interruptHandler = false;

    this.interruptSource[11].registerName = "P2IE.3";
    this.interruptSource[11].registerDescription = "Port2 Interrupt Enable Bit 3";
    this.interruptSource[11].interruptEnable = false;
    this.interruptSource[11].interruptHandler = false;

    this.interruptSource[12].registerName = "P2IE.4";
    this.interruptSource[12].registerDescription = "Port2 Interrupt Enable Bit 4";
    this.interruptSource[12].interruptEnable = false;
    this.interruptSource[12].interruptHandler = false;

    this.interruptSource[13].registerName = "P2IE.5";
    this.interruptSource[13].registerDescription = "Port2 Interrupt Enable Bit 5";
    this.interruptSource[13].interruptEnable = false;
    this.interruptSource[13].interruptHandler = false;

    this.interruptSource[14].registerName = "P2IE.6";
    this.interruptSource[14].registerDescription = "Port2 Interrupt Enable Bit 6";
    this.interruptSource[14].interruptEnable = false;
    this.interruptSource[14].interruptHandler = false;

    this.interruptSource[15].registerName = "P2IE.7";
    this.interruptSource[15].registerDescription = "Port2 Interrupt Enable Bit 7";
    this.interruptSource[15].interruptEnable = false;
    this.interruptSource[15].interruptHandler = false;

    this.interruptSource[16].registerName = "P3IE.0";
    this.interruptSource[16].registerDescription = "Port3 Interrupt Enable Bit 0";
    this.interruptSource[16].interruptEnable = false;
    this.interruptSource[16].interruptHandler = false;

    this.interruptSource[17].registerName = "P3IE.1";
    this.interruptSource[17].registerDescription = "Port3 Interrupt Enable Bit 1";
    this.interruptSource[17].interruptEnable = false;
    this.interruptSource[17].interruptHandler = false;

    this.interruptSource[18].registerName = "P3IE.2";
    this.interruptSource[18].registerDescription = "Port3 Interrupt Enable Bit 2";
    this.interruptSource[18].interruptEnable = false;
    this.interruptSource[18].interruptHandler = false;

    this.interruptSource[19].registerName = "P3IE.3";
    this.interruptSource[19].registerDescription = "Port3 Interrupt Enable Bit 3";
    this.interruptSource[19].interruptEnable = false;
    this.interruptSource[19].interruptHandler = false;

    this.interruptSource[20].registerName = "P3IE.4";
    this.interruptSource[20].registerDescription = "Port3 Interrupt Enable Bit 4";
    this.interruptSource[20].interruptEnable = false;
    this.interruptSource[20].interruptHandler = false;

    this.interruptSource[21].registerName = "P3IE.5";
    this.interruptSource[21].registerDescription = "Port3 Interrupt Enable Bit 5";
    this.interruptSource[21].interruptEnable = false;
    this.interruptSource[21].interruptHandler = false;

    this.interruptSource[22].registerName = "P3IE.6";
    this.interruptSource[22].registerDescription = "Port3 Interrupt Enable Bit 6";
    this.interruptSource[22].interruptEnable = false;
    this.interruptSource[22].interruptHandler = false;

    this.interruptSource[23].registerName = "P3IE.7";
    this.interruptSource[23].registerDescription = "Port3 Interrupt Enable Bit 7";
    this.interruptSource[23].interruptEnable = false;
    this.interruptSource[23].interruptHandler = false;

    this.interruptSource[24].registerName = "P4IE.0";
    this.interruptSource[24].registerDescription = "Port4 Interrupt Enable Bit 0";
    this.interruptSource[24].interruptEnable = false;
    this.interruptSource[24].interruptHandler = false;

    this.interruptSource[25].registerName = "P4IE.1";
    this.interruptSource[25].registerDescription = "Port4 Interrupt Enable Bit 1";
    this.interruptSource[25].interruptEnable = false;
    this.interruptSource[25].interruptHandler = false;

    this.interruptSource[26].registerName = "P4IE.2";
    this.interruptSource[26].registerDescription = "Port4 Interrupt Enable Bit 2";
    this.interruptSource[26].interruptEnable = false;
    this.interruptSource[26].interruptHandler = false;

    this.interruptSource[27].registerName = "P4IE.3";
    this.interruptSource[27].registerDescription = "Port4 Interrupt Enable Bit 3";
    this.interruptSource[27].interruptEnable = false;
    this.interruptSource[27].interruptHandler = false;

    this.interruptSource[28].registerName = "P4IE.4";
    this.interruptSource[28].registerDescription = "Port4 Interrupt Enable Bit 4";
    this.interruptSource[28].interruptEnable = false;
    this.interruptSource[28].interruptHandler = false;

    this.interruptSource[29].registerName = "P4IE.5";
    this.interruptSource[29].registerDescription = "Port4 Interrupt Enable Bit 5";
    this.interruptSource[29].interruptEnable = false;
    this.interruptSource[29].interruptHandler = false;

    this.interruptSource[30].registerName = "P4IE.6";
    this.interruptSource[30].registerDescription = "Port4 Interrupt Enable Bit 6";
    this.interruptSource[30].interruptEnable = false;
    this.interruptSource[30].interruptHandler = false;

    this.interruptSource[31].registerName = "P4IE.7";
    this.interruptSource[31].registerDescription = "Port4 Interrupt Enable Bit 7";
    this.interruptSource[31].interruptEnable = false;
    this.interruptSource[31].interruptHandler = false;

    // Store handle for current instance
    iGPIO = this;
}

/*
 *  @(#) ti.catalog.msp430.peripherals.gpio_grace3; 1, 0, 0,2; 1-29-2016 10:00:52; /db/ztree/library/trees/platform/platform-q17/src/
 */

