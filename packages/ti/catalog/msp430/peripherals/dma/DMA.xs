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
 *  ======== DMA.xs ========
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
    this.interruptSource[0].registerName = "DMAIE.0";
    this.interruptSource[0].registerDescription = "DMA interrupt enable 0";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "DMAIE.1";
    this.interruptSource[1].registerDescription = "DMA interrupt enable 1";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "DMAIE.2";
    this.interruptSource[2].registerDescription = "DMA interrupt enable 2";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.dma; 1, 0, 0,2; 1-29-2016 10:00:51; /db/ztree/library/trees/platform/platform-q17/src/
 */

