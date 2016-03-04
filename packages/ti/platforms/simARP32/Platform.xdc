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

package ti.platforms.simARP32;

/*!
 *  ======== Platform ========
 *  Simulation-based Platform support for TI Torrent platforms
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
    /*!
     *  ======== BOARD ========
     *  This platform's board attributes
     */
    readonly config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "simARP32",
        boardFamily:    "simARP32",
        boardRevision:  null
    };

    /*!
     *  ======== CPU ========
     *  The CPU simulated by this platform.
     *
     *  The device simulated is determined by the platform instance name
     *  or if this does not name a ti.catalog.arm module, then we
     *  we simulate a TMS470.
     */
    readonly config xdc.platform.IExeContext.Cpu CPU = {        
        id:             "0",
        clockRate:      200.0,
        catalogName:    "ti.catalog.arp32",
        deviceName:     "Arctic",
        revision:       "1.0",
    };

instance:

    /*!
     *  ======== externalMemoryMap ========
     *  Memory regions as defined in the Ducati Functional Specification
     */

    override readonly config xdc.platform.IPlatform.Memory
        externalMemoryMap[string] = [
            ["ARP32VECS", {
                comment: "External memory for ARP32 interrupt vectors",
                name:  "ARP32VECS",
                base:  0x80000000,
                len:   0x00000100,
                page:  0,
                space: "code/data"
            }],

            ["ARP32", {
                comment: "External memory for ARP32 use",
                name:  "ARP32",
                base:  0x80000100,
                len:   0x0fffff00,
                page:  1,
                space: "code/data"
            }]
        ];

    override config string codeMemory = "ARP32";
    override config string dataMemory = "DMEM";
    override config string stackMemory = "DMEM";
};
/*
 *  @(#) ti.platforms.simARP32; 1, 0, 1, 0,; 1-29-2016 10:03:11; /db/ztree/library/trees/platform/platform-q17/src/
 */

