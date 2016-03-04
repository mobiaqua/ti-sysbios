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
 *  ======== Clock ========
 *  MSP430 Master Clock
 */
metaonly interface IClock inherits xdc.platform.IPeripheral {

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
    *  ======== AvailableClockVariations_t ========
    *  Available variations of clock in a device
    *
    *  Stores true/false if any of the clock variations are
    *  available.
    *
    *  @see #AvailableClockVariations_t
    */
    struct AvailableClockVariations_t {
        String     clockType;
        Bool       hasClock;
    }

instance:

    /*!
     *  ======== baseAddr ========
     *  Address of the peripheral's control register.
     *
     *  A peripheral's registers are commonly accessed through a structure
     *  that defines the offsets of a particular register from the lowest
     *  address mapped to a peripheral. That lowest address is specified by
     *  this parameter.
     */
    config UInt baseAddr;

    /*!
     *  ======== hasHFXT1 ========
     *  Specify if HFXT1 is available on the device.
     *
     *  Not all devices have high frequency clock. This specifies if
     *  it is available for a particular device.
     */
    config Bool hasHFXT1 = false;

    /*!
     *  ======== hasXT2 ========
     *  Specify if XT2 is available on the device.
     *
     *  Not all devices have XT2 clock available. This specifies if
     *  it is available for a particular device.
     */
    config Bool hasXT2 = false;

    /*!
     *  ======== hasRosc ========
     *  Specify if Rosc is available on the device.
     *
     *  Not all devices have Rosc circuitry. This specifies if
     *  it is available for a particular device.
     */
    config Bool hasRosc = false;

    /*!
     *  ======== hasVLO ========
     *  Specify if VLO is available on the device.
     *
     *  Not all devices have very low frequency clock VLO. This specifies if
     *  it is available for a particular device.
     */
    config Bool hasVLO = false;

    /*!
     *  ======== hasAllCal ========
     *  Specify if device has all calibration constants.
     *
     *  G1 devices do not.
     */
    config Bool hasAllCal = false;

    /*!
     *  ======== maxCpuFrequency ========
     *  Maximum CPU frequency in Hertz
     */
    config Float maxCpuFrequency = 0;

    /*!
     *  ======== DCOCLKHz ========
     *  DCO clock frequency in Hertz
     */
    readonly config Float DCOCLKHz = 1000000;

    /*!
     *  ======== ACLKHz ========
     *  ACLK frequency in Hertz
     */
    readonly config Float ACLKHz;

    /*!
     *  ======== MCLKHz ========
     *  MCLK frequency in Hertz
     */
    readonly config Float MCLKHz;

    /*!
     *  ======== SMCLKHz ========
     *  SMCLK frequency in Hertz
     */
    readonly config Float SMCLKHz;

    /*!
     *  ======== computeDCOCLKHz ========
     *  Initialize to the nearest available DCO clock frequency
     */
    void computeDCOCLKHz(Float DCOCLKHz);
}
/*
 *  @(#) ti.catalog.msp430.peripherals.clock; 1, 0, 0,2; 1-29-2016 10:00:47; /db/ztree/library/trees/platform/platform-q17/src/
 */

