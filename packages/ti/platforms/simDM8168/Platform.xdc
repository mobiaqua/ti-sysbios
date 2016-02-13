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
 *  Platform support for simDM8168
 *
 */

package ti.platforms.simDM8168;

/*!
 *  ======== Platform ========
 *  Platform support for the simDM8168
 *
 *  This module implements xdc.platform.IPlatform and defines configuration
 *  parameters that correspond to this platform's Cpu's, Board's, etc.
 *
 *  The configuration parameters are initialized in this package's
 *  configuration script (package.cfg) and "bound" to the TCOM object
 *  model.  Once they are part of the model, these parameters are
 *  queried by a program's configuration script.
 *
 *  This particular platform has 4 CPU's, a host GPP, 2 M3's, and a
 *  C674 DSP.
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "simDM8168",
        boardFamily:    "simDM8168",
        boardRevision:  null
    };

    /* C674 GEM */
    readonly config xdc.platform.IExeContext.Cpu GEM = {
        id:             "0",
        clockRate:      800.0,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "TMS320DM8168",
        revision:       ""
    };

    /* M3 Subsystem */
    readonly config xdc.platform.IExeContext.Cpu DSS = {
        id:             "1",
        clockRate:      250.0,
        catalogName:    "ti.catalog.arm.cortexm3",
        deviceName:     "TMS320DM8168",
        revision:       "1.0"
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "2",
        clockRate:      1000.0,  /* Typically set by the HLOS */
        catalogName:    "ti.catalog.arm.cortexa8",
        deviceName:     "TMS320DM8168",
        revision:       "1.0"
    };

instance:

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [

            ["DDR3_RAM", {
                comment: "External RAM",
                name: "DDR3_RAM",
                base: 0x80000000,
                len:  0x10000000
            }]

        ];

    override config string codeMemory = "DDR3_RAM";
    override config string dataMemory = "DDR3_RAM";
    override config string stackMemory = "DDR3_RAM";

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
 *  @(#) ti.platforms.simDM8168; 1, 0, 0,; 12-4-2015 21:42:51; /db/ztree/library/trees/platform/platform-q16/src/
 */

