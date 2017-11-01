/* 
 *  Copyright (c) 2008-2017 Texas Instruments and others.
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
 *  ======== package.xs ========
 */

/*
 *  ======== init ========
 *  Initialize this package.
 *
 *  This is called after all modules in this package are defined and
 *  initialized.  It is called before config.bld.
 */
function init()
{
    /* Remove target checks */
    environment["xdc.cfg.check.exclude"] = ".*";

    /* initialize module configuration params that are computed */
    var ma = this.$modules;
    for (var i = 0; i < ma.length; i++) {
        var tiTargets = xdc.loadPackage('ti.targets');
        if (ma[i] instanceof tiTargets.ITarget.Module) {
            var targ = tiTargets.ITarget.Module(ma[i]);
            var isas = targ.getISAChain(null);

            if (isas.length > 0) {
                /* generate a default platform for each target, if necessary */
                if (targ.platform == null) {
                    targ.platform = "ti.platforms.exp430F5438";
                }
    
                /* add target-specific assembly-language extensions */
                for (var idx = 0; idx < isas.length; idx++) {
                    var ext = ".s" + isas[idx];
                    targ.extensions.$putHead(ext,
                        new xdc.om['xdc.bld.ITarget.Extension'](
                            {suf: ext, typ: "asm"}
                        )
                    );
                }
            }
            else {
                print("Warning: ISAChain is empty for target " + targ);
            }

            /* add .s<suffix> to list of recognized extensions */
            var ext = ".s" + targ.suffix;
            targ.extensions.$putHead(ext,new xdc.om['xdc.bld.ITarget.Extension']({
                suf: ext,   typ: "asm"
            }));

        }
    }
}

/*
 *  ======== Package.getLibs ========
 *  This package's implementation of xdc.IPackage.getLibs.
 */
function getLibs()
{
    return (null);    /* no library required for this package */
}

/*
 *  ======== Package.getSects ========
 */
function getSects()
{
    return (null);
}
/*
 *  @(#) ti.targets.msp430.elf; 1, 0, 0,1; 7-27-2017 11:48:06; /db/ztree/library/trees/xdctargets/xdctargets-o04/src/ xlibrary

 */

