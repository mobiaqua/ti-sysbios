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

import ti.catalog.msp430.peripherals.timer.Timer_A3;
import ti.catalog.msp430.peripherals.timer.Timer_B3;
import ti.catalog.msp430.peripherals.clock.BCSplus;
import ti.catalog.msp430.peripherals.communication.USCI_A0_UART_2xx;
import ti.catalog.msp430.peripherals.communication.USCI_A0_SPI_2xx;
import ti.catalog.msp430.peripherals.communication.USCI_B0_SPI_2xx;
import ti.catalog.msp430.peripherals.communication.USCI_B0_I2C_2xx;
import ti.catalog.msp430.peripherals.adc.ADC10;
import ti.catalog.msp430.peripherals.watchdog.WDTplus;
import ti.catalog.msp430.peripherals.oa.OA_2;
import ti.catalog.msp430.peripherals.gpio.GPIO_MSP430F22x4;
import ti.catalog.msp430.peripherals.memory.Flash_2xx;
import ti.catalog.msp430.peripherals.special_function.IE1;
import ti.catalog.msp430.peripherals.special_function.IE2;
import ti.catalog.msp430.peripherals.interrupt.Interrupt_Controller;

/*!
 *  ======== IMSP430x22xx.xdc ========
 *  Common definition for MSP430x22xx devices
 */
metaonly interface IMSP430x22xx inherits ti.catalog.msp430.IMSP430
{

instance:

    config Timer_A3.Instance timer_A3;
    config Timer_B3.Instance timer_B3;
    config BCSplus.Instance clock;
    config USCI_A0_UART_2xx.Instance usci_A0_UART;
    config USCI_A0_SPI_2xx.Instance usci_A0_SPI;
    config USCI_B0_SPI_2xx.Instance usci_B0_SPI;
    config USCI_B0_I2C_2xx.Instance usci_B0_I2C;
    config ADC10.Instance adc10;
    config WDTplus.Instance wdtPlus;
    config OA_2.Instance oa;
    config GPIO_MSP430F22x4.Instance gpio;
    config Flash_2xx.Instance flash;
    config IE1.Instance interruptEnableRegister1;
    config IE2.Instance interruptEnableRegister2;
    config Interrupt_Controller.Instance interruptController;

    /*!
     *  ======== commonMap ========
     *  Memory map elements shared by all MSP430x22xx devices
     */
    config xdc.platform.IPlatform.Memory commonMap[string]  = [
        ["PERIPHERALS_8BIT", {
            comment:    "Memory mapped I/O registers",
            name:       "PERIPHERALS_8BIT",
            base:       0x0010,
            len:        0x00F0,
            space:      "io",
            access:     "RW"
        }],

        ["PERIPHERALS_16BIT", {
            comment:    "Memory mapped I/O registers",
            name:       "PERIPHERALS_16BIT",
            base:       0x0100,
            len:        0x0100,
            space:      "io",
            access:     "RW"
        }],

        ["BSLSKEY", {
            comment:    "Boot loader security key",
            name:       "BSLSKEY",
            base:       0xFFDE,
            len:        0x0002,
            space:      "data",
            access:     "RI"
        }],

        ["INT00", {
            comment:    "Reserved Vector (int00)",
            name:       "INT00",
            base:       0xFFE0,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT01", {
            comment:    "Reserved Vector (int01)",
            name:       "INT01",
            base:       0xFFE2,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT02", {
            comment:    "I/O Port P1 Vector (int02)",
            name:       "INT02",
            base:       0xFFE4,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT03", {
            comment:    "I/O Port P2 Vector (int03)",
            name:       "INT03",
            base:       0xFFE6,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT04", {
            comment:    "Reserved Vector (int04)",
            name:       "INT04",
            base:       0xFFE8,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT05", {
            comment:    "ADC10 Vector (int05)",
            name:       "INT05",
            base:       0xFFEA,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT06", {
            comment:    "USCI_A0/B0 Transmit Vector (int06)",
            name:       "INT06",
            base:       0xFFEC,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT07", {
            comment:    "USCI_A0/B0 Receive Vector (int07)",
            name:       "INT07",
            base:       0xFFEE,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT08", {
            comment:    "Timer_A3 TBCCR1 Vector (int08)",
            name:       "INT08",
            base:       0xFFF0,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT09", {
            comment:    "Timer_A3 TBCCR0 Vector (int09)",
            name:       "INT09",
            base:       0xFFF2,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT10", {
            comment:    "Watchdog Vector (int10)",
            name:       "INT10",
            base:       0xFFF4,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT11", {
            comment:    "Reserved Vector (int11)",
            name:       "INT11",
            base:       0xFFF6,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT12", {
            comment:    "Timer_B3 TBCCR1 Vector (int12)",
            name:       "INT12",
            base:       0xFFF8,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT13", {
            comment:    "Timer_B3 TBCCR0 Vector (int13)",
            name:       "INT13",
            base:       0xFFFA,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INT14", {
            comment:    "NMI Vector (int14)",
            name:       "INT14",
            base:       0xFFFC,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["RESET", {
            comment:    "Reset Vector (int15)",
            name:       "RESET", 
            base:       0xFFFE,
            len:        0x0002,
            space:      "data",
            access:     "RW"
        }],

        ["INFOA", {
            comment:    "INFO Flash Memory Segment A",
            name:       "INFOA",
            base:       0x10C0,
            len:        0x0040,
            space:      "data",
            access:     "RW"
        }],

        ["INFOB", {
            comment:    "INFO Flash Memory Segment B",
            name:       "INFOB",
            base:       0x1080,
            len:        0x0040,
            space:      "data",
            access:     "RW"
        }],

        ["INFOC", {
            comment:    "INFO Flash Memory Segment C",
            name:       "INFOC",
            base:       0x1040,
            len:        0x0040,
            space:      "data",
            access:     "RW"
        }],

        ["INFOD", {
            comment:    "INFO Flash Memory Segment D",
            name:       "INFOD",
            base:       0x1000,
            len:        0x0040,
            space:      "data",
            access:     "RW"
        }],
    ];
}
/*
 *  @(#) ti.catalog.msp430.f22xx; 1, 0, 0,; 12-4-2015 21:40:09; /db/ztree/library/trees/platform/platform-q16/src/
 */

