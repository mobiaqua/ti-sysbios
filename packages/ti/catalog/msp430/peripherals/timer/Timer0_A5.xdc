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
 *  ======== Timer0_A5 ========
 *  MSP430 Timer0_A5 timer
 */
metaonly module Timer0_A5 inherits ITimer_A {

instance:

    override config string name = "TimerA5";

    /*! Timer A5 Control Register */
    config TACTL_t TA0CTL = {
        TASSEL : TASSEL_0,
        ID : ID_0,
        MC : MC_0,
        TACLR : TACLR_OFF,
        TAIE : TAIE_OFF,
        TAIFG : TAIFG_OFF
    };

    /*! Capture/Compare Control 0 */
    config TACCTLx_t TA0CCTL0 = {
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
    config TACCTLx_t TA0CCTL1 = {
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
    config TACCTLx_t TA0CCTL2 = {
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
    config TACCTLx_t TA0CCTL3 = {
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
    config TACCTLx_t TA0CCTL4 = {
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

    config Bits16 TA0CCR0 = 0;                         /*! Capture/Compare 0 */
    config Bits16 TA0CCR1 = 0;                         /*! Capture/Compare 1 */
    config Bits16 TA0CCR2 = 0;                         /*! Capture/Compare 2 */
    config Bits16 TA0CCR3 = 0;                         /*! Capture/Compare 3 */
    config Bits16 TA0CCR4 = 0;                         /*! Capture/Compare 4 */

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[6];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TA0CTL"   , regForceSet : false },
        { register : "TA0CCTL0" , regForceSet : false },
        { register : "TA0CCTL1" , regForceSet : false },
        { register : "TA0CCTL2" , regForceSet : false },
        { register : "TA0CCTL3" , regForceSet : false },
        { register : "TA0CCTL4" , regForceSet : false },
        { register : "TA0CCR0"  , regForceSet : false },
        { register : "TA0CCR1"  , regForceSet : false },
        { register : "TA0CCR2"  , regForceSet : false },
        { register : "TA0CCR3"  , regForceSet : false },
        { register : "TA0CCR4"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,; 12-4-2015 21:40:22; /db/ztree/library/trees/platform/platform-q16/src/
 */

