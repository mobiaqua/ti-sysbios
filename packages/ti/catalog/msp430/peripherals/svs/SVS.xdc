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
 *  ======== Svs ========
 *  MSP430F2xx Family SVS Module
 */
metaonly module SVS inherits ISVS {

    /*! SVSCTL Register */
    struct SVSCTL_t {
        VLD3_t VLD3;   /*! Voltage level detect. These bits turn on the SVS and select 
                        * the nominal SVS threshold voltage level. See the device specific
                        * data sheet for parameters. 
                        * 0000 SVS is off
                        * 0001 1.9 V
                        * 0010 2.1 V
                        * 0011 2.2 V
                        * 0100 2.3 V
                        * 0101 2.4 V
                        * 0110 2.5 V
                        * 0111 2.65 V
                        * 1000 2.8 V
                        * 1001 2.9 V
                        * 1010 3.05
                        * 1011 3.2 V
                        * 1100 3.35 V
                        * 1101 3.5 V
                        * 1110 3.7 V
                        * 1111 Compares external input voltage SVSIN to 1.25 V. */
        VLD2_t VLD2;   /*! Voltage level detect. These bits turn on the SVS and select 
                        * the nominal SVS threshold voltage level. See the device specific
                        * data sheet for parameters.
                        * 0000 SVS is off
                        * 0001 1.9 V
                        * 0010 2.1 V
                        * 0011 2.2 V
                        * 0100 2.3 V
                        * 0101 2.4 V
                        * 0110 2.5 V
                        * 0111 2.65 V
                        * 1000 2.8 V
                        * 1001 2.9 V
                        * 1010 3.05
                        * 1011 3.2 V
                        * 1100 3.35 V
                        * 1101 3.5 V
                        * 1110 3.7 V
                        * 1111 Compares external input voltage SVSIN to 1.25 V. */
        VLD1_t VLD1;   /*! Voltage level detect. These bits turn on the SVS and select 
                        * the nominal SVS threshold voltage level. See the device specific
                        * data sheet for parameters.
                        * 0000 SVS is off
                        * 0001 1.9 V
                        * 0010 2.1 V
                        * 0011 2.2 V
                        * 0100 2.3 V
                        * 0101 2.4 V
                        * 0110 2.5 V
                        * 0111 2.65 V
                        * 1000 2.8 V
                        * 1001 2.9 V
                        * 1010 3.05
                        * 1011 3.2 V
                        * 1100 3.35 V
                        * 1101 3.5 V
                        * 1110 3.7 V
                        * 1111 Compares external input voltage SVSIN to 1.25 V. */
        VLD0_t VLD0;   /*! Voltage level detect. These bits turn on the SVS and select 
                        * the nominal SVS threshold voltage level. See the device specific
                        * data sheet for parameters.
                        * 0000 SVS is off
                        * 0001 1.9 V
                        * 0010 2.1 V
                        * 0011 2.2 V
                        * 0100 2.3 V
                        * 0101 2.4 V
                        * 0110 2.5 V
                        * 0111 2.65 V
                        * 1000 2.8 V
                        * 1001 2.9 V
                        * 1010 3.05
                        * 1011 3.2 V
                        * 1100 3.35 V
                        * 1101 3.5 V
                        * 1110 3.7 V
                        * 1111 Compares external input voltage SVSIN to 1.25 V. */
        PORON_t PORON; /*! POR on. This bit enables the SVSFG flag to 
                        * cause a POR device reset.
                        * 0 SVSFG does not cause a POR
                        * 1 SVSFG causes a POR */
        SVSON_t SVSON; /*! SVS on. This bit reflects the status of SVS operation. This bit DOES NOT turn
                        * on the SVS. The SVS is turned on by setting VLDx > 0.
                        * 0 SVS is Off
                        * 1 SVS is On */
        SVSOP_t SVSOP; /*! SVS output. This bit reflects the output value of the SVS comparator.
                        * 0 SVS comparator output is low
                        * 1 SVS comparator output is high */
        SVSFG_t SVSFG; /*! SVS flag. This bit indicates a low voltage condition. SVSFG remains set after
                        * a low voltage condition until reset by software.
                        * 0 No low voltage condition occurred
                        * 1 A low condition is present or has occurred */
  }
    /*!
     *  ======== create ========
     *  Create an instance of this peripheral. 
     */
    create();
    
instance:
   /*! SVSCTL Register */
    config SVSCTL_t SVSCTL = {
        VLD3    :    VLD3_OFF,
        VLD2    :    VLD2_OFF,        
        VLD1    :    VLD1_OFF,        
        VLD0    :    VLD0_OFF,
        PORON   :    PORON_OFF,
        SVSON   :    SVSON_OFF,
        SVSOP   :    SVSOP_OFF,
        SVSFG   :    SVSFG_OFF
     };   
     /*! Determine if each Register needs to be forced set or not */
    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[] =
    [
        { register : "SVSCTL" , regForceSet : false }
    ];
  
}
/*
 *  @(#) ti.catalog.msp430.peripherals.svs; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

