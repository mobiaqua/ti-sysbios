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
 *  ======== ITMS320C283xx.xdc ========
 */
package ti.catalog.c2800;

/*!
 *  ======== ITMS320C283xx ========
 *  An interface implemented by all TMS320C28xx devices.
 *
 *  This interface is defined to factor common data about this family into
 *  a single place; all TMS320C28xx devices extend this interface.
 */
metaonly interface ITMS320C283xx inherits ITMS320C28xx
{
instance:
    override config string   isa            = "28FP";
};
/*
 *  @(#) ti.catalog.c2800; 1, 0, 0, 0,2; 1-29-2016 10:00:38; /db/ztree/library/trees/platform/platform-q17/src/
 */

