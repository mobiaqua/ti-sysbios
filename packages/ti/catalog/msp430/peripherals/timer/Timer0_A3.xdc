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
 *  ======== Timer0_A3 ========
 *  MSP430 Timer0_A3 timer
 */
metaonly module Timer0_A3 inherits ITimer_A {

instance:
    /*! TA0CTL, Timer_A3 Control Register */
    config TACTL_t TA0CTL = {
        TASSEL : TASSEL_0,
        ID : ID_0,
        MC : MC_0,
        TACLR : TACLR_OFF,
        TAIE : TAIE_OFF,
        TAIFG : TAIFG_OFF
    };

    /*! TA0CCTL0, Capture/Compare Control Register 0 */
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

    /*! TA0CCTL1, Capture/Compare Control Register 1 */
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

    /*! TA0CCTL2, Capture/Compare Control Register 2 */
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

    /*! TA0CCR0, Timer_A Capture/Compare Register 0 */
    config Bits16 TA0CCR0 = 0;
    /*! TA0CCR1, Timer_A Capture/Compare Register 1 */
    config Bits16 TA0CCR1 = 0;
    /*! TA0CCR2, Timer_A Capture/Compare Register 2 */
    config Bits16 TA0CCR2 = 0;

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[4];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TA0CTL"   , regForceSet : false },
        { register : "TA0CCTL0" , regForceSet : false },
        { register : "TA0CCTL1" , regForceSet : false },
        { register : "TA0CCTL2" , regForceSet : false },
        { register : "TA0CCR0"  , regForceSet : false },
        { register : "TA0CCR1"  , regForceSet : false },
        { register : "TA0CCR2"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,2; 1-29-2016 10:00:58; /db/ztree/library/trees/platform/platform-q17/src/
 */

