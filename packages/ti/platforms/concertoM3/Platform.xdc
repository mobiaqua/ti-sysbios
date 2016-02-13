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
package ti.platforms.concertoM3;

/*!
 *  ======== Platform ========
 *  A generic platform that supports any Stellaris device
 *
 *  The device to be used by this platform is passed as the platform instance
 *  name. On the `xdc.tools.configuro` command line, it is done in the
 *  following way:
 *  @p(code)
 *  xs xdc.tools.configuro ... -p "ti.platforms.concertoM3:LM3S8971"
 *  @p
 *
 *  In package.bld, the platform instance is selected as in:
 *  @p(code)
 *  Pkg.addExecutable("test", target, "ti.platforms.concertoM3:LM3S8971");
 *  @p
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    config xdc.platform.IPlatform.Board BOARD = { 
        id:             "0",
        boardName:      "concertoM3",
        boardFamily:    null,
        boardRevision:  null
    };

    /*!
     *  ======== nameFormat ========
     *  Encoding of instance creation parameters in the instance's name
     * 
     *  For this platform, the parameters `deviceName` and `includeLinkCmdFile`
     *  can be encoded in the instance name supplied on `xdc.tools.configuro`
     *  command line, for example:
     *  @p(code)
     *      xs xdc.tools.configuro ... -p ti.platforms.concertoM3:LM3S8971:1
     *  @p
     *  Optional parameters can be omitted:
     *  @p(code)
     *      xs xdc.tools.configuro ... -p ti.platforms.concertoM3:LM3S8971
     *  @p
     */
     readonly config string nameFormat = "$(deviceName):$(includeLinkCmdFile)";

instance:

    config xdc.platform.IExeContext.Cpu CPU = {
        id:             "0",
        clockRate:      1.0,
        catalogName:    "ti.catalog.arm.cortexm3",
        deviceName:     "F28M35x",
        revision:       "",
    };

    /*!
     *  ======== deviceName ========
     *  The name of an `ICpuDataSheet` module for the device
     *
     *  This parameter is required, but it does not have to be set explicitly;
     *  it can be encoded in the instance's name.
     */
    config string deviceName;

    /*!
     *  ======== clockRate ========
     *  The clock rate for this device.
     */
    config Double clockRate;

    override config string codeMemory = null;

    override config string dataMemory = null;

    override config string stackMemory = null;

    /*!
     *  ======== includeLinkCmdFile ========
     *  The flag that specifies if the platform should include a linker command
     *  file.
     *
     *  By default, a user is responsible for adding a linker command file to
     *  the project, or to the linker command line. However, if this flag is
     *  set, this platform will include a default linker command file for the
     *  selected device.
     */
    config Bool includeLinkCmdFile = false;
};
/*
 *  @(#) ti.platforms.concertoM3; 1, 0, 0,; 12-4-2015 21:40:30; /db/ztree/library/trees/platform/platform-q16/src/
 */

