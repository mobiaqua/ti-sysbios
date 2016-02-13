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
package ti.platforms.rf432s0xx;

/*!
 *  ======== Platform ========
 *  A generic platform that supports any rf432s0xx device
 *
 *  The device to be used by this platform is passed as the platform instance
 *  name. On the `xdc.tools.configuro` command line, it is done in the
 *  following way:
 *  @p(code)
 *  xs xdc.tools.configuro ... -p "ti.platforms.rf432s0xx:RF432S0xx"
 *  @p
 *
 *  In package.bld, the platform instance is selected as in:
 *  @p(code)
 *  Pkg.addExecutable("test", target, "ti.platforms.rf432s0xx:RF432S0xx");
 *  @p
 */
@Template ("./Platform.xdt")
metaonly module Platform inherits xdc.platform.IPlatform
{
    config xdc.platform.IPlatform.Board BOARD = {
        id:             "0",
        boardName:      "rf432s0xx",
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
     *      xs xdc.tools.configuro ... -p ti.platforms.rf432s0xx:RF432S0xx:1:20
     *  @p
     *  Optional parameters can be omitted:
     *  @p(code)
     *      xs xdc.tools.configuro ... -p ti.platforms.rf432s0xx:RF432S0xx
     *  @p
     */
     readonly config string nameFormat
         = "$(deviceName):$(includeLinkCmdFile):$(clockRate)";

    /*!
     *  ======== useGnuRomLinkCmd ========
     *  Use ROM compatible linker script when building using GNU tools
     *
     *  If this config param is set to true and "includeLinkCmdFile" is true,
     *  the ROM compatible linker script will be used. The ROM compatible
     *  linker script is required when building a ROM based application.
     */
     config Bool useGnuRomLinkCmd = false;

instance:

    config xdc.platform.IExeContext.Cpu CPU = {
        id:             "0",
        clockRate:      8.0,
        catalogName:    "ti.catalog.arm.cortexm0",
        deviceName:     "RF432S0xx",
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
 *  @(#) ti.platforms.rf432s0xx; 1, 0, 0,; 12-4-2015 21:42:19; /db/ztree/library/trees/platform/platform-q16/src/
 */

