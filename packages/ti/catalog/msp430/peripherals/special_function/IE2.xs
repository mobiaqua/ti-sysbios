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
 *  ======== IE2.xs ========
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
    GetSet.init(this.IE2);

    /* save "this" for use inside setter */
    var inst = this;
    var group = GetSet.createGroup();

    this.interruptSource[0].registerName = "UCA0RXIE for UART";
    this.interruptSource[0].registerDescription = "USCI_A0 UART receive interrupt enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "UCA0TXIE for UART";
    this.interruptSource[1].registerDescription = "USCI_A0 UART transmit interrupt enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "UCA0RXIE for SPI";
    this.interruptSource[2].registerDescription = "USCI_A0 SPI receive interrupt enable";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "UCA0TXIE for SPI";
    this.interruptSource[3].registerDescription = "USCI_A0 SPI transmit interrupt enable";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;

    this.interruptSource[4].registerName = "UCB0RXIE for SPI";
    this.interruptSource[4].registerDescription = "USCI_B0 SPI receive interrupt enable";
    this.interruptSource[4].interruptEnable = false;
    this.interruptSource[4].interruptHandler = false;

    this.interruptSource[5].registerName = "UCB0TXIE for SPI";
    this.interruptSource[5].registerDescription = "USCI_B0 SPI transmit interrupt enable";
    this.interruptSource[5].interruptEnable = false;
    this.interruptSource[5].interruptHandler = false;

    this.interruptSource[6].registerName = "UCB0RXIE for I2C";
    this.interruptSource[6].registerDescription = "USCI_B0 I2C receive interrupt enable";
    this.interruptSource[6].interruptEnable = false;
    this.interruptSource[6].interruptHandler = false;

    this.interruptSource[7].registerName = "UCB0TXIE for I2C";
    this.interruptSource[7].registerDescription = "USCI_B0 I2C transmit interrupt enable";
    this.interruptSource[7].interruptEnable = false;
    this.interruptSource[7].interruptHandler = false;

    function monitorUcb0TxIe() {
        if (inst.IE2.UCB0TXIE == REGS.UCB0TXIE) {
            inst.IFG2.UCB0TXIFG = REGS.UCB0TXIFG;
        }
        else {
            inst.IFG2.UCB0TXIFG = REGS.UCB0TXIFG_OFF;
        }
    }
    group.onSet(inst.IE2, "UCB0TXIE", monitorUcb0TxIe);

    function monitorUcb0RxIe() {
        if (inst.IE2.UCB0RXIE == REGS.UCB0RXIE) {
            inst.IFG2.UCB0RXIFG = REGS.UCB0RXIFG;
        }
        else {
            inst.IFG2.UCB0RXIFG = REGS.UCB0RXIFG_OFF;
        }
    }
    group.onSet(inst.IE2, "UCB0RXIE", monitorUcb0RxIe);

    function monitorUca0TxIe() {
        if (inst.IE2.UCA0TXIE == REGS.UCA0TXIE) {
            inst.IFG2.UCA0TXIFG = REGS.UCA0TXIFG;
        }
        else {
            inst.IFG2.UCA0TXIFG = REGS.UCA0TXIFG_OFF;
        }
    }
    group.onSet(inst.IE2, "UCA0TXIE", monitorUca0TxIe);

    function monitorUca0RxIe() {
        if (inst.IE2.UCA0RXIE == REGS.UCA0RXIE) {
            inst.IFG2.UCA0RXIFG = REGS.UCA0RXIFG;
        }
        else {
            inst.IFG2.UCA0RXIFG = REGS.UCA0RXIFG_OFF;
        }
    }
    group.onSet(inst.IE2, "UCA0RXIE", monitorUca0RxIe);
}

/*
 *  ======== getUCB0TXIE ========
 */
function getUCB0TXIE()
{
    var REGS = this.$module;
    if (this.IE2.UCB0TXIE == REGS.UCB0TXIE) {
        return true;
    }
    else {
        return false;
    }
}

/*
 *  ======== setUCB0TXIE ========
 */
function setUCB0TXIE(set)
{
    var REGS = this.$module;

    if (set) {
        this.IE2.UCB0TXIE = REGS.UCB0TXIE;
    }
    else {
        this.IE2.UCB0TXIE = REGS.UCB0TXIE_OFF;
    }

    return set;
}

/*
 *  ======== getUCB0RXIE ========
 */
function getUCB0RXIE()
{
    var REGS = this.$module;
    if (this.IE2.UCB0RXIE == REGS.UCB0RXIE) {
        return true;
    }
    else {
        return false;
    }
}

/*
 *  ======== setUCB0RXIE ========
 */
function setUCB0RXIE(set)
{
    var REGS = this.$module;

    if (set) {
        this.IE2.UCB0RXIE = REGS.UCB0RXIE;
    }
    else {
        this.IE2.UCB0RXIE = REGS.UCB0RXIE_OFF;
    }

    return set;
}

/*
 *  ======== getUCA0TXIE ========
 */
function getUCA0TXIE()
{
    var REGS = this.$module;
    if (this.IE2.UCA0TXIE == REGS.UCA0TXIE) {
        return true;
    }
    else {
        return false;
    }
}

/*
 *  ======== setUCA0TXIE ========
 */
function setUCA0TXIE(set)
{
    var REGS = this.$module;

    if (set) {
        this.IE2.UCA0TXIE = REGS.UCA0TXIE;
    }
    else {
        this.IE2.UCA0TXIE = REGS.UCA0TXIE_OFF;
    }

    return set;
}

/*
 *  ======== getUCA0RXIE ========
 */
function getUCA0RXIE()
{
    var REGS = this.$module;
    if (this.IE2.UCA0RXIE == REGS.UCA0RXIE) {
        return true;
    }
    else {
        return false;
    }
}

/*
 *  ======== setUCA0RXIE ========
 */
function setUCA0RXIE(set)
{
    var REGS = this.$module;

    if (set) {
        this.IE2.UCA0RXIE = REGS.UCA0RXIE;
    }
    else {
        this.IE2.UCA0RXIE = REGS.UCA0RXIE_OFF;
    }

    return set;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.special_function; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

