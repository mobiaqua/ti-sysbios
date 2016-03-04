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
 *  ======== IComparator ========
 *  MSP430 IComparator interface
 */
metaonly interface IComparator inherits xdc.platform.IPeripheral {

    /*! CAEX Bit */
    enum CAEX_t {
        CAEX_OFF = 0x0000,          /*! Disable CAEX bit */
        CAEX     = 0x0080           /*! Enable  CAEX bit */
    };

    /*! CARSEL Bit */
    enum CARSEL_t {
        CARSEL_OFF     = 0x0000,    /*! Disable CARSEL bit */
        CARSEL         = 0x0040     /*! Enable  CARSEL bit */
     };

     /*! CAREF Bit */
     enum CAREF_t {
         CAREF_0 = 0x0000,          /*! Reference Off */
         CAREF_1 = 0x0010,          /*! 0.25 * VCC */
         CAREF_2 = 0x0020,          /*! 0.50 * VCC */
         CAREF_3 = 0x0030           /*! Diode Reference */
     };

    /*! CAON Bit */
    enum CAON_t {
         CAON_OFF = 0x0000,         /*! Disable CAON bit */
         CAON = 0x0008              /*! Enable  CAON bit */
      };

    /*! CAIES Bit */
     enum CAIES_t {
         CAIES_OFF = 0x0000,        /*! Rising Edge */
         CAIES = 0x0004             /*! Falling Edge */
     };

     /*! CAIE Bit */
     enum CAIE_t {
         CAIE_OFF = 0x0000,         /*! Disable CAIE bit */
         CAIE = 0x0002              /*! Enable  CAIE bit */
     };

     /*! CAIFG Bit */
     enum CAIFG_t {
         CAIFG_OFF = 0x0000,        /*! Disable CAIFG bit */
         CAIFG = 0x0001             /*! Enable  CAIFG bit */
     };

     /*! CASHORT Bit */
     enum CASHORT_t {
         CASHORT_OFF = 0x0000,      /*! Disable CASHORT bit */
         CASHORT = 0x0080           /*! Enable  CASHORT bit */
     };

     /*! P2CA4 Bit */
     enum P2CA4_t {
         P2CA4_OFF = 0x0000,        /*! Disable P2CA4 bit */
         P2CA4 = 0x0040             /*! Enable  P2CA4 bit */
     };

      /*! P2CA3 Bit */
     enum P2CA3_t {
         P2CA3_OFF = 0x0000,        /*! Disable P2CA3 bit */
         P2CA3 = 0x0020             /*! Enable  P2CA3 bit */
     };

      /*! P2CA2 Bit */
     enum P2CA2_t {
         P2CA2_OFF = 0x0000,        /*! Disable P2CA2 bit */
         P2CA2 = 0x0010             /*! Enable  P2CA2 bit */
     };

      /*! P2CA1 Bit */
     enum P2CA1_t {
         P2CA1_OFF = 0x0000,        /*! Disable P2CA1 bit */
         P2CA1 = 0x0008             /*! Enable  P2CA1 bit */
     };


     /*! P2CA0 Bit */
     enum P2CA0_t {
         P2CA0_OFF = 0x0000,        /*! Disable P2CA0 bit */
         P2CA0 = 0x0004             /*! Enable  P2CA0 bit */
     };

     /*! CAF Bit */
     enum CAF_t {
         CAF_OFF = 0x0000,          /*! Disable CAF bit */
         CAF = 0x0002               /*! Enable  CAF bit */
     };

     /*! CAPD7 Bit */
     enum CAPD7_t {
         CAPD7_OFF = 0x0000,        /*! Disable CAPD7 bit */
         CAPD7 = 0x0001             /*! Enable  CAPD7 bit */
     };

     /*! CAPD6 Bit */
     enum CAPD6_t {
         CAPD6_OFF = 0x0000,        /*! Disable CAPD6 bit */
         CAPD6 = 0x0002             /*! Enable  CAPD6 bit */
     };

     /*! CAPD5 Bit */
     enum CAPD5_t {
         CAPD5_OFF = 0x0000,        /*! Disable CAPD5 bit */
         CAPD5 = 0x0004             /*! Enable  CAPD5 bit */
     };

     /*! CAPD4 Bit */
     enum CAPD4_t {
         CAPD4_OFF = 0x0000,        /*! Disable CAPD4 bit */
         CAPD4 = 0x0008             /*! Enable  CAPD4 bit */
     };

     /*! CAPD3 Bit */
     enum CAPD3_t {
         CAPD3_OFF = 0x0000,        /*! Disable CAPD3 bit */
         CAPD3 = 0x0010             /*! Enable  CAPD3 bit */
     };

     /*! CAPD2 Bit */
     enum CAPD2_t {
         CAPD2_OFF = 0x0000,        /*! Disable CAPD2 bit */
         CAPD2 = 0x0020             /*! Enable  CAPD2 bit */
     };

     /*! CAPD1 Bit */
     enum CAPD1_t {
         CAPD1_OFF = 0x0000,        /*! Disable CAPD1 bit */
         CAPD1 = 0x0040             /*! Enable  CAPD1 bit */
     };

     /*! CAPD0 Bit */
     enum CAPD0_t {
         CAPD0_OFF = 0x0000,        /*! Disable CAPD0 bit */
         CAPD0 = 0x0080             /*! Enable  CAPD0 bit */
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

    /*!
    *  ======== regIntVect_t ========
    *  Interrupt vector description
    *
    *  Type to describe a single interrupt vector pin and all its possible
    *  configurations.
    *
    *  @see #regIntVect_t
    */
    struct regIntVect_t {
        String                    registerName;
        String                    registerDescription;
        String                    isrToggleString;
        String                    priorityName;
        Bool                      interruptEnable;
        Bool                      interruptHandler;
        Int                       priority;
    }
instance:

}
/*
 *  @(#) ti.catalog.msp430.peripherals.comparator; 1, 0, 0,2; 1-29-2016 10:00:49; /db/ztree/library/trees/platform/platform-q17/src/
 */

