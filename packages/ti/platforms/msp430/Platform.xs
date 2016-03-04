/* 
 *  Copyright (c) 2010 Texas Instruments and others.
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
 *  ======== Platform.xs ========
 *  Generic platform support for MSP430 devices.
 */

var Utils = xdc.useModule('xdc.platform.Utils');

/*
 *  ======== Platform.getCpuDataSheet ========
 *  This Platform's implementation xdc.platform.IPlatform.getCpuDataSheet.
 *
 *  Return the xdc.platform.ICpuDataSheet.Instance object that corresponds
 *  to the device that runs executables loaded on the specified cpuId.
 */
function getCpuDataSheet(cpuId)
{
    var cpuAttrs = this.CPU.$copy();
    cpuAttrs.deviceName = this.deviceName;
    return (Utils.getCpuDataSheet(cpuAttrs));
}

/*
 *  ======== Platform.getExeContext ========
 *  This Platform's implementation xdc.platform.IPlatform.getExeContext.
 *
 *  Return the xdc.platform.IExeContext.Instance object that will run the
 *  specified program prog.
 */
function getExeContext(prog)
{
    /* The default argSize should be 0 for this platform. We will set it here
     * before the user's script starts, so if the user wants to overwrite it,
     * she can.
     */
    if (prog) {
        prog.argSize = 0;
    }

    /* create a default ExeContext execution context */
    var ExeContext = xdc.useModule('xdc.platform.ExeContext');
    var cpu = ExeContext.create(this.CPU, this.$module.BOARD);

    /* This is where we have peripherals available, so we can get their base
     * addresses and other info.
     */

    cpu.memoryMap = Utils.assembleMemoryMap(cpu, this);
    cpu.deviceName = this.CPU.revision;
    cpu.revision = "";
    
    /* check for the overlap in the memory map */
    var overlap = Utils.checkOverlap(cpu.memoryMap);

    if (overlap != null) {
        this.$module.$logError("Memory objects " + overlap + " overlap", this,
            overlap);
    }

    this.$seal();
    return (cpu);
}

/*
 *  ======== Platform.getExecCmd ========
 *  This Platform's implementation xdc.platform.IPlatform.getExecCmd.
 */
function getExecCmd(prog, packagePath)
{
    var os = environment["xdc.hostOS"];
    
    if (Program.build.target.$name.match(/iar/) && (os == "Windows")) {
        var root = prog.build.target.rootDir;
        var isa = prog.build.target.isa;
        var cmd = root + "/../common/bin/cspybat " + root + "/bin/430proc.dll "
            + root + "/bin/430sim.dll " + prog.name + " --silent --plugin "
            + root + "/bin/430bat.dll --backend --iv_base 0xFFE0";
        if (isa == "430X") {
            cmd += " --core=430X";
        }
        return (cmd);
    }

    return ("@$(ECHO) " + this.$package.$name
        + " does not know how to execute " + prog.name + " on " + os + "\n");
}

/*
 *  ======== Platform.getLinkTemplate ========
 *  This Platform's implementation xdc.platform.IPlatform.getLinkTemplate
 */
function getLinkTemplate(prog)
{
    /* The cleanest way to figure out which target is the build target would
     * be to check if Program.build.target is instancof of ITarget from TI
     * or IAR target package. However, we don't want to reference any module
     * that is not already loaded because that would bring a whole package into
     * the configuration. That's inefficient and also generates a warning if
     * loading a package causes any xdc.useModule() calls.
     * To avoid that, we first check if the build target's package is already
     * loaded.
     */

    /* IAR targets */
    if ('iar.targets.msp430' in xdc.om && Program.build.target instanceof
            xdc.module("iar.targets.msp430.ITarget").Module) {
        return ("ti/platforms/msp430/linkcmd_iar.xdt");
    }
    /* TI targets */
    else if ('ti.targets' in xdc.om && Program.build.target instanceof
            xdc.module("ti.targets.ITarget").Module) {
        return ("ti/platforms/msp430/linkcmd.xdt");
    }
    /* other targets */
    else {
        return (null);
    }
}

/*
 *  ======== Platform.Instance.init ========
 *  This function is called to initialize a newly created instance of a
 *  platform.  Platform instances are created just prior to running
 *  program configuration scripts.
 *
 *  Platform instances may also be created in the build domain.
 *
 *  @param(name)        the name used to identify this instance (without
 *                      the package name prefix)
 *
 *  For this platform, 'name' must identify a device. Besides the catalog 
 *  module, this parameter may encode values for other configuration 
 *  parameters, as defined by `nameFormat`. The values are separated by ':'.
 */
function instance$meta$init(name)
{
    var maxParamsLength = this.$module.nameFormat.split(":").length;
    var nameParams = name.split(":");

    if (nameParams.length > maxParamsLength) {
        this.$module.$logWarning("The platform " + this.$package.$name 
            + " accepts only " + maxParamsLength 
            + " instance parameters in its name. The supplied string '" 
            + name + "' contains additional values, which will be ignored.", 
            this, this.$module.nameFormat);
    }

    if (nameParams[0] != "" && this.deviceName != null
        && this.deviceName != nameParams[0]) {
        this.$module.$logError(this.$package.$name 
            + " was passed two different device names: '" + nameParams[0]
            + "' and '" + this.deviceName + "'.", this, this.deviceName);
    }
    else if (nameParams[0] != "") {
        this.deviceName = nameParams[0];
    }

    if (this.deviceName == null) {
        this.$module.$logFatal("A device name must be specified for the "
            + "platform '" + this.$package.$name + "'. A device name can be "
            + "specified in the platform name, as "
            + "'ti.platforms.msp430:MSP430XYZ', where MSP430XYZ is the name "
            + "of the selected device.", this, this.deviceName);
    }

    if (nameParams[1] != "false" && Boolean(nameParams[1]).valueOf()) {
        this.includeLinkCmdFile = true;
    }

    if (this.externalMemoryMap.length != 0) {
        this.$module.$logWarning(this.$package.$name + " does not support "
            + "external memory map, and the parameter 'externalMemoryMap' is "
            + "ignored.", this, this.externalMemoryMap);    
    }

    /* We use 'revision' to pass 'the real device name' to the generic MSP430
     * device.
     */
    this.CPU.revision = this.deviceName;
    this.CPU.clockRate = this.clockRate;
}
/*
 *  @(#) ti.platforms.msp430; 1, 0, 0,; 1-29-2016 10:02:48; /db/ztree/library/trees/platform/platform-q17/src/
 */

