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
 */

/*
 *  ======== Platform.getExeContext ========
 *  This Platform's implementation xdc.platform.IPlatform.getExeContext.
 *
 *  Return the xdc.platform.IExeContext.Instance object that will run the
 *  specified program prog.
 */
function getExeContext(prog)
{
    this.$module.$logError("This platform is no longer supported. Please " +
        "move to an older version of the product that supports this platform.",
        this);

    return (null);
}
/*
 *  @(#) ti.platforms.stellaris; 1, 0, 0,; 12-4-2015 21:43:10; /db/ztree/library/trees/platform/platform-q16/src/
 */

