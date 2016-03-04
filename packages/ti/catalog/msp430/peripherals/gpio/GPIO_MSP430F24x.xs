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

/*
 *  ======== GPIO_MSP430F24x.xs ========
 */

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init(adc12, comparator, svs, clock)
{
    /* Call super's initializer */
    this.$module.$super.instance$meta$init.$apply(this, []);

    /* Initialize this config */
    this.adc12 = adc12;
    this.comparator = comparator;
    this.svs = svs;
    this.clock = clock;
    var caps = xdc.loadCapsule
        ("ti/catalog/msp430/peripherals/gpio/GPIO_MSP430F24x_pins.xs");
    caps.setPins(this);
}
/*
 *  @(#) ti.catalog.msp430.peripherals.gpio; 1, 0, 0,2; 1-29-2016 10:00:52; /db/ztree/library/trees/platform/platform-q17/src/
 */

