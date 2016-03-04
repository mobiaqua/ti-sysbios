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
 *  ======== CS_A ========
 *  MSP430 Clock System
 */
metaonly module CS_A inherits IClock
{

instance:
    /*!
     *  ======== hasLFXT1 ========
     *  Specify if LFXT1 is available on the device.
     *
     *  Not all devices have low frequency clock. This specifies if
     *  it is available for a particular device.
     */
    config Bool hasLFXT1 = false;

    config Float VLOCLKHz = 9400;
    config Float LFMODOSCHz = 39000;
    config Float MODOSCHz = 5000000;
    config Float WATCHCRYSTALCLKHz = 32768;
    config Float XT1CLKHz = 0;
    config Float XT2CLKHz = 0;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.clock; 1, 0, 0,2; 1-29-2016 10:00:47; /db/ztree/library/trees/platform/platform-q17/src/
 */

