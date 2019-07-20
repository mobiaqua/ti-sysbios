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
 */
/*
 *  ======== Boot.xdc ========
 *
 */

package ti.sysbios.family.c28.f2838x.init;

import xdc.rov.ViewInfo;

/*!
 *  ======== Boot ========
 *  TMS320F2838X Boot Support.
 *
 *  The Boot module supports boot initialization for the C28 cores.
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
@NoRuntime
module Boot
{
    /*! Oscillator Clock Source Select Bit for OSCCLK */
    metaonly enum OscClk {
        OscClk_INTOSC2  = 0x0, /*! INTOSC2 (default on reset) */
        OscClk_XTAL     = 0x1, /*! External oscillator */
        OscClk_INTOSC1  = 0x2, /*! INTOSC1 */
        OscClk_RESERVED = 0x3  /*! Reserved (default to INTOSC1) */
    }

    /*! CM Clock Source Select */
    metaonly enum SrcCM {
        SrcCM_AuxPLL = 0,      /*! Auxillary PLL */
        SrcCM_SystemPLL = 1    /*! System PLL */
    };

    /*! CM Clock Divider value */
    metaonly enum Div {
        Div_1 = 0,   /*! /1 */
        Div_2 = 1,   /*! /2 */
        Div_3 = 2,   /*! /3 */
        Div_4 = 3,   /*! /4 */
        Div_5 = 4,   /*! /5 */
        Div_6 = 5,   /*! /6 */
        Div_7 = 6,   /*! /7 */
        Div_8 = 7    /*! /8 */
    };

    metaonly struct ModuleView {
        Bool disableWatchdog;
        Bool configureClocks;
        Bool configureFlashController;
        Bool configureFlashWaitStates;
        Bool enableFlashProgramCache;
        Bool enableFlashDataCache;
        Bool configureSharedRAMs;
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
     *  Watchdog disable flag, default is false.
     *
     *  Set to true to disable the watchdog timer.
     */
    metaonly config Bool disableWatchdog = false;

    /*!
     *  Clock configuration flag, default is false.
     *
     *  Set to true to configure the PLL and system subsystem clock
     *  dividers.
     */
    config Bool configureClocks = false;

    /*!
     *  Oscillator Clock source select bit for OSCCLK
     *
     *  The default on reset is INTOSC2
     */
    metaonly config OscClk OSCCLKSRCSEL = OscClk_INTOSC2;

    /*!
     *  OSCCLK input frequency to PLL, in MHz.
     *
     *  This is the frequency of the oscillator clock (OSCCLK) input to the
     *  PLL.  The default internal oscillator is 10 Mhz.
     */
    metaonly config UInt OSCCLK = 10;

    /*! System PLL Integer Multiplier (SPLLIMULT) value */
    metaonly config UInt SPLLIMULT = 38;

    /*! System PLL Reference Clock Divider (REFDIV) value */
    metaonly config UInt SPLLREFDIV = 0;

    /*! System PLL Output Clock Divider (ODIV) value */
    metaonly config UInt SPLLODIV = 1;

    /*! System Clock Divider Select (SYSCLKDIVSEL) value */
    metaonly config UInt SYSCLKDIVSEL = 0;

    /*! CM Clock source select bit (CMDIVSRCSEL) */
    metaonly config SrcCM CMDIVSRCSEL = SrcCM_SystemPLL;

    /*! CM Clock Divider Select (CMCLKDIV) value */
    metaonly config Div CMCLKDIV = Div_2;

    /*!
     *  Function to be called when Limp mode is detected.
     *
     *  This function is called when the Boot module is about to configure
     *  the PLL, but finds the device operating in Limp mode (i.e., the mode
     *  when a missing OSCCLK input has been detected).
     *
     *  If this function is not specified by the application, a default
     *  function will be used, which spins in an infinite loop.
     */
    metaonly config Fxn limpAbortFunction;

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
     *  Set to true to enable booting CPU1 from Flash.
     */
    metaonly config Bool bootFromFlash = true;

    /*!
     *  Configure Shared RAM region ownership.
     *  Default is false.
     *
     *  Set to true to enable configuration of Shared RAM region
     *  ownership.
     */
    metaonly config Bool configureSharedRAMs = false;

   /*!
     *  ======== sharedMemoryOwnerMask ========
     *  Shared RAM owner select mask.
     *
     *  This parameter is used for writing the GSxMSEL register.
     *  By default, each value of each shared RAM select bit is '0'.
     *  This means the CPU1 is the owner and has write access.
     *  Setting a '1' in any bit position makes CPU2 the owner of that
     *  shared RAM segment.
     */
    metaonly config Bits32 sharedMemoryOwnerMask = 0;

    /*!
     *  ======== loadSegment ========
     *  Specifies where to load the Flash controller configuration function
     *  (include the 'PAGE' number)
     *
     *  If 'configureFlashController' is true, then this parameter
     *  determines where the ".ti_sysbios_family_c28_f2838x_init_flashfuncs"
     *  section gets loaded.
     */
    metaonly config String loadSegment;

    /*!
     *  ======== runSegment ========
     *  Specifies where to run the Flash controller configuration function
     *  (include the 'PAGE' number)
     *
     *  If 'configureFlashController' is true then this parameter
     *  determines where the ".ti_sysbios_family_c28_f2838x_init_flashfuncs"
     *  section gets executed at runtime.
     */
    metaonly config String runSegment;

    /*!
     *  @_nodoc
     *  ======== getFrequency ========
     *  Gets the resulting CPU frequency (in Hz) given the Clock
     *  configuration parameters.
     *
     */
    UInt32 getFrequency();

    /*!
     *  @_nodoc
     *  ======== registerFreqListener ========
     *  Register a module to be notified whenever the frequency changes.
     *
     *  The registered module must have a function named 'fireFrequencyUpdate'
     *  which takes the new frequency as an argument.
     */
    function registerFreqListener();

internal:

    /* The computed timestamp frequency */
    metaonly config UInt timestampFreq;

    /* Used to display the computed CPU frequency value */
    metaonly config String displayFrequency;

    /* The computed Flash wait states */
    metaonly config UInt flashWaitStates;
};
