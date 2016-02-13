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

package ti.platforms.arp32;

/*!
 *  ======== Platform ========
 *  Generic platform support for the arp32
 *
 *  This platform requires a memory map file called `board.xs` to be available 
 *  in the same directory as the application config file. It should define 
 *  values for the config parameters which are declared in this platform.
 *
 *  @a(Examples)
 *  A sample `board.xs` file.
 *
 *  @p(code)
 *  var boardARP32 = {
 *      CPU: {
 *          clockRate:      200.0,
 *          catalogName:    "ti.catalog.arp32",
 *          deviceName:     "Arctic",
 *      },
 *      externalMemoryMap: [
 *          ["ARP32VECS", {
 *              comment: "External memory for ARP32 interrupt vectors",
 *              name:  "ARP32VECS",
 *              base:  0x80000000,
 *              len:   0x00000100,
 *              page:  0,
 *              space: "code/data"
 *          }],
 *
 *          ["ARP32", {
 *              comment: "External memory for ARP32 use",
 *              name:  "ARP32",
 *              base:  0x80000100,
 *              len:   0x0fffff00,
 *              page:  1,
 *              space: "code/data"
 *          }]
 *      ],
 *      codeMemory:  "ARP32",
 *      dataMemory:  "DMEM",
 *      stackMemory: "DMEM",
 *  };
 *  @p
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    config xdc.platform.IPlatform.Board BOARD;

instance:

    /*!
     *  ======== CPU ========
     *  CPU Attributes necessary to create an execution context 
     *
     *  The platform requires these attributes to get the device internal
     *  memory map.
     *
     *  @see xdc.platform.IExeContext#Cpu
     */
    config xdc.platform.IExeContext.Cpu CPU = { 
        id:             "0",
        clockRate:      1.0,
        catalogName:    "ti.catalog.arp32",
        deviceName:     "",
        revision:       "",
    };
    
    override config String codeMemory = null;
    
    override config String dataMemory = null;

    override config String stackMemory = null;
    
    /*!
     *  ======== sectionMap ========
     *  A section name to SectionSpec mapping
     *
     *  @see xdc.cfg.Program#sectMap
     */
    config Any sectionMap[string];

    /*!
     *  ======== sectionsExclude ========
     *  Section to exclude from linker command file generation
     *
     *  @see xdc.cfg.Program#sectionsExclude
     */
    config String sectionsExclude = null;

    /*!
     *  ======== memoryExclude ========
     *  Section to exclude from linker command file generation
     *
     *  @see xdc.cfg.Program#memoryExclude
     */
    config Bool memoryExclude = false;

    /*!
     *  ======== sectionsTemplate ========
     *  Replace the sections portion of the generated linker command file.
     *
     *  @see xdc.cfg.Program#sectionsTemplate
     */
    config String sectionsTemplate = null;

    /*!
     *  ======== sectMap ========
     *  @_nodoc
     */
    override config String sectMap[string];

    /*!
     *  ======== getCpuDataSheet ========
     *  @_nodoc    
     */
    override function getCpuDataSheet(cpuId);
 
    /*!
     *  ======== getExeContext ========
     *  @_nodoc
     */
    override function getExeContext(prog);

    /*!
     *  ======== getExecCmd ========
     *  @_nodoc
     */
    override function getExecCmd(prog, platPath);

    /*!
     *  ======== getLinkTemplate ========
     *  @_nodoc
     */
    override function getLinkTemplate(prog);
};
/*
 *  @(#) ti.platforms.arp32; 1, 0, 0,; 12-4-2015 21:40:25; /db/ztree/library/trees/platform/platform-q16/src/
 */

