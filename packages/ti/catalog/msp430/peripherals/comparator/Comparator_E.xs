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
 *  ======== Comparator_E.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
    this.interruptSource[0].registerName = "CEIE";
    this.interruptSource[0].registerDescription = "Comparator_E Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "CEIIE";
    this.interruptSource[1].registerDescription = "Comparator_E Interrupt Enable Inverted Polarity";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
}
/*
 *  @(#) ti.catalog.msp430.peripherals.comparator; 1, 0, 0,; 12-4-2015 21:40:12; /db/ztree/library/trees/platform/platform-q16/src/
 */

