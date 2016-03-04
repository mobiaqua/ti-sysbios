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

requires xdc.platform;

/*!
 *  ======== ti.catalog.arp32 ========
 *  Package of devices for the arp32 family of DSPs.
 *
 *  Each module in this package implements the xdc.platform.ICpuDataSheet
 *  interface.  This interface is used by platforms (modules that implement
 *  xdc.platform.IPlatform) to obtain the memory map supported by each CPU.
 */
package ti.catalog.arp32 [1,0,0,0] {
    module TMS320C6A8149;
    module Arctic;
    module Vayu;
    module DRA7XX;
    module TDA3XX;
}
/*
 *  @(#) ti.catalog.arp32; 1, 0, 0, 0,2; 1-29-2016 10:00:37; /db/ztree/library/trees/platform/platform-q17/src/
 */

