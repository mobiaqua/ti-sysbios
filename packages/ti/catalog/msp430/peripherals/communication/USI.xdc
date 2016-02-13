/* 
 *  Copyright (c) 2008 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 *
 *  Contributors:
 *      Texas Instruments - initial implementation
 *
 * */
import ti.catalog.msp430.peripherals.clock.IClock;

/*!
 * Universal Serial Interface
 */
metaonly module USI inherits IUSI {
    /*
     *  ======== create ========
     */
    create(IClock.Instance clock);

instance:
    /*! @_nodoc */
    config IClock.Instance clock;

    /*! USI Control Register 0 */
    config USICTL0_t USICTL0 = {
        USIPE7      : USIPE7_OFF,
        USIPE6      : USIPE6_OFF,
        USIPE5      : USIPE5_OFF,
        USILSB      : USILSB_OFF,
        USIMST      : USIMST_OFF,
        USIGE       : USIGE_OFF,
        USIOE       : USIOE_OFF,
        USISWRST    : USISWRST,
    };

    /*! USI Control Register 1 */
    config USICTL1_t USICTL1 = {
        USICKPH     : USICKPH_OFF,
        USII2C      : USII2C_OFF,
        USISTTIE    : USISTTIE_OFF,
        USIIE       : USIIE_OFF,
        USIAL       : USIAL_OFF,
        USISTP      : USISTP_OFF,
        USISTTIFG   : USISTTIFG_OFF,
        USIIFG      : USIIFG,
    };

    /*! USI Clock Control Register */
    config USICKCTL_t USICKCTL = {
        USIDIV      : USIDIV_0,
        USISSEL     : USISSEL_0,
        USICKPL     : USICKPL_OFF,
        USISWCLK    : USISWCLK_OFF,
    };

    /*! USI Bit Counter Register */
    config USICNT_t USICNT = {
        USISCLREL   : USISCLREL_OFF,
        USI16B      : USI16B_OFF,
        USIIFGCC    : USIIFGCC_OFF,
        USICNT4     : USICNT4_OFF,
        USICNT3     : USICNT3_OFF,
        USICNT2     : USICNT2_OFF,
        USICNT1     : USICNT1_OFF,
        USICNT0     : USICNT0_OFF,
    };

    /*! USI interrupt enables */
    config regIntVect_t interruptSource[2];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "USICTL0"    , regForceSet : false },
        { register : "USICTL1"    , regForceSet : false },
        { register : "USICKCTL"   , regForceSet : false },
        { register : "USICNT"     , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.communication; 1, 0, 0,; 12-4-2015 21:40:13; /db/ztree/library/trees/platform/platform-q16/src/
 */

