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
 *  ======== CortexR.xs ========
 *
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(revision)
{
    this.$private.realDevice = revision;
}

/*
 *  ======== CortexR.getMemoryMap ========
 *  Returns the memory map as seen by a program running on this device.
 */
function getMemoryMap(regs)
{
    return (null);
}
/*
 *  @(#) ti.catalog.arm.cortexr4; 1, 0, 0,; 12-4-2015 21:39:59; /db/ztree/library/trees/platform/platform-q16/src/
 */

