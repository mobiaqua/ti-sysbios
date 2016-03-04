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
 *  Platform support for evmTI813X
 *
 */

package ti.platforms.evmTI813X;

/*!
 *  ======== Platform ========
 *  Platform support for the evmTI813X
 *
 *  This module implements xdc.platform.IPlatform and defines configuration
 *  parameters that correspond to this platform's Cpu's, Board's, etc.
 *
 *  The configuration parameters are initialized in this package's
 *  configuration script (package.cfg) and "bound" to the TCOM object
 *  model.  Once they are part of the model, these parameters are
 *  queried by a program's configuration script.
 *
 *  This particular platform has 3 CPU's, a host GPP, and 2 M3's.
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    /*!
     *  ======== BOARD ========
     *  This platform's board attributes
     */
    readonly config xdc.platform.IPlatform.Board BOARD = { 
        id:             "0",
        boardName:      "evmTI813X",
        boardFamily:    "evmTI813X",
        boardRevision:  null
    };

    /* M3 Subsystem */
    readonly config xdc.platform.IExeContext.Cpu DSS = {
        id:             "0",
        clockRate:      200.0,
        catalogName:    "ti.catalog.arm.cortexm3",
        deviceName:     "TMS320TI813X",
        revision:       "1.0"
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "1",
        clockRate:      600.0,  /* Typically set by the HLOS */
        catalogName:    "ti.catalog.arm.cortexa8",
        deviceName:     "TMS320TI813X",
        revision:       "1.0"
    };

instance:

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["DDR3_HOST", {
                comment: "DDR3 Memory reserved for use by the A8",
                name: "DDR3_HOST",
                base: 0x80000000,
                len:  0x0D000000    /* 196 MB */
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
        ];

};

/*
 *  @(#) ti.platforms.evmTI813X; 1, 0, 0,; 1-29-2016 10:02:29; /db/ztree/library/trees/platform/platform-q17/src/
 */

