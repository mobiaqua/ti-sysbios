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
 *  ======== ICpuDataSheet.xdc ========
 */

/*!
 *  ======== ICpuDataSheet ========
 *  TI-specific extensions to xdc.platform.ICpuDataSheet
 */
metaonly interface ICpuDataSheet inherits xdc.platform.ICpuDataSheet {

instance:

    /*!
     *  ======== isa ========
     *  @_nodoc
     */
    config string isa;
}
/*
 *  @(#) ti.catalog; 1, 0, 0,2; 1-29-2016 10:00:27; /db/ztree/library/trees/platform/platform-q17/src/
 */

