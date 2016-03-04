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
 *  ======== package.xdc ========
 *
 */
requires ti.catalog.arp32;
requires ti.catalog.c6000;
requires ti.catalog.arm.cortexm4;
requires ti.catalog.arm.cortexa15;
requires xdc.platform [1,0,1];

/*!
 *  ======== ti.platforms.simVayu ========
 *  Platform package for the Vayu SDP.
 *
 *  This package implements the interfaces (xdc.platform.IPlatform)
 *  necessary to build and run executables on the Vayu SDP platform.
 *
 *  @a(Throws)
 *  `XDCException` exceptions are thrown for fatal errors. The following error
 *  codes are reported in the exception message:
 *  @p(dlist)
 *      -  `ti.platforms.simVayu.LINK_TEMPLATE_ERROR`
 *           This error is raised when this platform cannot found the default
 *           linker command template `linkcmd.xdt` in the build target's
 *           package. When a target does not contain this file, the config
 *           parameter `{@link xdc.cfg.Program#linkTemplate}` must be set.
 *  @p
 */
package ti.platforms.simVayu [1,0,0,0] {
    module Platform;
}
/*
 *  @(#) ti.platforms.simVayu; 1, 0, 0, 0,; 1-29-2016 10:03:31; /db/ztree/library/trees/platform/platform-q17/src/
 */

