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
 *  ======== Timer_A5 ========
 *  MSP430 Timer_A5 timer
 */
metaonly module Timer_A5 inherits ITimer_A {

instance:

    override config string name = "TimerA5";

    /*! Timer A5 Control Register */
    config TACTL_t TAxCTL = {
        TASSEL : TASSEL_0,
        ID : ID_0,
        MC : MC_0,
        TACLR : TACLR_OFF,
        TAIE : TAIE_OFF,
        TAIFG : TAIFG_OFF
    };

    /*! Capture/Compare Control 0 */
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

    /*! Capture/Compare Control 1 */
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

    /*! Capture/Compare Control 2 */
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

    /*! Capture/Compare Control 3 */
    config TACCTLx_t TACCTL3 = {
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

    /*! Capture/Compare Control 4 */
    config TACCTLx_t TACCTL4 = {
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

    config Bits16 TACCR0 = 0;                         /*! Capture/Compare 0 */
    config Bits16 TACCR1 = 0;                         /*! Capture/Compare 1 */
    config Bits16 TACCR2 = 0;                         /*! Capture/Compare 2 */
    config Bits16 TACCR3 = 0;                         /*! Capture/Compare 3 */
    config Bits16 TACCR4 = 0;                         /*! Capture/Compare 4 */

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[6];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TACTL"   , regForceSet : false },
        { register : "TACCTL0" , regForceSet : false },
        { register : "TACCTL1" , regForceSet : false },
        { register : "TACCTL2" , regForceSet : false },
        { register : "TACCTL3" , regForceSet : false },
        { register : "TACCTL4" , regForceSet : false },
        { register : "TACCR0"  , regForceSet : false },
        { register : "TACCR1"  , regForceSet : false },
        { register : "TACCR2"  , regForceSet : false },
        { register : "TACCR3"  , regForceSet : false },
        { register : "TACCR4"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,; 12-4-2015 21:40:22; /db/ztree/library/trees/platform/platform-q16/src/
 */

