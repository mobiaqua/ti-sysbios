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
 *  ======== USCI_A1_SPI_2xx.xs ========
 */

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
}

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(clock)
{
    this.clock = clock;

    this.interruptSource[0].registerName = "UCA1TXIE for SPI";
    this.interruptSource[0].registerDescription = "USCI_A1 SPI transmit interrupt enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "UCA1RXIE for SPI";
    this.interruptSource[1].registerDescription = "USCI_A1 SPI receive interrupt enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;
}

/* Gets UCxxTXIE bit */
function getUCxxTXIE() {
    var REGS = this.$module;
    if (this.UC1IE.UCA1TXIE == REGS.UCA1TXIE) {
        return true;
    }
    else {
        return false;
    }
}

/* Sets UCxxTXIE bit */
function setUCxxTXIE(set) {
    var REGS = this.$module;
    if (set) {
        this.UC1IE.UCA1TXIE = REGS.UCA1TXIE;
    }
    else {
        this.UC1IE.UCA1TXIE = REGS.UCA1TXIE_OFF;
    }
    return set;
}

/* Gets UCxxRXIE bit */
function getUCxxRXIE() {
    var REGS = this.$module;
    if (this.UC1IE.UCA1RXIE == REGS.UCA1RXIE) {
        return true;
    }
    else {
        return false;
    }
}

/* Sets UCxxRXIE bit */
function setUCxxRXIE(set) {
    var REGS = this.$module;
    if (set) {
        this.UC1IE.UCA1RXIE = REGS.UCA1RXIE;
    }
    else {
        this.UC1IE.UCA1RXIE = REGS.UCA1RXIE_OFF;
    }
    return set;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:13; /db/ztree/library/trees/platform/platform-q16/src/
 */

