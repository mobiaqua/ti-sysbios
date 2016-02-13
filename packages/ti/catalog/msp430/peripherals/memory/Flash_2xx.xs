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
 *  ======== Flash_2xx.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(clock)
{
    this.clock = clock;
    
    /* Min and Max FTG values obtained from datasheet*/
    this.uMinFtg = 257; // Value from datasheet Min FTG in kHz
    this.uMaxFtg = 476; // Value from datasheet Max FTG in kHz
}
/*
 *  @(#) ti.catalog.msp430.peripherals.memory; 1, 0, 0,; 12-4-2015 21:40:17; /db/ztree/library/trees/platform/platform-q16/src/
 */

