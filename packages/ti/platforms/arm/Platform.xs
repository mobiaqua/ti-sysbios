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
 *  ======== Platform.xs ========
 *  Generic ARM Platform 
 */
function getCpuDataSheet(cpuId)
{
    return this.$private.platInstance.getCpuDataSheet(cpuId);
}

function getExeContext(prog)
{
    return this.$private.platInstance.getExeContext(prog);
}


function getExecCmd(prog)
{
    return this.$private.platInstance.getExecCmd(prog);
}


function getLinkTemplate(prog)
{
    return this.$private.platInstance.getLinkTemplate(prog);
}

function instance$meta$init(name)
{
    /*
     *  create a search path consisting of location of user .cfg script
     *  followed by package path directories 
     */
    var parentPath = null;

    if (xdc.om.$name == "cfg") {
        parentPath = java.io.File(Program.build.cfgScript).parent;
    }

    var path = ((parentPath == null)? utils.cwd : parentPath) + ";" 
        + xdc.curPath();
   
    /* search for board.xs */
    var file = utils.findFile("board.xs", path, ";");
    if (file == null) {
        this.$module.$logFatal("File 'board.xs' cannot be found. Please make" 
            + " sure it is either in the same directory as the config script"
            + " and/or on the XDC package path" , this); 
    }
    
    /* load map details from the file */   
    var mmap = xdc.loadCapsule(file);

    /* Get the memory instance */
    var memInst = mmap[name];
    
    /* Update the platform params*/   
    if (memInst != undefined) {
        if ("BOARD" in memInst) {
            this.$module.BOARD = memInst.BOARD;
        }
  
        if ("CPU" in memInst) {
            var externalCPU = new xdc.om['xdc.platform.IExeContext'].Cpu(
                memInst.CPU);
            this.CPU = externalCPU;
        }
        else {
            this.$module.$logFatal("CPU is not defined for the platform "
                + "instance '" + name + "'", this); 
        }

        if ("externalMemoryMap" in memInst) {
            var externalMap = new xdc.om['xdc.platform.IPlatform'].MemoryMap(
                memInst.externalMemoryMap);
            this.externalMemoryMap = externalMap;
        }

        if ("customMemoryMap" in memInst) {
            if ("externalMemoryMap" in memInst) {
                this.$module.$logWarning("The externalMemoryMap will be"
                     + " overwritten by the customMemoryMap ", this); 
            }
            var customMap = new xdc.om['xdc.platform.IPlatform'].MemoryMap(
                memInst.customMemoryMap);    
            this.customMemoryMap = customMap;
        }

        if ("renameMap" in memInst) {
            this.renameMap = memInst.renameMap;
        }
        
        if ("sectionMap" in memInst) {
            this.sectionMap = memInst.sectionMap;
            Program.sectMap = this.sectionMap;
        }
 
        if ("sectionsExclude" in memInst) {
            this.sectionsExclude = memInst.sectionsExclude;
            Program.sectionsExclude = this.sectionsExclude;
        }

        if ("memoryExclude" in memInst) {
            this.memoryExclude = memInst.memoryExclude;
            Program.memoryExclude = this.memoryExclude;
        }

        if ("sectionsTemplate" in memInst) {
            this.sectionsTemplate = memInst.sectionsTemplate;
            Program.sectionsTemplate = this.sectionsTemplate;
        }
    
        if ("codeMemory" in memInst) {
            this.codeMemory = memInst.codeMemory;       
        }

        if ("dataMemory" in memInst) {
            this.dataMemory = memInst.dataMemory;       
        }

        if ("stackMemory" in memInst) {
            this.stackMemory = memInst.stackMemory;
        }
        
        if ("l1PMode" in memInst) {
            this.l1PMode = memInst.l1PMode;
        }
        
        if ("l1DMode" in memInst) {
            this.l1DMode = memInst.l1DMode;
        }
        
        if ("l2Mode" in memInst) {
            this.l2Mode = memInst.l2Mode;
        }
        /* create a generic platform instance */
        createPlatformInstance(this);

    }
    else {
         this.$module.$logFatal("Platform instance '" + name
             + "' cannot be found in " + file, this); 
    }
}

/*
 *  ======== createPlatformInstance ========
 *  Creates a generic platform instance
 *  
 *  For the platform parameters passed through the board.xs file,
 *  this function creates a generic platform instance. The instance
 *  is then saved in the $private field of this platform and will be used later
 *  on to get data from generic platform.
 */
function createPlatformInstance(plat)
{
    var gPlat = xdc.useModule('ti.platforms.generic.Platform');
    
    var params = new gPlat.Params();
    gPlat.BOARD = plat.$module.BOARD;
    params.CPU = plat.CPU;
    params.deviceName = plat.CPU.deviceName;
    params.catalogName = plat.CPU.catalogName;
    params.clockRate = plat.CPU.clockRate;
    params.externalMemoryMap = plat.externalMemoryMap; 
    params.customMemoryMap = plat.customMemoryMap;
    params.renameMap = plat.renameMap;
    params.codeMemory = plat.codeMemory;
    params.dataMemory = plat.dataMemory;
    params.stackMemory = plat.stackMemory;
    params.l1PMode = plat.l1PMode;
    params.l1DMode = plat.l1DMode;
    params.l2Mode = plat.l2Mode;

    plat.$private.platInstance = gPlat.create("CPU", params);
}
/*
 *  @(#) ti.platforms.arm; 1, 0, 0,2; 1-29-2016 10:01:01; /db/ztree/library/trees/platform/platform-q17/src/
 */

