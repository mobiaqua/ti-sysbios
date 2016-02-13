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
 *  ======== Timer1_A2 ========
 *  MSP430 Timer1_A2 timer
 */
metaonly module Timer1_A2 inherits ITimer_A {

instance:
    /*! TA1CTL, Timer1_A2 Control Register */
    config TACTL_t TA1CTL = {
        TASSEL : TASSEL_0,
        ID : ID_0,
        MC : MC_0,
        TACLR : TACLR_OFF,
        TAIE : TAIE_OFF,
        TAIFG : TAIFG_OFF
    };

    /*! TA1CCTL0, Capture/Compare Control Register 0 */
    config TACCTLx_t TA1CCTL0 = {
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

    /*! TA1CCTL1, Capture/Compare Control Register 1 */
    config TACCTLx_t TA1CCTL1 = {
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

    /*! TA1CCR0, Timer_A Capture/Compare Register 0 */
    config Bits16 TA1CCR0 = 0;
    /*! TA1CCR1, Timer_A Capture/Compare Register 1 */
    config Bits16 TA1CCR1 = 0;

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[3];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TA1CTL"   , regForceSet : false },
        { register : "TA1CCTL0" , regForceSet : false },
        { register : "TA1CCTL1" , regForceSet : false },
        { register : "TA1CCR0"  , regForceSet : false },
        { register : "TA1CCR1"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,; 12-4-2015 21:40:22; /db/ztree/library/trees/platform/platform-q16/src/
 */

