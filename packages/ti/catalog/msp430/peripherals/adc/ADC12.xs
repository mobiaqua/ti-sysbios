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
 *  ======== ADC12.xs ========
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

    this.interruptSource[0].registerName = "ADC12IE0";
    this.interruptSource[0].registerDescription = "ADC12 interrupt enable bit 0";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "ADC12IE1";
    this.interruptSource[1].registerDescription = "ADC12 interrupt enable bit 1";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "ADC12IE2";
    this.interruptSource[2].registerDescription = "ADC12 interrupt enable bit 2";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "ADC12IE3";
    this.interruptSource[3].registerDescription = "ADC12 interrupt enable bit 3";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;

    this.interruptSource[4].registerName = "ADC12IE4";
    this.interruptSource[4].registerDescription = "ADC12 interrupt enable bit 4";
    this.interruptSource[4].interruptEnable = false;
    this.interruptSource[4].interruptHandler = false;

    this.interruptSource[5].registerName = "ADC12IE5";
    this.interruptSource[5].registerDescription = "ADC12 interrupt enable bit 5";
    this.interruptSource[5].interruptEnable = false;
    this.interruptSource[5].interruptHandler = false;

    this.interruptSource[6].registerName = "ADC12IE6";
    this.interruptSource[6].registerDescription = "ADC12 interrupt enable bit 6";
    this.interruptSource[6].interruptEnable = false;
    this.interruptSource[6].interruptHandler = false;

    this.interruptSource[7].registerName = "ADC12IE7";
    this.interruptSource[7].registerDescription = "ADC12 interrupt enable bit 7";
    this.interruptSource[7].interruptEnable = false;
    this.interruptSource[7].interruptHandler = false;

    this.interruptSource[8].registerName = "ADC12IE8";
    this.interruptSource[8].registerDescription = "ADC12 interrupt enable bit 8";
    this.interruptSource[8].interruptEnable = false;
    this.interruptSource[8].interruptHandler = false;

    this.interruptSource[9].registerName = "ADC12IE9";
    this.interruptSource[9].registerDescription = "ADC12 interrupt enable bit 9";
    this.interruptSource[9].interruptEnable = false;
    this.interruptSource[9].interruptHandler = false;

    this.interruptSource[10].registerName = "ADC12IE10";
    this.interruptSource[10].registerDescription = "ADC12 interrupt enable bit 10";
    this.interruptSource[10].interruptEnable = false;
    this.interruptSource[10].interruptHandler = false;

    this.interruptSource[11].registerName = "ADC12IE11";
    this.interruptSource[11].registerDescription = "ADC12 interrupt enable bit 11";
    this.interruptSource[11].interruptEnable = false;
    this.interruptSource[11].interruptHandler = false;

    this.interruptSource[12].registerName = "ADC12IE12";
    this.interruptSource[12].registerDescription = "ADC12 interrupt enable bit 12";
    this.interruptSource[12].interruptEnable = false;
    this.interruptSource[12].interruptHandler = false;

    this.interruptSource[13].registerName = "ADC12IE13";
    this.interruptSource[13].registerDescription = "ADC12 interrupt enable bit 13";
    this.interruptSource[13].interruptEnable = false;
    this.interruptSource[13].interruptHandler = false;

    this.interruptSource[14].registerName = "ADC12IE14";
    this.interruptSource[14].registerDescription = "ADC12 interrupt enable bit 14";
    this.interruptSource[14].interruptEnable = false;
    this.interruptSource[14].interruptHandler = false;

    this.interruptSource[15].registerName = "ADC12IE15";
    this.interruptSource[15].registerDescription = "ADC12 interrupt enable bit 15";
    this.interruptSource[15].interruptEnable = false;
    this.interruptSource[15].interruptHandler = false;
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
 *  @(#) ti.catalog.msp430.peripherals.adc; 1, 0, 0,; 12-4-2015 21:40:11; /db/ztree/library/trees/platform/platform-q16/src/
 */

