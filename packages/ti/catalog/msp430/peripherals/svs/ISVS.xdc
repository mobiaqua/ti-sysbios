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
 *  ======== ISVS ========
 *  MSP430 ISVS interface
 */
metaonly interface ISVS inherits xdc.platform.IPeripheral {

     /*! VLD3 Bit */
     enum VLD3_t {
        VLD3_OFF = 0x00,
        VLD3 = 0x80
     };
     /*! VLD2 Bit */
     enum VLD2_t {
        VLD2_OFF = 0x00,
        VLD2 = 0x40
     };
     /*! VLD1 Bit */
     enum VLD1_t {
         VLD1_OFF = 0x00,
         VLD1 = 0x20
     };
     /*! VLD0 Bit */
     enum VLD0_t {
        VLD0_OFF = 0x00,
        VLD0 = 0x10
     };
     /*! PORON Bit */ 
     enum PORON_t {
         PORON_OFF = 0x00,   /*! SVSFG does not cause a POR */
         PORON = 0x08        /*! SVSFG causes a POR */
      };
     /*! SVSON Bit */
     enum SVSON_t {
        SVSON_OFF = 0x00,
        SVSON = 0x04
     };
     /*! SVSOP Bit */
     enum SVSOP_t {
        SVSOP_OFF = 0x00,
        SVSOP = 0x02
     };
     /*! SVSFG Bit */
     enum SVSFG_t {
        SVSFG_OFF = 0x00,
        SVSFG = 0x01
     };

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
    
}
/*
 *  @(#) ti.catalog.msp430.peripherals.svs; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

