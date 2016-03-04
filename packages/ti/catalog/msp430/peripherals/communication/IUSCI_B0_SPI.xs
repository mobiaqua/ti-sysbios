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
 *  ======== IUSCI_B0_SPI.xs ========
 */

/*
 *  ======== module$meta$init ========
 */
function module$meta$init() 
{
}

/* Sets UCxxBR0 register value based on which module */
function setUCxxBR0(value) {
    this.UCB0BR0 = value;
}

/* Returns UCxxBR0 register value based on which module */
function getUCxxBR0() {
    return this.UCB0BR0;
}

/* Sets UCxxBR1 register value based on which module */
function setUCxxBR1(value) {
    this.UCB0BR1 = value;
}

/* Returns UCxxBR1 register value based on which module */
function getUCxxBR1() {
    return this.UCB0BR1;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:48; /db/ztree/library/trees/platform/platform-q17/src/
 */

