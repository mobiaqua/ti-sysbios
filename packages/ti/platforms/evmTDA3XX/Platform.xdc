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
 *  Platform support for TDA3XX
 *
 */

/*!
 *  ======== Platform ========
 *  Platform support for TDA3XX
 *
 *  This module implements xdc.platform.IPlatform and defines configuration
 *  parameters that correspond to this platform's Cpu's, Board's, etc.
 *
 *  The configuration parameters are initialized in this package's
 *  configuration script (package.cfg) and "bound" to the TCOM object
 *  model.  Once they are part of the model, these parameters are
 *  queried by a program's configuration script.
 *
 *  This particular platform has 1 EVE, 1 Benelli/IPU sub-system (Dual M4's)
 *  and 2 C66x DSP's.
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "evmTDA3XX",
        boardFamily:    "evmTDA3XX",
        boardRevision:  null,
    };

    readonly config xdc.platform.IExeContext.Cpu DSP = {
        id:             "0",
        clockRate:      600.0,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "TDA3XX",
        revision:       "1.0",
    };

    /* Benelli M4 Subsystem */
    readonly config xdc.platform.IExeContext.Cpu M4 = {
        id:             "1",
        clockRate:      212.8,
        catalogName:    "ti.catalog.arm.cortexm4",
        deviceName:     "TDA3XX",
        revision:       "1.0",
    };

    /* EVE */
    readonly config xdc.platform.IExeContext.Cpu EVE = {
        id:             "2",
        clockRate:      535.0,
        catalogName:    "ti.catalog.arp32",
        deviceName:     "TDA3XX",
        revision:       "1.0"
    };

instance:

    /*!
     *  ======== externalMemoryMap ========
     *  Memory regions as defined in the TDA3XX Specification
     */
    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["EXT_RAM", {
                comment: "1 GB External RAM Memory",
                name: "EXT_RAM",
                base: 0x80000000,
                len:  0x40000000
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
 *  @(#) ti.platforms.evmTDA3XX; 1, 0, 0, 0,; 12-4-2015 21:41:54; /db/ztree/library/trees/platform/platform-q16/src/
 */

