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
 *  ======== package.xdc ========
 *
 */
requires ti.catalog.arp32;
requires ti.catalog.c6000;
requires ti.catalog.arm.cortexm4;
requires xdc.platform [1,0,1];

/*!
 *  ======== ti.platforms.evmTDA3XX ========
 *  Platform package for the TDA3XX SDP.
 *
 *  This package implements the interfaces (xdc.platform.IPlatform)
 *  necessary to build and run executables on the TDA3XX SDP platform.
 *
 *  @a(Throws)
 *  `XDCException` exceptions are thrown for fatal errors. The following error
 *  codes are reported in the exception message:
 *  @p(dlist)
 *      -  `ti.platforms.evmTDA3XX.LINK_TEMPLATE_ERROR`
 *           This error is raised when this platform cannot found the default
 *           linker command template `linkcmd.xdt` in the build target's
 *           package. When a target does not contain this file, the config
 *           parameter `{@link xdc.cfg.Program#linkTemplate}` must be set.
 *  @p
 */
package ti.platforms.evmTDA3XX [1,0,0,0] {
    module Platform;
}
/*
 *  @(#) ti.platforms.evmTDA3XX; 1, 0, 0, 0,; 12-4-2015 21:41:54; /db/ztree/library/trees/platform/platform-q16/src/
 */

