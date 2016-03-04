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
 *  ======== Boot.xdc ========
 *
 */

package ti.catalog.c2800.concertoInit;

/*!
 *  ======== Boot ========
 *  Concerto C28 Boot Support.
 *
 *  This Boot module can be used to generate a small section that supports 
 *  booting the C28 processor from Flash.  It consists of a single 
 *  "LB _c_int00" instruction.  
 *
 *  When `{@link #bootFromFlash}` is true, the instruction will be placed
 *  at "BEGIN", as defined in the linker command file.
 *
 *  Boot also supports initializing Flash controller wait states, enabling
 *  program prefetches, and data caching within the Flash controller.
 */
@Template("./Boot.xdt")
@NoRuntime
module Boot
{
    /*!
     *  Boot from Flash flag.  Default is true.
     *
     *  Set to true to enable booting the C28 from Flash.
     */
    metaonly config Bool bootFromFlash = true;

    /*!
     *  Flash controller configuration flag, default is true.
     *
     *  Set to true to enable the configuration of the Flash controller
     *  wait states, program and data cache.
     */
    metaonly config Bool configureFlashController = true;

    /*! 
     *  Flash controller wait states configuration flag, default is true.
     *
     *  Set to true to configure the Flash controller wait states.  The number
     *  of wait states is computed based upon the CPU frequency.
     */
    metaonly config Bool configureFlashWaitStates = true;

    /*! 
     *  Flash controller program prefetch enable flag, default is false.
     *
     *  Set to true to enable the Flash controller's program prefetch.
     *
     *  WARNING: Program prefetch must not be enabled on pre Revision A devices
     *  if there are any fast branch instructions in the program image.  See
     *  the device errata for more information.
     */
    metaonly config Bool enableFlashProgramPrefetch = false;

    /*! 
     *  Flash controller data cache enable flag, default is true.
     *
     *  Set to true to enable the Flash controller's data cache.
     */
    metaonly config Bool enableFlashDataCache = true;

    /*!
     *  ======== loadSegment ========
     *  Specifies where to load the flash function (include the 'PAGE' number)
     *
     *  If 'configureFlashWaitStates' is true, then this parameter
     *  determines where the ".ti_catalog_c2800_initF2837x_flashfuncs"
     *  section gets loaded.
     */
    metaonly config String loadSegment;

    /*!
     *  ======== runSegment ========
     *  Specifies where to run the flash function (include the 'PAGE' number)
     *
     *  If 'configureFlashWaitStates' is true then this parameter
     *  determines where the ".ti_catalog_c2800_initF2837x_flashfuncs"
     *  section gets executed at runtime.
     */
    metaonly config String runSegment;

internal:

    /* The computed Flash wait states */
    metaonly config UInt flashWaitStates = 3;
};   
/*
 *  @(#) ti.catalog.c2800.concertoInit; 1, 0, 0,2; 1-29-2016 10:00:38; /db/ztree/library/trees/platform/platform-q17/src/
 */

