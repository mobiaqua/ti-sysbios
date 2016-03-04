/* 
 *  Copyright (c) 2008 Texas Instruments and others.
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
package ti.platforms.msp430;

/*!
 *  ======== Platform ========
 *  A generic platform that supports any MSP430 device
 *
 *  The device to be used by this platform is passed as the platform instance
 *  name. On the `xdc.tools.configuro` command line, it is done in the
 *  following way:
 *  @p(code)
 *  xs xdc.tools.configuro ... -p "ti.platforms.msp430:MSP430F2274"
 *  @p
 *
 *  In package.bld, the platform instance is selected as in:
 *  @p(code)
 *  Pkg.addExecutable("test", target, "ti.platforms.msp430:MSP430F5438");
 *  @
 */
metaonly module Platform inherits xdc.platform.IPlatform
{
    config xdc.platform.IPlatform.Board BOARD = { 
        id:             "0",
        boardName:      "msp430",
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
     *      xs xdc.tools.configuro ... -p ti.platforms.MSP430:MSP430F5438:1
     *  @p
     *  Optional parameters can be omitted:
     *  @p(code)
     *      xs xdc.tools.configuro ... -p ti.platforms.MSP430:MSP430F5438
     *  @p
     */
     readonly config String nameFormat = "$(deviceName):$(includeLinkCmdFile)";

instance:

    config xdc.platform.IExeContext.Cpu CPU = { 
        id:             "0",
        clockRate:      1.0,
        catalogName:    "ti.catalog.msp430",
        deviceName:     "MSP430",
        revision:       "",
    };

    /*!
     *  ======== deviceName ========
     *  The name of an `ICpuDataSheet` module for the device
     *
     *  This parameter is optional; the device name name also be specified
     *  in the name of the the instance.
     */
    config String deviceName;

    /*!
     *  ======== clockRate ========
     *  The clock rate for this device.
     */
    config Double clockRate = 1.0;

    override config String codeMemory = null;
    
    override config String dataMemory = null;

    override config String stackMemory = null;

    /*!
     *  ======== includeLinkCmdFile ========
     *  Include the default linker command file for the specified device
     *
     *  By default, the user is responsible for adding a linker command file
     *  that defines the device memory map to the linker command line.
     *  However, if this flag is set, this platform will include a default
     *  linker command file for the selected device.
     *
     *  The default linker command files are found along the package path.
     */
    config Bool includeLinkCmdFile = false;
};

/*
 *  @(#) ti.platforms.msp430; 1, 0, 0,; 1-29-2016 10:02:48; /db/ztree/library/trees/platform/platform-q17/src/
 */

