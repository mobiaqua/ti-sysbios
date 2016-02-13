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
 *  ======== ITMS320C64_512K.xs ========
 *
 */

var c6x = xdc.loadCapsule("c6x.xs");

/*
 *  ======== ITMS320C64_512K.getMemoryMap ========
 *  Returns the memory map as seen by a program running on this device
 *  when the registers are set as specified by the regs hash.
 */
function getMemoryMap(regs)
{
    return (c6x.init6x1xMap(this, this.memMap["IRAM"].len, regs));
}

/*
 *  @(#) ti.catalog.c6000; 1, 0, 0, 0,; 12-4-2015 21:40:06; /db/ztree/library/trees/platform/platform-q16/src/
 */

