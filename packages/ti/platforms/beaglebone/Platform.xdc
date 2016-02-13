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
 *  Platform support for beaglebone
 *
 */

package ti.platforms.beaglebone;

/*!
 *  ======== Platform ========
 *  Platform support for the beaglebone
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
        boardName:      "beaglebone",
        boardFamily:    "beaglebone",
        boardRevision:  null
    };

    /* GPP */
    readonly config xdc.platform.IExeContext.Cpu GPP = {
        id:             "2",
        clockRate:      500.0,  /* USB powered clock */
        catalogName:    "ti.catalog.arm.cortexa8",
        deviceName:     "AM3359",
        revision:       "1.0"
    };

instance:

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["DDR2", {
                comment: "DDR2 Memory",
                name: "DDR2",
                base: 0x80000000,
                len:  0x10000000    /* 256 MB */
            }],
        ];
};
/*
 *  @(#) ti.platforms.beaglebone; 1, 0, 0,; 12-4-2015 21:40:26; /db/ztree/library/trees/platform/platform-q16/src/
 */

