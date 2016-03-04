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
 *  ======== SR ========
 *  MSP430 Status Register
 */
metaonly module SR inherits xdc.platform.IPeripheral {

    /* System clock generator 1. This bit, when set, turns off the SMCLK. */
    enum SCG1_t {
        SCG1_OFF   = 0x0000,              /*! Disable System clock generator 1 */
        SCG1       = 0x0080               /*! Enable System clock generator 1 */
    };
    
    enum SCG0_t {
        SCG0_OFF   = 0x0000,              /*! Disable System clock generator 0 */
        SCG0       = 0x0040               /*! Enable System clock generator 0 */
    };
    
    enum OSCOFF_t {
        OSCOFF_OFF = 0x0000,              /*! Oscillator On */
        OSCOFF     = 0x0020               /*! Oscillator Off */  
    };
    
    /* CPU off. This bit, when set, turns off the CPU. */
    enum CPUOFF_t {
        CPUOFF_OFF = 0x0000,              /*! CPU On */
        CPUOFF     = 0x0010               /*! CPU Off */     
    };

    enum GIE_t {
        GIE_OFF    = 0x0000,              /*! General interrupt disable */
        GIE        = 0x0008               /*! General interrupt enable */
    };
          
    /* SR */
    struct SR_t {
        SCG1_t      SCG1;                 /*! System clock generator 1
                                           *This bit, when set, turns off the SMCLK.
                                           */
        SCG0_t      SCG0;                 /*! System clock generator 0
                                           *This bit, when set, turns off the DCO dc
                                           *generator, if DCOCLK is not used for MCLK
                                           *or SMCLK.
                                           */
        OSCOFF_t    OSCOFF;               /*!Oscillator Off
                                           *This bit, when set, turns off the LFXT1 
                                           *crystal oscillator, when LFXT1CLK is not
                                           *use for MCLK or SMCLK
                                           */
        CPUOFF_t    CPUOFF;               /*! CPU off
                                           *This bit, when set, turns off the CPU.
                                           */
        GIE_t       GIE;                  /*! General interrupt enable
                                           *This bit, when set, enables maskable
                                           *interrupts. When reset, all maskable 
                                           *interrupts are disabled
                                           */
    }

   /*!
    *  ======== ForceSetDefaultRegister_t ========
    *  Force Set Default Register
    *
    *  Type to store if each register needs to be forced initialized
    *  even if the register is in default state.
    *
    *  @see #ForceSetDefaultRegister_t
    */
    struct ForceSetDefaultRegister_t {
        String     register;
        Bool       regForceSet;
    }
    
instance:
    /*! SR, Status Register */
    config SR_t SR = {
        SCG1        : SCG1_OFF,
        SCG0        : SCG0_OFF,
        OSCOFF      : OSCOFF_OFF,
        CPUOFF      : CPUOFF_OFF,
        GIE         : GIE_OFF
    };
    
   /*!
    *  ======== getSCG1 ========
    *  Gets SCG1 bit
    *
    *  @see #getSCG1
    */
    Bool    getSCG1();
    
   /*!
    *  ======== setSCG1 ========
    *  Sets SCG1 bit
    *
    *  @see #setSCG1
    */
    Bool    setSCG1(Bool set);

   /*!
    *  ======== getSCG0 ========
    *  Gets SCG0 bit
    *
    *  @see #getSCG0
    */
    Bool    getSCG0();
    
   /*!
    *  ======== setSCG0 ========
    *  Sets SCG0 bit
    *
    *  @see #setSCG0
    */
    Bool    setSCG0(Bool set);
    
   /*!
    *  ======== getOSCOFF ========
    *  Gets OSCOFF bit
    *
    *  @see #getOSCOFF
    */
    Bool    getOSCOFF();
    
   /*!
    *  ======== setOSCOFF ========
    *  Sets OSCOFF bit
    *
    *  @see #setOSCOFF
    */
    Bool    setOSCOFF(Bool set);
    
    /*!
    *  ======== getCPUOFF ========
    *  Gets CPUOFF bit
    *
    *  @see #getCPUOFF
    */
    Bool    getCPUOFF();
    
   /*!
    *  ======== setCPUOFF ========
    *  Sets CPUOFF bit
    *
    *  @see #setCPUOFF
    */
    Bool    setCPUOFF(Bool set);

    /*!
    *  ======== getGIE ========
    *  Gets GIE bit
    *
    *  @see #getGIE
    */
    Bool    getGIE();
    
   /*!
    *  ======== setGIE ========
    *  Sets GIE bit
    *
    *  @see #setGIE
    */
    Bool    setGIE(Bool set);
    
    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "SR" , regForceSet : false },
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.special_function; 1, 0, 0,2; 1-29-2016 10:00:57; /db/ztree/library/trees/platform/platform-q17/src/
 */

