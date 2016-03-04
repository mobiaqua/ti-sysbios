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

/*
 *  ======== TCI6636K2H.xdc ========
 *
 */

metaonly module TCI6636K2H inherits ti.catalog.ICpuDataSheet
{
instance:
    override config string cpuCore           = "v7A15";
    override config string isa               = "v7A15";
    override config string cpuCoreRevision   = "1.0";
    override config int    minProgUnitSize   = 1;
    override config int    minDataUnitSize   = 1;
    override config int    dataWordSize      = 4;

    /*!
     *  ======== memMap ========
     *  The memory map returned be getMemoryMap().
     */
    config xdc.platform.IPlatform.Memory memMap[string]  = [
    ];
}
/*
 *  @(#) ti.catalog.arm.cortexa15; 1, 0, 0,2; 1-29-2016 10:00:31; /db/ztree/library/trees/platform/platform-q17/src/
 */

