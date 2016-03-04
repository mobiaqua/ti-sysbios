/* 
 *  Copyright (c) 2015 Texas Instruments and others.
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
 *  ======== Timer3_A5 ========
 *  MSP430 Timer3_A5 timer
 */
metaonly module Timer3_A5 inherits ITimer_A {

instance:
    /*! TA3CTL, Timer3_A5 Control Register */
    config TACTL_t TA3CTL = {
        TASSEL : TASSEL_0,
        ID : ID_0,
        MC : MC_0,
        TACLR : TACLR_OFF,
        TAIE : TAIE_OFF,
        TAIFG : TAIFG_OFF
    };

    /*! TA3CCTL0, Capture/Compare Control Register 0 */
    config TACCTLx_t TA3CCTL0 = {
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

    /*! TA3CCTL1, Capture/Compare Control Register 1 */
    config TACCTLx_t TA3CCTL1 = {
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

    /*! TA3CCTL2, Capture/Compare Control Register 2 */
    config TACCTLx_t TA3CCTL2 = {
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

    /*! TA3CCTL3, Capture/Compare Control Register 3 */
    config TACCTLx_t TA3CCTL3 = {
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

    /*! TA3CCTL4, Capture/Compare Control Register 4 */
    config TACCTLx_t TA3CCTL4 = {
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

    /*! TA3CCR0, Timer_A Capture/Compare Register 0 */
    config Bits16 TA3CCR0 = 0;
    /*! TA3CCR1, Timer_A Capture/Compare Register 1 */
    config Bits16 TA3CCR1 = 0;
    /*! TA3CCR2, Timer_A Capture/Compare Register 2 */
    config Bits16 TA3CCR2 = 0;
    /*! TA3CCR3, Timer_A Capture/Compare Register 3 */
    config Bits16 TA3CCR3 = 0;
    /*! TA3CCR4, Timer_A Capture/Compare Register 4 */
    config Bits16 TA3CCR4 = 0;

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[6];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TA3CTL"   , regForceSet : false },
        { register : "TA3CCTL0" , regForceSet : false },
        { register : "TA3CCTL1" , regForceSet : false },
        { register : "TA3CCR0"  , regForceSet : false },
        { register : "TA3CCR1"  , regForceSet : false },
        { register : "TA3CCR2"  , regForceSet : false },
        { register : "TA3CCR3"  , regForceSet : false },
        { register : "TA3CCR4"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,2; 1-29-2016 10:00:58; /db/ztree/library/trees/platform/platform-q17/src/
 */

