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
 *  ======== Timer0_B3 ========
 *  MSP430 Timer0_B3 timer
 */
metaonly module Timer0_B3 inherits ITimer_B {

instance:
    /*! TB0CTL, Timer_B3 Control Register */
    config TBCTL_t TB0CTL = {
        TBCLGRP : TBCLGRP_0,
        CNTL : CNTL_0,
        TBSSEL : TBSSEL_0,
        ID : ID_0,
        MC : MC_0,
        TBCLR : TBCLR_OFF,
        TBIE : TBIE_OFF,
        TBIFG : TBIFG_OFF
    };


    /*! TB0CCTL0, Capture/Compare Control Register 0 */
    config TBCCTLx_t TB0CCTL0 = {
        CM : CM_0,
        CCIS : CCIS_0,
        SCS : SCS_OFF,
        CLLD : CLLD_0,
        CAP : CAP_OFF,
        OUTMOD : OUTMOD_0,
        CCIE : CCIE_OFF,
        CCI : CCI_OFF,
        OUT : OUT_OFF,
        COV : COV_OFF,
        CCIFG : CCIFG_OFF
    };

    /*! TB0CCTL1, Capture/Compare Control Register 1 */
    config TBCCTLx_t TB0CCTL1 = {
        CM : CM_0,
        CCIS : CCIS_0,
        SCS : SCS_OFF,
        CLLD : CLLD_0,
        CAP : CAP_OFF,
        OUTMOD : OUTMOD_0,
        CCIE : CCIE_OFF,
        CCI : CCI_OFF,
        OUT : OUT_OFF,
        COV : COV_OFF,
        CCIFG : CCIFG_OFF
    };

    /*! TB0CCTL2, Capture/Compare Control Register 2 */
    config TBCCTLx_t TB0CCTL2 = {
        CM : CM_0,
        CCIS : CCIS_0,
        SCS : SCS_OFF,
        CLLD : CLLD_0,
        CAP : CAP_OFF,
        OUTMOD : OUTMOD_0,
        CCIE : CCIE_OFF,
        CCI : CCI_OFF,
        OUT : OUT_OFF,
        COV : COV_OFF,
        CCIFG : CCIFG_OFF
    };

    /*! TB0CCR0, Timer_B Capture/Compare Register 0 */
    config Bits16 TB0CCR0 = 0;
    /*! TB0CCR1, Timer_B Capture/Compare Register 1 */
    config Bits16 TB0CCR1 = 0;
    /*! TB0CCR2, Timer_B Capture/Compare Register 2 */
    config Bits16 TB0CCR2 = 0;

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[4];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TB0CTL"   , regForceSet : false },
        { register : "TB0CCTL0" , regForceSet : false },
        { register : "TB0CCTL1" , regForceSet : false },
        { register : "TB0CCTL2" , regForceSet : false },
        { register : "TB0CCR0"  , regForceSet : false },
        { register : "TB0CCR1"  , regForceSet : false },
        { register : "TB0CCR2"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,; 12-4-2015 21:40:22; /db/ztree/library/trees/platform/platform-q16/src/
 */

