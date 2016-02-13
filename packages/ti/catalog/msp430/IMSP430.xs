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
 *  ======== IMSP430.getMemoryMap ========
 *  Returns the memory map as seen by a program running on this device.
 */
function getMemoryMap(regs)
{
    return (this.memMap);
}

/*
 *  ======== IMSP430.instance$meta$init ========
 */
function instance$meta$init()
{
    var unitName = this.$module.$orig.$name.substr(
        this.$module.$orig.$name.lastIndexOf('.') + 1);
    var generic = xdc.module("ti.catalog.msp430.MSP430").create(unitName);
    this.peripherals = generic.peripherals;
}
/*
 *  @(#) ti.catalog.msp430; 1, 0, 0,; 12-4-2015 21:40:06; /db/ztree/library/trees/platform/platform-q16/src/
 */

