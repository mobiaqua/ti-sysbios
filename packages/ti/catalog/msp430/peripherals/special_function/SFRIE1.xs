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
 *  ======== SFRIE1.xs ========
 */
var REGS;
var GetSet;
/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    REGS = this;
    GetSet = xdc.module("xdc.services.getset.GetSet");
}

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
    // Activate getter/setter support on current instance
    GetSet.init(this);

    /* MSP430.xs defines all of the priority. JSON is not used because it overwrites the values from MSP430
     * instead of adding to the necessary name */
    this.interruptSource[0].registerName = "WDTIE";
    this.interruptSource[0].registerDescription = "WDT Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "OFIE";
    this.interruptSource[1].registerDescription = "Oscillator Fault Interrupt Enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "";
    this.interruptSource[2].registerDescription = "";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "VMAIE";
    this.interruptSource[3].registerDescription = "NMI Pin Interrupt Enable";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;

    this.interruptSource[4].registerName = "NMIIE";
    this.interruptSource[4].registerDescription = "NMI Pin Interrupt Enable";
    this.interruptSource[4].interruptEnable = false;
    this.interruptSource[4].interruptHandler = false;

    this.interruptSource[5].registerName = "ACCTEIE";
    this.interruptSource[5].registerDescription = "FRAM Access Time Error Interrupt Enable";
    this.interruptSource[5].interruptEnable = false;
    this.interruptSource[5].interruptHandler = false;

    this.interruptSource[6].registerName = "JMBINIE";
    this.interruptSource[6].registerDescription = "JTAG Mailbox Input Interrupt Enable";
    this.interruptSource[6].interruptEnable = false;
    this.interruptSource[6].interruptHandler = false;

    this.interruptSource[7].registerName = "JMBOUTIE";
    this.interruptSource[7].registerDescription = "JTAG Mailbox Output Interrupt Enable";
    this.interruptSource[7].interruptEnable = false;
    this.interruptSource[7].interruptHandler = false;
}



/*
 *  ======== getACCVIE ========
 */
function getSFRIE1(register)
{
    var REGS = this.$module;

    if(this.IE1.ACCVIE == REGS.ACCVIE)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setACCVIE ========
 */
function setSFRIE1(register, set)
{
    var REGS = this.$module;
    if(set)
    {
        this.IE1.ACCVIE = REGS.ACCVIE;
    }
    else
    {
        this.IE1.ACCVIE = REGS.ACCVIE_OFF;
    }

    return set;
}

/*
 *  @(#) ti.catalog.msp430.peripherals.special_function; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

