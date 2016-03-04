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
 *  ======== ADC10_B.xs ========
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

    this.interruptSource[0].registerName = "ADC10IE0";
    this.interruptSource[0].registerDescription = "ADC10_B Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;
    
    this.interruptSource[1].registerName = "ADC10HIIE";
    this.interruptSource[1].registerDescription = "ADC10_B Window Comparator High Threshold";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;
    
    this.interruptSource[2].registerName = "ADC10LOIE";
    this.interruptSource[2].registerDescription = "ADC10_B Window Comparator Low Threshold";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;
    
    this.interruptSource[3].registerName = "ADC10INIE";
    this.interruptSource[3].registerDescription = "ADC10_B Window Comparator In-between Threshold";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.adc; 1, 0, 0,2; 1-29-2016 10:00:46; /db/ztree/library/trees/platform/platform-q17/src/
 */

