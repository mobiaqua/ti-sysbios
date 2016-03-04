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
 *  ======== USI.xs ========
 */
var IUSI;
var GetSet;

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    GetSet = xdc.module("xdc.services.getset.GetSet");
}

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(clock)
{
    this.clock = clock;

    IUSI = this;
    GetSet.init(this);

    this.interruptSource[0].registerName = "USISTTIE";
    this.interruptSource[0].registerDescription = "START Condition interrupt enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "USIIE";
    this.interruptSource[1].registerDescription = "Counter Interrupt enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,2; 1-29-2016 10:00:49; /db/ztree/library/trees/platform/platform-q17/src/
 */

