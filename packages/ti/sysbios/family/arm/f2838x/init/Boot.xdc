/*
 * Copyright (c) 2018-2019, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * */
/*
 *  ======== Boot.xdc ========
 */

package ti.sysbios.family.arm.f2838x.init;

import xdc.rov.ViewInfo;
import xdc.runtime.Assert;

/*!
 *  ======== Boot ========
 *  TMS320F2838X device Boot Support.
 *
 *  The Boot module supports boot initialization for the CM core.
 *  Two special Boot init functions are created based on the configuration
 *  settings for this module.  One function is an xdc.runtime.Reset
 *  function (called early at boot prior to cinit processing), and the second
 *  function is an xdc.runtime.Startup first function (called before main()).
 *
 *  The code to support the boot module is placed in a separate section
 *  named `".text:.bootCodeSection"` to allow placement of this section in
 *  the linker .cmd file if necessary. This section is a subsection of the
 *  `".text"` section so this code will be placed into the .text section unless
 *  explicitly placed, either through
 *  `{@link xdc.cfg.Program#sectMap Program.sectMap}` or through a linker
 *  command file.
 */
@Template("./Boot.xdt")
module Boot
{
    metaonly struct ModuleView {
        Bool disableWatchdog;
        Bool configureFlashController;
        Bool configureFlashWaitStates;
        Bool enableFlashProgramCache;
        Bool enableFlashDataCache;
        Bool pllSourcedINTOSC;
        Bool bootFromFlash;
    }

    @Facet
    metaonly config ViewInfo.Instance rovViewInfo =
        ViewInfo.create({
            viewMap: [
            [
                'Module',
                {
                    type: ViewInfo.MODULE,
                    viewInitFxn: 'viewInitModule',
                    structName: 'ModuleView'
                }
            ],
            ]
        });

    /*!
     *  Watchdog disable configuration flag, default is false.
     *
     *  Set to true to disable the watchdog.
     */
    metaonly config Bool disableWatchdog = false;

    /*!
     *  Flash controller configuration flag, default is true.
     *
     *  Set to true to enable the configuration of the Flash controller
     *  wait states, program and data cache.
     */
    metaonly config Bool configureFlashController = true;

    /*!
     *  Internal OSCCLK configuration flag, default is true.
     *
     *  Set to true to indicate PLLSYSCLK is derived from either INTOSC1 or
     *  or INTOSC2, set to false if PLLSYSCLK is derived from an external
     *  crystal (XTAL).
     */
    metaonly config Bool pllSourcedINTOSC = true;

    /*!
     *  Flash controller wait states configuration flag, default is true.
     *
     *  Set to true to configure the Flash controller wait states.  The number
     *  of wait states is computed based upon the CPU frequency.
     */
    metaonly config Bool configureFlashWaitStates = true;

    /*!
     *  Flash controller program cache enable flag, default is true.
     *
     *  Set to true to enable the Flash controller's program cache.
     */
    metaonly config Bool enableFlashProgramCache = true;

    /*!
     *  Flash controller data cache enable flag, default is true.
     *
     *  Set to true to enable the Flash controller's data cache.
     */
    metaonly config Bool enableFlashDataCache = true;

    /*!
     *  Boot from Flash flag.  Default is true.
     *
     *  Set to true to enable booting CM from Flash.
     */
    metaonly config Bool bootFromFlash = true;

    /*!
     *  ======== loadSegment ========
     *  Specifies where to load the Flash controller configuration function.
     *
     *  If 'configureFlashController' is true, then this parameter
     *  determines where the ".ti_sysbios_family_arm_f2838x_init_flashfuncs"
     *  section gets loaded.
     */
    metaonly config String loadSegment;

    /*!
     *  ======== runSegment ========
     *  Specifies where to run the Flash controller configuration function.
     *
     *  If 'configureFlashController' is true then this parameter
     *  determines where the ".ti_sysbios_family_arm_f2838x_init_flashfuncs"
     *  section gets executed at runtime.
     */
    metaonly config String runSegment;

internal:

    /* The computed Flash wait states */
    metaonly config UInt flashWaitStates;

    /*
     *  ======== init ========
     *  Generated entry point for Boot initialization.
     *
     *  Installed as an xdc.runtime.Reset function.
     */
    Void init();
};
