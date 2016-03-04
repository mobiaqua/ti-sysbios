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
 *
 */

/*!
 *  ======== Platform ========
 *  Platform support for the simTesla
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {      
        id:             "0",
        boardName:      "simTesla",
        boardFamily:    "simTesla",
        boardRevision:  null,
    };
        
    readonly config xdc.platform.IExeContext.Cpu CPU = {        
        id:             "0",
        clockRate:      466,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "OMAP4430",
        revision:       "1.0",
    };
    
instance:

    /*!
     *  ======== externalMemoryMap ========
     *  Memory regions as defined in the Tesla Functional Specification
     */

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [

            ["EXT_RAM", {
                comment: "External RAM",
                name: "EXT_RAM",
                base: 0x20000000, 
                len:  0x01000000
            }],

        ];


    override config string codeMemory  = "EXT_RAM";
    override config string dataMemory  = "EXT_RAM";
    override config string stackMemory = "EXT_RAM";

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
 *  @(#) ti.platforms.simTesla; 1, 0, 0, 0,; 1-29-2016 10:03:28; /db/ztree/library/trees/platform/platform-q17/src/
 */

