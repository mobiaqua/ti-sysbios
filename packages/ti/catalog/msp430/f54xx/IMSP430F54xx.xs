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
 *  ======== getMemoryMap ========
 *  Returns the memory map as seen by a program running on this device
 *  when the registers are set as specified by the regs hash.
 */
function getMemoryMap(regs)
{
    /* add common memory blocks to this device's memory map */
    for (var key in this.commonMap) {
        this.memMap[key] = this.commonMap[key];
    }
    return (this.memMap);
}

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
//    var Clock = xdc.useModule("ti.catalog.msp430.peripherals.clock.UCS");
    var Timer_A3 = xdc.useModule("ti.catalog.msp430.peripherals.timer.Timer1_A3");
    var TimerA5 = xdc.useModule("ti.catalog.msp430.peripherals.timer.Timer0_A5");
    var TimerB7 = xdc.useModule("ti.catalog.msp430.peripherals.timer.Timer0_B7");
    var IE1 = xdc.useModule("ti.catalog.msp430.peripherals.special_function.IE1");
    var IC = xdc.useModule("ti.catalog.msp430.peripherals.interrupt."
        + "Interrupt_Controller");
    var WdtPlus =
        xdc.useModule("ti.catalog.msp430.peripherals.watchdog.WDTplus");

    var ie1 = IE1.create({name: "interruptEnableRegister1"});
    var clock; // = Clock.create(ie1, {name: "clock", baseAddr: 0x160});
               // TODO: 5xx devices need the UCS clock system

    this.TA0 = TimerA5.create(
        clock, {name: "TA0", baseAddr: 0x340, intNum: 54}
    );
    this.TA1 = Timer_A3.create(
        clock, {name: "TA1", baseAddr: 0x380, intNum: 49}
    );
    this.TB0 = TimerB7.create(
        clock, {name: "TB0", baseAddr: 0x3C0, intNum: 60}
    );
    this.interruptController = IC.create(
        {name: "interruptController", baseAddr: 0xFF80, numInterrupts: 64});
    this.wdtPlus = WdtPlus.create(clock,
        {name: "watchdog", baseAddr: 0x15c});
}
/*
 *  @(#) ti.catalog.msp430.f54xx; 1, 0, 0,; 12-4-2015 21:40:09; /db/ztree/library/trees/platform/platform-q16/src/
 */

