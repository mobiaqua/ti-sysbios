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
 *  ======== Platform.xdc ========
 */

package ti.platforms.simArctic;

/*!
 *  ======== Platform ========
 *  Platform support for the simArctic
 *
 *  This module implements xdc.platform.IPlatform and defines configuration
 *  parameters that correspond to this platform's Cpu's, Board's, etc.
 *
 *  The configuration parameters are initialized in this package's
 *  configuration script (package.cfg) and "bound" to the TCOM object
 *  model.  Once they are part of the model, these parameters are
 *  queried by a program's configuration script.
 *
 *  This particular platform has a single Cpu, and therefore, only
 *  declares a single CPU configuration object.  Multi-CPU platforms
 *  would declare multiple Cpu configuration parameters (one per
 *  platform CPU).
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {      
        id:             "0",
        boardName:      "simArctic",
        boardFamily:    "simArctic",
        boardRevision:  null,
    };

    readonly config xdc.platform.IExeContext.Cpu ARP32 = {
        id:             "0",
        clockRate:      200.0,
        catalogName:    "ti.catalog.arp32",
        deviceName:     "Arctic",
        revision:       "",
    };

    readonly config xdc.platform.IExeContext.Cpu DSP = {        
        id:             "1",
        clockRate:      300.0,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "Arctic",
        revision:       "",
    };


instance:

    /* 
     *  DDR is 2GByte but we need to share it with the ARP32.
     */
    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["ARP32VECS", {
                comment: "External memory for ARP32 interrupt vectors",
                name:  "ARP32VECS",
                base:  0x80000000,
                len:   0x00000100,
                space: "code/data"
            }],

            ["ARP32", {
                comment: "External memory for ARP32 use",
                name:  "ARP32",
                base:  0x80000100,
                len:   0x01ffff00,
                space: "code/data"
            }],
            
            ["DSP", {
                comment: "External memory for DSP use",
                name:  "DSP",
                base:  0x82000000,
                len:   0x02000000,
                space: "code/data"
            }],

            ["SHARED", {
                comment: "Shared external memory",
                name:  "SHARED",
                base:  0x84000000,
                len:   0x0C000000,
                space: "code/data"
            }]
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
 *  @(#) ti.platforms.simArctic; 1, 0, 0,; 12-4-2015 21:42:41; /db/ztree/library/trees/platform/platform-q16/src/
 */

