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
 *  ======== CS_A.xs ========
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
    this.ACLKHz      = 32768;   /* ACLK frequency in Hertz */
    this.MCLKHz      = 1000000; /* MCLK frequency in Hertz */
    this.SMCLKHz     = 1000000; /* SMLK frequency in Hertz */
}
/*
 *  @(#) ti.catalog.msp430.peripherals.clock; 1, 0, 0,; 12-4-2015 21:40:11; /db/ztree/library/trees/platform/platform-q16/src/
 */

