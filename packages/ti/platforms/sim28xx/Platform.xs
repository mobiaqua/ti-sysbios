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
 *  ======== Platform.xs ========
 *
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
    return (Utils.getCpuDataSheet(this.$private.cpuAttrs));
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
    /* create a default ExeContext execution context */
    var ExeContext = xdc.useModule('xdc.platform.ExeContext');
    var cpu = ExeContext.create(this.$private.cpuAttrs, this.$module.BOARD);

    /* Set the initial memory map from the cpu datasheet. */
    cpu.memoryMap = Utils.assembleMemoryMap(cpu, this);

    for (var i = 0; i < cpu.memoryMap.length; i++) {
        if (cpu.memoryMap[i].page == null) {
            if (cpu.memoryMap[i].name == "PIEVECT") {
                cpu.memoryMap[i].page = 1;
            }
            else {
                cpu.memoryMap[i].page = 0;
            }
        }
    }

    // check for the overlap in the memory map
    var overlap = Utils.checkOverlap(cpu.memoryMap);

    if (overlap != null) {
        this.$module.$logError("Memory objects " + overlap + " overlap", this,
            overlap);
    }

    Utils.checkDefaults(this, cpu.memoryMap);
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
    "@$(ECHO) https://www-a.ti.com/downloads/sds_support/targetcontent/rtsc/index.html"
     + "\n\t: ";
    var doNotKnow = "@$(ECHO) sim28xx platform package does not know how to "
        + "execute " + prog.name + " on " + os + "\n" + updateComment;
    var command = doNotKnow;
    return (command);
}

/*
 *  ======== Platform.getLinkTemplate ========
 *  This is Platform's implementation xdc.platform.IPlatform.getLinkTemplate
 */
function getLinkTemplate(prog)
{
    return ("ti/targets/linkcmd.xdt");
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
    /*  Determine an appropriate CPU to simulate
     *
     *  First check to see if the platform instance name is the name of a
     *  chip.  If so, use this as the CPU to simulate; otherwise, use the
     *  default specified in this module's CPU config parameter.
     */

    /* create a copy of the default Cpu attributes declared in Platform.xdc */
    var cpuAttrs = new xdc.om["xdc.platform"].IExeContext.Cpu(this.$module.CPU);

    if (name in xdc.om[cpuAttrs.catalogName]) {
        cpuAttrs.deviceName = name;
    }

    this.$private.cpuAttrs = cpuAttrs;

    if (this.deviceName != undefined) {
        if (!(this.deviceName in xdc.om[cpuAttrs.catalogName])) {
            this.$module.$logError("Device " + this.deviceName + " does not " +
                "exist in " + cpuAttrs.catalogName, this, this.deviceName);     
        }
        else {
            this.$private.cpuAttrs.deviceName = this.deviceName;        
        }
    }
}
/*
 *  @(#) ti.platforms.sim28xx; 1, 0, 1, 1,; 1-29-2016 10:02:59; /db/ztree/library/trees/platform/platform-q17/src/
 */

