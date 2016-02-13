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

/*!
 *  ======== RF432S0xx.xdc ========
 *  Generic RF432S0xx Cpu definition
 *
 *  This device represents all RF432S0xx devices independent.
 */

metaonly module RF432S0xx inherits ti.catalog.ICpuDataSheet
{
instance:
    override config string   cpuCore        = "CM0";
    override config string   isa            = "v6M";
    override config string cpuCoreRevision   = "1.0";
    override config int    minProgUnitSize   = 1;
    override config int    minDataUnitSize   = 1;
    override config int    dataWordSize      = 4;
}
/*
 *  @(#) ti.catalog.arm.cortexm0; 1, 0, 0,; 12-4-2015 21:39:55; /db/ztree/library/trees/platform/platform-q16/src/
 */

