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
 *  Platform support for evmC6A8149
 *
 */

package ti.platforms.evmC6A8149;

/*!
 *  ======== Platform ========
 *  Platform support for the evmC6A8149
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
        boardName:      "evmC6A8149",
        boardFamily:    "evmC6A8149",
        boardRevision:  null
    };

    /* C674 GEM */
    readonly config xdc.platform.IExeContext.Cpu GEM = {
        id:             "0",
        clockRate:      500.0,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "TMS320C6A8149",
        revision:       ""
    };


    /* EVE - ARP32 */
    readonly config xdc.platform.IExeContext.Cpu EVE = {
        id:             "1",
        clockRate:      225.0,
        catalogName:    "ti.catalog.arp32",
        deviceName:     "TMS320C6A8149",
        revision:       ""
    };

    /* M3 Subsystem */
    readonly config xdc.platform.IExeContext.Cpu DSS = {
        id:             "2",
        clockRate:      200.0,
        catalogName:    "ti.catalog.arm.cortexm3",
        deviceName:     "TMS320C6A8149",
        revision:       "1.0"
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "3",
        clockRate:      600.0,  /* Typically set by the HLOS */
        catalogName:    "ti.catalog.arm.cortexa8",
        deviceName:     "TMS320C6A8149",
        revision:       "1.0"
    };

instance:

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["DDR3_HOST", {
                comment: "DDR3 Memory reserved for use by the A8",
                name: "DDR3_HOST",
                base: 0x80000000,
                len:  0x0B000000    /* 176 MB */
            }],
            ["DDR3_DSP", {
                comment: "DDR3 Memory reserved for use by the C674",
                name: "DDR3_DSP",
                base: 0x8B000000,
                len:  0x02000000    /* 32 MB */
            }],
            ["DDR3_SR1", {
                comment: "DDR3 Memory reserved for use by SharedRegion 1",
                name: "DDR3_SR1",
                base: 0x8D000000,
                len:  0x00C00000    /* 12 MB */
            }],
            ["DDR3_HDVPSS", {
                comment: "DDR3 Memory reserved for use by HDVPSS",
                name: "DDR3_HDVPSS",
                base: 0x8DC00000,
                len:  0x00200000    /* 2 MB */
            }],
            ["DDR3_V4L2", {
                comment: "DDR3 Memory reserved for use by V4L2",
                name: "DDR3_V4L2",
                base: 0x8DE00000,
                len:  0x00200000    /* 2 MB */
            }],
            ["DDR3_SR0", {
                comment: "DDR3 Memory reserved for use by SharedRegion 0",
                name: "DDR3_SR0",
                base: 0x8E000000,
                len:  0x01000000    /* 16 MB */
            }],
            ["DDR3_M3", {
                comment: "DDR3 Memory reserved for use by the M3 core",
                name: "DDR3_M3",
                base: 0x8F000000,
                len:  0x01000000    /* 16 MB */
            }],
            ["DDR3_EVEVECS", {
                comment: "DDR3 Memory reserved for use by the EVE int vectors",
                name: "DDR3_EVEVECS",
                base: 0x90000000,
                len:  0x00000100    /* 256 Bytes */
            }],
            ["DDR3_EVE", {
                comment: "DDR3 Memory reserved for use by the EVE",
                name: "DDR3_EVE",
                base: 0x90000100,
                len:  0x00FFFF00    /* 16MB - 256 Bytes */
            }],
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
 *  @(#) ti.platforms.evmC6A8149; 1, 0, 0,; 12-4-2015 21:41:20; /db/ztree/library/trees/platform/platform-q16/src/
 */

