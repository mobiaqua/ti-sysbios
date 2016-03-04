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
 *  ======== Timer1_A3.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(clock) {
    this.clock = clock;

    this.interruptSource[0].registerName = "TAIE";
    this.interruptSource[0].registerDescription = "Timer_A overflow interrupt enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "CCIE.0";
    this.interruptSource[1].registerDescription = "Capture/compare interrupt enable 0";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "CCIE.1";
    this.interruptSource[2].registerDescription = "Capture/compare interrupt enable 1";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "CCIE.2";
    this.interruptSource[3].registerDescription = "Capture/compare interrupt enable 2";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;
}

/*
 *  ======== setTxxCCRx ========
 */
function setTxxCCRx(ccrNumber , value) {
    switch (ccrNumber) {
        case 0:
            this.TA1CCR0 = value;
            break;
        case 1:
            this.TA1CCR1 = value;
            break;
        case 2:
            this.TA1CCR2 = value;
            break;
        default:
            break;
    }
}

/*
 *  ======== getTxxCCRx ========
 */
function getTxxCCRx(ccrNumber) {
    switch (ccrNumber) {
        case 0:
            return this.TA1CCR0;
            break;
        case 1:
            return this.TA1CCR1;
            break;
        case 2:
            return this.TA1CCR2;
            break;
        default:
            return null;
            break;
    }
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,2; 1-29-2016 10:00:58; /db/ztree/library/trees/platform/platform-q17/src/
 */

