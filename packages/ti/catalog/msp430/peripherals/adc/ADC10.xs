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
 *  ======== ADC10.xs ========
 */

var ADC10;

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    ADC10 = this;
}

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(clock)
{
    this.clock = clock;

    this.interruptSource[0].registerName = "ADC10IE";
    this.interruptSource[0].registerDescription = "ADC10 interrupt enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;
}

/*
 *  ======== instance_validate ========
 */
function instance_validate(inst)
{
    /* add error checking / resource constraints here */
    switch (inst.ADC10CTL1.CONSEQ) {
        case ADC10.CONSEQ_0:
            inst.ADC10CTL0.MSC = ADC10.MSC_OFF;
            break;
        case ADC10.CONSEQ_1:
            break;
        case ADC10.CONSEQ_2:
            break;
        case ADC10.CONSEQ_3:
            break;
        default:
            break;
    }
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
 *  @(#) ti.catalog.msp430.peripherals.adc; 1, 0, 0,2; 1-29-2016 10:00:46; /db/ztree/library/trees/platform/platform-q17/src/
 */

