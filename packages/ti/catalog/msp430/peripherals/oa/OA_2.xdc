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
 *  ======== OA_2 ========
 *  MSP430 General Purpose Operational Amplifier
 *
 *  The module is named OA_2 because it only supports two OAs. A device
 *  containing three op-amps would require a separate module.
 */
metaonly module OA_2 inherits IOA {
    /*!
     *  ======== create ========
     *  Create an instance of this peripheral
     */
    create();
    
instance:
    /*! OA0 control register 0 */    
    config OAxCTL0_t OA0CTL0 = {
      OAN : OAN_0,
      OAP : OAP_0,
      OAPM : OAPM_0,
      OAADC0 : OAADC0_OFF,
      OAADC1 : OAADC1_OFF 
    };

    /*! OA0 control register 1 */    
    config OAxCTL1_t OA0CTL1 = {
      OAFBR : OAFBR_0,
      OAFC : OAFC_0,
      OANEXT : OANEXT_OFF,
      OARRIP : OARRIP_OFF, 
    };
    
    /*! OA1 control register 0 */    
    config OAxCTL0_t OA1CTL0 = {
      OAN : OAN_0,
      OAP : OAP_0,
      OAPM : OAPM_0,
      OAADC0 : OAADC0_OFF,
      OAADC1 : OAADC1_OFF 
    };

    /*! OA1 control register 1 */    
    config OAxCTL1_t OA1CTL1 = {
      OAFBR : OAFBR_0,
      OAFC : OAFC_0,
      OANEXT : OANEXT_OFF,
      OARRIP : OARRIP_OFF, 
    };
    
    /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "OA0CTL0" , regForceSet : false },
        { register : "OA0CTL1" , regForceSet : false },
        { register : "OA1CTL0" , regForceSet : false },
        { register : "OA1CTL1" , regForceSet : false }
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.oa; 1, 0, 0,2; 1-29-2016 10:00:54; /db/ztree/library/trees/platform/platform-q17/src/
 */

