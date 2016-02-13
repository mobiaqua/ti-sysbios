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
 *  ======== IPinMux ========
 */
metaonly interface IPinMux inherits xdc.platform.IPeripheral {

    struct ForceSetDefaultRegister_t {
        String     register;
        Bool       regForceSet;
    }

instance:
    /*! Port 1 Output Register */
    config Bits8 p1out = 0;

    /*! Port 1 Port Select Register 0 */
    config Bits8 p1sel0 = 0;

    /*! Port 1 Port Select Register 1 */
    config Bits8 p1sel1 = 0;

    /*! Port 1 Direction Register */
    config Bits8 p1dir = 0;

    /*! Port 1 Resistor Enable Register */
    config Bits8 p1ren = 0;

    /*! Port 2 Output Register */
    config Bits8 p2out = 0;

    /*! Port 2 Port Select Register 0 */
    config Bits8 p2sel0 = 0;

    /*! Port 2 Port Select Register 1 */
    config Bits8 p2sel1 = 0;

    /*! Port 2 Direction Register */
    config Bits8 p2dir = 0;

    /*! Port 2 Resistor Enable Register */
    config Bits8 p2ren = 0;

    /*! Port 3 Output Register */
    config Bits8 p3out = 0;

    /*! Port 3 Port Select Register 0 */
    config Bits8 p3sel0 = 0;

    /*! Port 3 Port Select Register 1 */
    config Bits8 p3sel1 = 0;

    /*! Port 3 Direction Register */
    config Bits8 p3dir = 0;

    /*! Port 3 Resistor Enable Register */
    config Bits8 p3ren = 0;

    /*! Port 4 Output Register */
    config Bits8 p4out = 0;

    /*! Port 4 Port Select Register 0 */
    config Bits8 p4sel0 = 0;

    /*! Port 4 Port Select Register 1 */
    config Bits8 p4sel1 = 0;

    /*! Port 4 Direction Register */
    config Bits8 p4dir = 0;

    /*! Port 4 Resistor Enable Register */
    config Bits8 p4ren = 0;

    /*! Port J Output Register */
    config Bits8 pjout = 0;

    /*! Port J Port Select Register 0 */
    config Bits8 pjsel0 = 0;

    /*! Port J Port Select Register 1 */
    config Bits8 pjsel1 = 0;

    /*! Port J Direction Register */
    config Bits8 pjdir = 0;

    /*! Port J Resistor Enable Register */
    config Bits8 pjren = 0;

    /*! Port 1 Interrupt Enable */
    config Bits8 p1ie = 0;

    /*! Port 1 Interrupt Edge Select */
    config Bits8 p1ies = 0;

    /*! Port 2 Interrupt Enable */
    config Bits8 p2ie = 0;

    /*! Port 2 Interrupt Edge Select */
    config Bits8 p2ies = 0;

    /*! Port 3 Interrupt Enable */
    config Bits8 p3ie = 0;

    /*! Port 3 Interrupt Edge Select */
    config Bits8 p3ies = 0;

    /*! Port 4 Interrupt Enable */
    config Bits8 p4ie = 0;

    /*! Port 4 Interrupt Edge Select */
    config Bits8 p4ies = 0;

    /*! Port 1 Interrupt Flag Register */
    config Bits8 p1ifg = 0;

    /*! Port 2 Interrupt Flag Register */
    config Bits8 p2ifg = 0;

    /*! Port 3 Interrupt Flag Register */
    config Bits8 p3ifg = 0;

    /*! Port 4 Interrupt Flag Register */
    config Bits8 p4ifg = 0;

    readonly config ForceSetDefaultRegister_t forceSetDefaultRegister[length];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.pinmux; 1, 0, 0,; 12-4-2015 21:40:17; /db/ztree/library/trees/platform/platform-q16/src/
 */

