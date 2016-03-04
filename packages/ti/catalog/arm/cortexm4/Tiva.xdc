/*
 *  Copyright (c) 2016 by Texas Instruments and others.
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
 *  ======== Tiva.xdc ========
 *  Generic Tiva Cpu definition
 *
 *  This device represents all Tiva devices independent.
 */

metaonly module Tiva inherits ti.catalog.ICpuDataSheet
{
instance:
    override config string   cpuCore        = "CM4";
    override config string   isa            = "v7M4";
    override config string cpuCoreRevision   = "1.0";
    override config int    minProgUnitSize   = 1;
    override config int    minDataUnitSize   = 1;
    override config int    dataWordSize      = 4;
}
/*
 *  @(#) ti.catalog.arm.cortexm4; 1, 0, 0,2; 1-29-2016 10:00:34; /db/ztree/library/trees/platform/platform-q17/src/
 */

