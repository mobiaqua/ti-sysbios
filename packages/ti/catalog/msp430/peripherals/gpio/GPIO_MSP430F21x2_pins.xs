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
 *  ======== GPIO_MSP430F21x2_pins.xs ========
 */

/*
 *  ======== setPins ========
 */
function setPins(inst)
{
    inst.devicePins =
    [
        [
            {
                pinName : "P1.0",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0CLK, TA1CLK",
                        "ADC10CLK",
                        "CAOUT"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.1",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.CCI0A, TA1.CCI0A",
                        "TA0.0"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.2",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.CCI1A",
                        "TA0.1"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.3",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.CCI2A",
                        "TA0.2"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.4",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "SMCLK"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.5",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.0"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.6",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.1"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x40, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P1.7",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.2"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x80, bitClearMask : 0x00 }
                        ]
                    ]
                }
            }
        ],
        [
            {
                pinName : "P2.0",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "ACLK",
                        "A0",
                        "CA2"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "CAPD", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.1",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.INCLK, TA1.INCLK",
                        "SMCLK",
                        "A1",
                        "CA3"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "ADC10AE0", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "CAPD", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.2",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.0",
                        "TA0.CCI0B",
                        "A2",
                        "CA4",
                        "CAOUT"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "ADC10AE0", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "CAPD", bitSetMask : 0x04, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.3",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.1",
                        "A3/Vref/Veref",
                        "CA0"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "ADC10AE0", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "CAPD", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.4",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA0.2",
                        "A4/Vref/Veref",
                        "CA1"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "ADC10AE0", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.5",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "Rosc",
                        "CA5"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "BCSCTL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "BCSCTL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "BCSCTL2", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "CAPD", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "BCSCTL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.6",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "XIN",
                        "CA6"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "CAPD", bitSetMask : 0x40, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.7",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "XOUT",
                        "CA7"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "CAPD", bitSetMask : 0x80, bitClearMask : 0x00 }
                        ]
                    ]
                }
            }
        ],
        [
            {
                pinName : "P3.0",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "UCB0STE/UCA0CLK",
                        "A5"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P3SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P3SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P3SEL", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P3SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P3SEL2", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "ADC10AE0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.1",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "UCB0SIMO/UCB0SDA"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P3SEL", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.2",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "UCB0SOMI/UCB0SCL"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P3SEL", bitSetMask : 0x04, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.3",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "UCB0CLK/UCA0STE"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P3SEL", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.4",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "UCA0TXD/UCA0SIMO"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P3SEL", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.5",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "UCA0RXD/UCA0SOMI"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P3SEL", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.6",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA1.0",
                        "TA1.CCI0B",
                        "A6"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P3SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "ADC10AE0", bitSetMask : 0x40, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P3.7",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TA1.1",
                        "TA1.CCI1A",
                        "A7"
                    ],
                    functionConfig : [
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P3SEL", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P3DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P3SEL", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "ADC10AE0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "ADC10AE0", bitSetMask : 0x80, bitClearMask : 0x00 }
                        ]
                    ]
                }
            }
        ]
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.gpio; 1, 0, 0,2; 1-29-2016 10:00:52; /db/ztree/library/trees/platform/platform-q17/src/
 */

