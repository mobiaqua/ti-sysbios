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
 *  ======== DAC12.xs ========
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
    this.interruptSource[0].registerName = "DAC12IE_0";
    this.interruptSource[0].registerDescription = "DAC12_0 interrupt enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "DAC12IE_1";
    this.interruptSource[1].registerDescription = "DAC12_1 interrupt enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;
}

/*
 *  ======== instance_validate ========
 */
function instance_validate(inst)
{
}

/*
 *  ======== module$validate ========
 */
function module$validate()
{
    /* boilerplate text to validate each instance */
    for each (var inst in this.$instances) {
        instance_validate(inst);
    }
}
/*
 *  @(#) ti.catalog.msp430.peripherals.dac; 1, 0, 0,2; 1-29-2016 10:00:49; /db/ztree/library/trees/platform/platform-q17/src/
 */

