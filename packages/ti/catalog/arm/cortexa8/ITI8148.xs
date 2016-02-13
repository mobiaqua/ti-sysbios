/*
 *  Copyright (c) 2015 by Texas Instruments and others.
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
 *  ======== ITI8148.xs ========
 *
 */

/*
 *  ======== ITI8148.getMemoryMap ========
 *  Returns the memory map as seen by a program running on this device
 *  when the registers are set as specified by the regs hash.
 */
function getMemoryMap(regs)
{
    return (this.memMap);
}

/*
 *  ======== ITI8148.instance$meta$init ========
 */
function instance$meta$init()
{
    var HDVICP2 = xdc.useModule("ti.catalog.peripherals.hdvicp2.HDVICP2");

    this.hdvicp0 = HDVICP2.create({ name: "HDVICP0", baseAddr: 0x58000000, intNum:107});
}
/*
 *  @(#) ti.catalog.arm.cortexa8; 1, 0, 0,; 12-4-2015 21:39:55; /db/ztree/library/trees/platform/platform-q16/src/
 */

