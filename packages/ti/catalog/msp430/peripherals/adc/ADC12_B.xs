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
 *  ======== ADC12_B.xs ========
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

    for (var i=0; i<32; i++) {
        this.interruptSource[i].registerName = "ADC12IE"+i;
        this.interruptSource[i].registerDescription = "ADC12_B Interrupt Enable " + i;
        this.interruptSource[i].interruptEnable = false;
        this.interruptSource[i].interruptHandler = false;
    }
    
    this.interruptSource[32].registerName = "ADC12HIIFG";
    this.interruptSource[32].registerDescription = "ADC12_B Window Comparator High Threshold";
    this.interruptSource[32].interruptEnable = false;
    this.interruptSource[32].interruptHandler = false;
        
    this.interruptSource[33].registerName = "ADC12LOIFG";
    this.interruptSource[33].registerDescription = "ADC12_B Window Comparator Low Threshold";
    this.interruptSource[33].interruptEnable = false;
    this.interruptSource[33].interruptHandler = false;
        
    this.interruptSource[34].registerName = "ADC12INIFG";
    this.interruptSource[34].registerDescription = "ADC12_B Window Comparator In-between Threshold";
    this.interruptSource[34].interruptEnable = false;
    this.interruptSource[34].interruptHandler = false;
    
}
/*
 *  @(#) ti.catalog.msp430.peripherals.adc; 1, 0, 0,2; 1-29-2016 10:00:47; /db/ztree/library/trees/platform/platform-q17/src/
 */

