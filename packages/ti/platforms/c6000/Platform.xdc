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

package ti.platforms.c6000;

/*!
 *  ======== Platform ========
 *  Generic platform support for the c6000
 *
 *  This platform requires a memory map file called `board.xs` to be available 
 *  in the same directory as the application config file. It should define 
 *  values for the config parameters which are declared in this platform.
 *  
 *  @a(Examples)
 *  A sample `board.xs` file.
 *
 *  @p(code)
 *  var board6748 = {
 *      BOARD: {
 *          boardName:      "board6748",
 *          boardFamily:    "board6xxx",
 *      },
 *      CPU: {
 *          clockRate:      300.0,
 *          catalogName:    "ti.catalog.c6000",
 *          deviceName:     "TMS320C6748",
 *      },
 *      externalMemoryMap: [
 *          ["EXTRAM",  {
 *              name: "DDR",  base: 0xC0000000, len: 0x08000000,
 *          }]
 *      ],
 *      codeMemory:  "DDR",
 *      dataMemory:  "DDR",
 *      stackMemory: "DDR",
 *      l1PMode:     "32k",
 *      l1DMode:     "32k",
 *      l2Mode:      "0k",
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
        catalogName:    "ti.catalog.c6000",
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
     *  ======== l1PMode ========
     *  Define the amount of L1P RAM used for L1 Program Cache.
     */
    config String l1PMode = null;
    
    /*!
     *  ======== l1DMode ========
     *  Define the amount of L1D RAM used for L1 Data Cache.
     */
    config String l1DMode = null;
    
    /*!
     *  ======== l2Mode ========
     *  Define the amount of L2 RAM used for L2 Cache.
     */
    config String l2Mode = null;
   
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
 *  @(#) ti.platforms.c6000; 1, 0, 0,; 12-4-2015 21:40:28; /db/ztree/library/trees/platform/platform-q16/src/
 */

