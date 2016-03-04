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
 *  ======== Comparator_D.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
    this.interruptSource[0].registerName = "CDIE";
    this.interruptSource[0].registerDescription = "Comparator_D Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "CDIIE";
    this.interruptSource[1].registerDescription = "Comparator_D Interrupt Enable Inverted Polarity";
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
 *  @(#) ti.catalog.msp430.peripherals.comparator; 1, 0, 0,2; 1-29-2016 10:00:49; /db/ztree/library/trees/platform/platform-q17/src/
 */

