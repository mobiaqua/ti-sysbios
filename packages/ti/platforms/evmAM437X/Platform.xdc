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
 *  Platform support for evmAM437X
 *
 */

package ti.platforms.evmAM437X;

/*!
 *  ======== Platform ========
 *  Platform support for the evmAM437X
 *
 *  This module implements xdc.platform.IPlatform and defines configuration
 *  parameters that correspond to this platform's Cpu's, Board's, etc.
 *
 *  The configuration parameters are initialized in this package's
 *  configuration script (package.cfg) and "bound" to the TCOM object
 *  model.  Once they are part of the model, these parameters are
 *  queried by a program's configuration script.
 *
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    readonly config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "evmAM437X",
        boardFamily:    "evmAM437X",
        boardRevision:  null
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "1",
        clockRate:      600.0,  /* Typically set by the HLOS */
        catalogName:    "ti.catalog.arm.cortexa9",
        deviceName:     "AM437X",
        revision:       "1.0"
    };

instance:

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["EXT_RAM", {
                comment: "External RAM",
                name: "EXT_RAM",
                base: 0x80000000,
                len:  0x08000000    /* 128 MB */
            }],
        ];

    override config string codeMemory  = "EXT_RAM";
    override config string dataMemory  = "EXT_RAM";
    override config string stackMemory = "EXT_RAM";
};
/*
 *  @(#) ti.platforms.evmAM437X; 1, 0, 0,; 1-29-2016 10:01:50; /db/ztree/library/trees/platform/platform-q17/src/
 */

