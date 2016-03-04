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
/*!
 *  ======== Timer_A3 ========
 *  MSP430 Timer_A3 timer
 */
metaonly module Timer_A3 inherits ITimer_A {

instance:
    /*! TACTL, Timer_A3 Control Register */
    config TACTL_t TACTL = {
        TASSEL : TASSEL_0,
        ID : ID_0,
        MC : MC_0,
        TACLR : TACLR_OFF,
        TAIE : TAIE_OFF,
        TAIFG : TAIFG_OFF
    };

    /*! TACCTL0, Capture/Compare Control Register 0 */
    config TACCTLx_t TACCTL0 = {
        CM : CM_0,
        CCIS : CCIS_0,
        SCS : SCS_OFF,
        SCCI : SCCI_OFF,
        CAP : CAP_OFF,
        OUTMOD : OUTMOD_0,
        CCIE : CCIE_OFF,
        CCI : CCI_OFF,
        OUT : OUT_OFF,
        COV : COV_OFF,
        CCIFG : CCIFG_OFF
    };

    /*! TACCTL1, Capture/Compare Control Register 1 */
    config TACCTLx_t TACCTL1 = {
        CM : CM_0,
        CCIS : CCIS_0,
        SCS : SCS_OFF,
        SCCI : SCCI_OFF,
        CAP : CAP_OFF,
        OUTMOD : OUTMOD_0,
        CCIE : CCIE_OFF,
        CCI : CCI_OFF,
        OUT : OUT_OFF,
        COV : COV_OFF,
        CCIFG : CCIFG_OFF
    };

    /*! TACCTL2, Capture/Compare Control Register 2 */
    config TACCTLx_t TACCTL2 = {
        CM : CM_0,
        CCIS : CCIS_0,
        SCS : SCS_OFF,
        SCCI : SCCI_OFF,
        CAP : CAP_OFF,
        OUTMOD : OUTMOD_0,
        CCIE : CCIE_OFF,
        CCI : CCI_OFF,
        OUT : OUT_OFF,
        COV : COV_OFF,
        CCIFG : CCIFG_OFF
    };

    /*! TACCR0, Timer_A Capture/Compare Register 0 */
    config Bits16 TACCR0 = 0;
    /*! TACCR1, Timer_A Capture/Compare Register 1 */
    config Bits16 TACCR1 = 0;
    /*! TACCR2, Timer_A Capture/Compare Register 2 */
    config Bits16 TACCR2 = 0;

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[4];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TACTL"   , regForceSet : false },
        { register : "TACCTL0" , regForceSet : false },
        { register : "TACCTL1" , regForceSet : false },
        { register : "TACCTL2" , regForceSet : false },
        { register : "TACCR0"  , regForceSet : false },
        { register : "TACCR1"  , regForceSet : false },
        { register : "TACCR2"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,2; 1-29-2016 10:00:59; /db/ztree/library/trees/platform/platform-q17/src/
 */

