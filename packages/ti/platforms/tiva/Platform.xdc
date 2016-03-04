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
package ti.platforms.tiva;

/*!
 *  ======== Platform ========
 *  A generic platform that supports any Tiva device
 *
 *  The device to be used by this platform is passed as the platform instance
 *  name. On the `xdc.tools.configuro` command line, it is done in the
 *  following way:
 *  @p(code)
 *  xs xdc.tools.configuro ... -p "ti.platforms.tiva:TM4C1290NCZAD"
 *  @p
 *
 *  In package.bld, the platform instance is selected as in:
 *  @p(code)
 *  Pkg.addExecutable("test", target, "ti.platforms.tiva:TM4C1290NCZAD");
 *  @p
 */
@Template ("./Platform.xdt")
metaonly module Platform inherits xdc.platform.IPlatform
{
    config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "tiva",
        boardFamily:    null,
        boardRevision:  null
    };

    /*!
     *  ======== nameFormat ========
     *  Encoding of instance creation parameters in the instance's name
     *
     *  For this platform, the parameters `deviceName`, `includeLinkCmdFile`
     *  and `clockRate` can be encoded in the instance name supplied on
     *  `xdc.tools.configuro` command line, for example:
     *  @p(code)
     *      xs xdc.tools.configuro ... -p ti.platforms.tiva:TM4C1290NCZAD:1:20
     *  @p
     *  Optional parameters can be omitted:
     *  @p(code)
     *      xs xdc.tools.configuro ... -p ti.platforms.tiva:TM4C1290NCZAD
     *  @p
     */
     readonly config string nameFormat
         = "$(deviceName):$(includeLinkCmdFile):$(clockRate)";

instance:

    /*
     *  This platform supports either Cortex M3 or M4 cores.
     *  The corresponding "actual" catalogName is overwritten
     *  in Platform.instance$meta$init() based on the device name
     */
    config xdc.platform.IExeContext.Cpu CPU = {
        id:             "0",
        clockRate:      1.0,
        catalogName:    "ti.catalog.arm.cortexm4",
        deviceName:     "Tiva",
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
 *  @(#) ti.platforms.tiva; 1, 0, 0,; 1-29-2016 10:03:35; /db/ztree/library/trees/platform/platform-q17/src/
 */

