/* 
 *  Copyright (c) 2012 Texas Instruments and others.
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
 *  ======== genSections ========
 *
 *  This function generates section allocations. 
 *
 *  This is not used as IAR does not support NOLOAD/COPY sections yet.
 */
function genSections(prog)
{
    var res = "";

    /* the section map is constructed from the target and program info */
    var sectMap = prog.getSectMap();

    if (sectMap['xdc.meta'] == undefined) {
        sectMap['xdc.meta'] = new prog.SectionSpec();
        sectMap['xdc.meta'].loadAddress = 40000;
    }

    if ("xdc.runtime" in xdc.om && xdc.om['xdc.runtime.Text'].isLoaded != true
        && sectMap['xdc.noload'] == undefined) {
        sectMap['xdc.noload'] = new prog.SectionSpec();
        sectMap['xdc.noload'].loadAddress = 50000;
    }

    var exclude = ("sectionsExclude" in prog)
                    ? new RegExp(prog.sectionsExclude): null;
    for (var sn in sectMap) {
        if (exclude != null && sn.match(exclude) != null) {
            /* don't generate this section; the user will take care of this */
            continue;   
        }
        
        if (sectMap[sn].loadAddress != undefined) {
            res += "-Z" + sn + "=" + sectMap[sn].loadAddress;
        }
        else {
            res += "-Z" + sn + "=_" + sectMap[sn].loadSegment + "_START-_"
                + sectMap[sn].loadSegment + "_END\n";
        }
    }

    /* filter content using Program.sectionsTemplate */
    if ("sectionsTemplate" in prog && prog.sectionsTemplate != null) {
        var tplt = xdc.loadTemplate(prog.sectionsTemplate);
        var bout = new java.io.ByteArrayOutputStream();
        var out = new java.io.PrintStream(bout);
        tplt.genStream(out, prog, [sectMap, res]);
        res = bout.toString();
    }
    
    return (res);
}
/*
 *  @(#) ti.platforms.msp430; 1, 0, 0,; 12-4-2015 21:42:17; /db/ztree/library/trees/platform/platform-q16/src/
 */

