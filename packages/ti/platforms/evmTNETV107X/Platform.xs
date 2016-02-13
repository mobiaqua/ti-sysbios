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
 *  ======== Platform.xs ========
 *  Platform support for evmTNETV107X
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
    if (cpuId == "0") {
        return (Utils.getCpuDataSheet(this.$module.DSP));
    }
    else if (cpuId == "1") {
        return (Utils.getCpuDataSheet(this.$module.GPP));
    }
    else {
        this.$module.$logError("The platform " + this.$module.$name +
            " does not contain cpu with cpuId: " + cpuId, this.$module, null);
    }
}

/*
 *  ======== Platform.getExeContext ========
 *  This Platform's implementation xdc.platform.IPlatform.getExeContext.
 *
 *  Return the xdc.platform.IPlatform.ExeContext object that will run the 
 *  specified program prog.
 */
function getExeContext(prog)
{
    var ExeContext = xdc.useModule('xdc.platform.ExeContext');

    var cpu;
    var core = this.$private.core;

    xdc.loadPackage(this.$module[core].catalogName);
    /* create a default ExeContext execution context */
    cpu = ExeContext.create(this.$module[core], this.$module.BOARD);

    cpu.memoryMap = Utils.assembleMemoryMap(cpu, this);

    if (this.codeMemory == undefined) {
        if (core == "GPP") {
            this.codeMemory = "DDR2";
        }
        else {
            this.codeMemory = "IRAM";
        }
    }
    
    // check for the overlap in the memory map
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
function getExecCmd(prog)
{
    var os = environment["xdc.hostOS"];
    var updateComment = "@$(ECHO) Check for updates to this package at:\n" +
    "@$(ECHO) https://www-a.ti.com/downloads/sds_support/targetcontent/rtsc/index.html";
     return("@$(ECHO) " + this.$package.$name + " platform package cannot " +
         "execute " + prog.name + " on " + os + "\n" + updateComment + "\n\t:");
}

/*
 *  ======== Platform.getLinkTemplate ========
 *  This is Platform's implementation xdc.platform.IPlatform.getLinkTemplate
 */
function getLinkTemplate(prog)
{
    /* use the target's linker command template */
    /* we compute the target because this same platform is supported by
     * many different tool chains; e.g., ti.targets, gnu.targets, ...
     */
    var tname = prog.build.target.$name;
    var tpkg = tname.substring(0, tname.lastIndexOf('.'));
    var templateName = tpkg.replace(/\./g, "/") + "/linkcmd.xdt"; 

    if (xdc.findFile(templateName) != null) {
        return (templateName);
    }
    else if (tname.indexOf("ti.targets.") == 0) {
        return ("ti/targets/linkcmd.xdt");
    }
    else {
        throw new Packages.xdc.services.global.XDCException(
            this.$package.$name + ".LINK_TEMPLATE_ERROR",
            "Target package " + tpkg + " does not contain linker command "
            + "template 'linkcmd.xdt'.");
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
 */
function instance$meta$init(name)
{
    var thisMod = this.$module;
    /* We need to add v5t, v5T, v5TE because of several changes we made for
     * the name of that architecture.
     */
    var armChain = ["470", "v4T", "v5T", "v5TE", "v5t", "v6"];
    var dspChain = ["62", "64", "64P"];
    for (var i = 0; i < dspChain.length; i++) {
        if (dspChain[i] == Program.build.target.isa) {
            this.$private.core = "DSP";
        }
    }
    for (var i = 0; i < armChain.length; i++) {
        if (armChain[i] == Program.build.target.isa) {
            this.$private.core = "GPP";
/*            this.externalMemoryMap["SRAM"] = {
                name: "SRAM",
                base: 0x2000000,
                len:  0x0010000
            };*/
        }
    }
    if (this.$private.core == null) {
        this.$module.$logError("The build target " + Program.build.target.$name
            + " is incompatible with this platform.", this.$module, null);
    }

    if (!Utils.checkFit(this.$module.PARAMS.externalMemoryMap,                 
                        this.externalMemoryMap)) {
        this.$module.$logError("External memory cannot be changed on " +
            "this platform", this, null);
    }
}
/*
 *  @(#) ti.platforms.evmTNETV107X; 1, 0, 0, 1,; 12-4-2015 21:42:02; /db/ztree/library/trees/platform/platform-q16/src/
 */

