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
 *  ======== Platform.xdc ========
 */

/*!
 *  ======== Platform ========
 *  Platform support for the evmTCI6638K2K
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {      
        id:             "0",
        boardName:      "evmTCIK2X",
        boardFamily:    "evmTCIK2X",
        boardRevision:  null,
    };

    /* DSP */
    readonly config xdc.platform.IExeContext.Cpu CPU = {        
        id:             "0",
        clockRate:      1220,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "TMS320TCI6638",
        revision:       "1.0",
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "1",
        clockRate:      125.0,  /* Typically set by the HLOS */
        catalogName:    "ti.catalog.arm.cortexa15",
        deviceName:     "TCI6638K2K",
        revision:       "1.0"
    };

instance:

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["DDR3", {name: "DDR3", base: 0x80000000, len: 0x80000000}],
    ];

    /*
     *  ======== l1PMode ========
     *  Define the amount of L1P RAM used for L1 Program Cache.
     *
     *  Check the device documentation for valid values.
     */
    config String l1PMode = "32k";
    
    /*
     *  ======== l1DMode ========
     *  Define the amount of L1D RAM used for L1 Data Cache.
     *
     *  Check the device documentation for valid values.
     */
    config String l1DMode = "32k";
    
    /*
     *  ======== l2Mode ========
     *  Define the amount of L2 RAM used for L2 Cache.
     *
     *  Check the device documentation for valid values.
     */
    config String l2Mode = "0k";

};
/*
 *  @(#) ti.platforms.evmTCI6638K2K; 1, 0, 0, 0,; 1-29-2016 10:02:24; /db/ztree/library/trees/platform/platform-q17/src/
 */

