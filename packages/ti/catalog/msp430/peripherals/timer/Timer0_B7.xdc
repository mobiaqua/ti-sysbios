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
 *  ======== Timer0_B7 ========
 *  MSP430 Timer0_B7 timer
 */
metaonly module Timer0_B7 inherits ITimer_B {

    /*! TB07IV Definitions */
    enum IVValues {
        TB0IV_NONE = 0x0000,                 /*! No Interrupt pending */
        TB0IV_TBCCR1 = 0x0002,               /*! TBCCR1_CCIFG */
        TB0IV_TBCCR2 = 0x0004,               /*! TBCCR2_CCIFG */
        TB0IV_TBCCR3 = 0x0006,               /*! TBCCR3_CCIFG */
        TB0IV_TBCCR4 = 0x0008,               /*! TBCCR4_CCIFG */
        TB0IV_TBCCR5 = 0x000A,               /*! TBCCR5_CCIFG */
        TB0IV_TBCCR6 = 0x000C,               /*! TBCCR6_CCIFG */
        TB0IV_TBIFG = 0x000E                 /*! TBIFG */
    };

instance:
    /*! TB0CTL, Timer_B7 Control Register */
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
    
    /*! TB0CCTL3, Capture/Compare Control Register 3 */
    config TBCCTLx_t TB0CCTL3 = {
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
    
    /*! TB0CCTL4, Capture/Compare Control Register 4 */
    config TBCCTLx_t TB0CCTL4 = {
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
    
    /*! TB0CCTL5, Capture/Compare Control Register 5 */
    config TBCCTLx_t TB0CCTL5 = {
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
    
    /*! TB0CCTL6, Capture/Compare Control Register 6 */
    config TBCCTLx_t TB0CCTL6 = {
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
    /*! TB0CCR3, Timer_B Capture/Compare Register 3 */
    config Bits16 TB0CCR3 = 0;
    /*! TB0CCR4, Timer_B Capture/Compare Register 4 */
    config Bits16 TB0CCR4 = 0;
    /*! TB0CCR5, Timer_B Capture/Compare Register 5 */
    config Bits16 TB0CCR5 = 0;
    /*! TB0CCR6, Timer_B Capture/Compare Register 6 */
    config Bits16 TB0CCR6 = 0;

    /*! Timer interrupt enables */
    config regIntVect_t interruptSource[8];

    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "TB0CTL"   , regForceSet : false },
        { register : "TB0CCTL0" , regForceSet : false },
        { register : "TB0CCTL1" , regForceSet : false },
        { register : "TB0CCTL2" , regForceSet : false },
        { register : "TB0CCTL3" , regForceSet : false },
        { register : "TB0CCTL4" , regForceSet : false },
        { register : "TB0CCTL5" , regForceSet : false },
        { register : "TB0CCTL6" , regForceSet : false },
        { register : "TB0CCR0"  , regForceSet : false },
        { register : "TB0CCR1"  , regForceSet : false },
        { register : "TB0CCR2"  , regForceSet : false },
        { register : "TB0CCR3"  , regForceSet : false },
        { register : "TB0CCR4"  , regForceSet : false },
        { register : "TB0CCR5"  , regForceSet : false },
        { register : "TB0CCR6"  , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,2; 1-29-2016 10:00:58; /db/ztree/library/trees/platform/platform-q17/src/
 */

