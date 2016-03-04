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
 *  ======== RTC_B.xs ========
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
function instance$meta$init()
{
    this.interruptSource[0].registerName = "RTCOFIE";
    this.interruptSource[0].registerDescription = "RTC_B Crystal Oscillator Fault Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "RTCAIE";
    this.interruptSource[1].registerDescription = "RTC_B Alarm Interrupt Enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "RTCRDYIE";
    this.interruptSource[2].registerDescription = "RTC_B Ready Interrupt Enable";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "RTCTEVIE";
    this.interruptSource[3].registerDescription = "RTC_B Time Event Interrupt Enable";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;

}
/*
 *  @(#) ti.catalog.msp430.peripherals.rtc; 1, 0, 0,2; 1-29-2016 10:00:57; /db/ztree/library/trees/platform/platform-q17/src/
 */

