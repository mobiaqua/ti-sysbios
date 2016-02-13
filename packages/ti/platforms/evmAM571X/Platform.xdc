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
 *  Platform support for AM571X
 */

/*!
 *  ======== Platform ========
 *  Platform support for AM571X
 *
 *  This module implements xdc.platform.IPlatform and defines configuration
 *  parameters that correspond to this platform's Cpu's, Board's, etc.
 *
 *  The configuration parameters are initialized in this package's
 *  configuration script (package.cfg) and "bound" to the TCOM object
 *  model.  Once they are part of the model, these parameters are
 *  queried by a program's configuration script.
 *
 *  This particular platform has 1 Cortex-A15, 2 Benelli/IPU
 *  Sub-system (Dual M4's) and 1 C66x DSP's.
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "evmAM571X",
        boardFamily:    "evmAM571X",
        boardRevision:  null,
    };

    readonly config xdc.platform.IExeContext.Cpu DSP = {
        id:             "0",
        clockRate:      700,
        catalogName:    "ti.catalog.c6000",
        deviceName:     "DRA7XX",
        revision:       "1.0",
    };

    /* Benelli M4 Subsystem */
    readonly config xdc.platform.IExeContext.Cpu M4 = {
        id:             "1",
        clockRate:      212.8,
        catalogName:    "ti.catalog.arm.cortexm4",
        deviceName:     "DRA7XX",
        revision:       "1.0",
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "3",
        clockRate:      1500.0,  /* Typically set by the HLOS */
        catalogName:    "ti.catalog.arm.cortexa15",
        deviceName:     "DRA7XX",
        revision:       "1.0"
    };

/*  Memory Map for ti.platforms.evmAM571X
 *
 *  Virtual     Physical        Size            Comment
 *  ------------------------------------------------------------------------
 *              8000_0000  1000_0000  ( 256 MB) External Memory
 *
 *  0000_0000 0 8000_0000        100  ( 256  B) --------
 *              8000_0100       FF00  ( ~64 KB) --------
 *  0000_0000   8001_0000        100  ( 256  B) --------
 *              8001_0100       FF00  ( ~64 KB) --------
 *  0000_0000   8002_0000        100  ( 256  B) --------
 *              8002_0100       FF00  ( ~64 KB) --------
 *  0000_0000   8003_0000        100  ( 256  B) --------
 *              8003_0100    FE_FF00  ( ~16 MB) --------
 *            1 8100_0000    40_0000  (   4 MB) --------
 *              8140_0000    C0_0000  (  12 MB) --------
 *            2 8200_0000    40_0000  (   4 MB) --------
 *              8240_0000    C0_0000  (  12 MB) --------
 *            3 8300_0000    40_0000  (   4 MB) --------
 *              8340_0000    C0_0000  (  12 MB) --------
 *            4 8400_0000    40_0000  (   4 MB) --------
 *              8440_0000    C0_0000  (  12 MB) --------
 *            5 8500_0000   100_0000  (  16 MB) --------
 *            6 8600_0000   100_0000  (  16 MB) --------
 *            7 8700_0000   100_0000  (  16 MB) --------
 *            8 8800_0000   100_0000  (  16 MB) --------
 *            9 8900_0000   100_0000  (  16 MB) --------
 *            A 8A00_0000    80_0000  (   8 MB) IPU1 (code, data), benelli
 *              8A80_0000    80_0000  (   8 MB) IPU2 (code, data), benelli
 *            B 8B00_0000   100_0000  (  16 MB) HOST (code, data)
 *            C 8C00_0000   100_0000  (  16 MB) DSP1 (code, data)
 *            D 8D00_0000   100_0000  (  16 MB) --------
 *            E 8E00_0000   100_0000  (  16 MB) SR_0 (ipc)
 *            F 8F00_0000   100_0000  (  16 MB) --------
 */

    readonly config Any SR_0 = {
        name: "SR_0", space: "data", access: "RWX",
        base: 0x8E000000, len: 0x1000000,
        comment: "SR#0 Memory (16 MB)"
    };

    readonly config Any DSP1 = {
        externalMemoryMap: [
            [ "DSP1_PROG", {
                name: "DSP1_PROG", space: "code/data", access: "RWX",
                base: 0x8C000000, len: 0x1000000,
                comment: "DSP1 Program Memory (16 MB)"
            }],
            [ "SR_0", SR_0 ]
        ],
        codeMemory:  "DSP1_PROG",
        dataMemory:  "DSP1_PROG",
        stackMemory: "DSP1_PROG",
        l1DMode: "32k",
        l1PMode: "32k",
        l2Mode: "128k"
    };

    readonly config Any IPU1 = {
        externalMemoryMap: [
            [ "IPU1_PROG", {
                name: "IPU1_PROG", space: "code/data", access: "RWX",
                base: 0x8A000000, len: 0x800000,
                comment: "IPU1 Program Memory (8 MB)"
            }],
            [ "SR_0", SR_0 ]
        ],
        codeMemory:  "IPU1_PROG",
        dataMemory:  "IPU1_PROG",
        stackMemory: "IPU1_PROG"
    };

    readonly config Any IPU2 = {
        externalMemoryMap: [
            [ "IPU2_PROG", {
                name: "IPU2_PROG", space: "code/data", access: "RWX",
                base: 0x8A800000, len: 0x800000,
                comment: "IPU2 Program Memory (8 MB)"
            }],
            [ "SR_0", SR_0 ]
        ],
        codeMemory:  "IPU2_PROG",
        dataMemory:  "IPU2_PROG",
        stackMemory: "IPU2_PROG"
    };

    readonly config Any HOST = {
        externalMemoryMap: [
            [ "HOST_PROG", {
                name: "HOST_PROG", space: "code/data", access: "RWX",
                base: 0x8B000000, len: 0x1000000,
                comment: "HOST Program Memory (16 MB)"
            }],
            [ "SR_0", SR_0 ]
        ],
        codeMemory:  "HOST_PROG",
        dataMemory:  "HOST_PROG",
        stackMemory: "HOST_PROG"
    };

instance:

    /*!
     *  ======== externalMemoryMap ========
     *  Memory regions as defined in the AM571X Specification
     */
    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["EXT_RAM", {
                comment: "2 GB External RAM Memory",
                name: "EXT_RAM",
                base: 0x80000000,
                len:  0x80000000
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
 *  @(#) ti.platforms.evmAM571X; 1, 0, 0, 0,; 12-4-2015 21:41:14; /db/ztree/library/trees/platform/platform-q16/src/
 */

