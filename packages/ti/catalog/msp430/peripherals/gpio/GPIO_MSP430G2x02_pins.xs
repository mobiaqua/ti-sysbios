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
 *  ======== GPIO_MSP430G2x02_pins.xs ========
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
                        "TA0CLK",
                        "ACLK",
                        "Capacitive sensing"
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
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
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
                        "TA0.CCI0A",
                        "TA0.0",
                        "Capacitive sensing"
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
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL2", bitSetMask : 0x02, bitClearMask : 0x00 }
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
                        "TA0.1",
                        "Capacitive sensing"
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
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL2", bitSetMask : 0x04, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
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
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL2", bitSetMask : 0x08, bitClearMask : 0x00 }
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
                        "SMCLK",
                        "TA0.2",
                        "TA0.CCI2A",
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL2", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "CAPD", bitSetMask : 0x00, bitClearMask : 0x10 }
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
                        "TA0.0",
                        "SCLK",
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "USICTL0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL2", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x20 }
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
                        "TA0.1",
                        "SDO/SCL",
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "USICTL0", bitSetMask : 0x40, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL2", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x40 }
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
                        "SDI/SDA",
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL2", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "USICTL0", bitSetMask : 0x80, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL2", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "USICTL0", bitSetMask : 0x00, bitClearMask : 0x80 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL2", bitSetMask : 0x01, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL2", bitSetMask : 0x02, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL2", bitSetMask : 0x04, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL2", bitSetMask : 0x08, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL2", bitSetMask : 0x10, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL2", bitSetMask : 0x20, bitClearMask : 0x00 }
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
                        "TA0.1",
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL2", bitSetMask : 0x40, bitClearMask : 0x00 }
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
                        "Capacitive sensing"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P2SEL2", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2SEL", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL2", bitSetMask : 0x80, bitClearMask : 0x00 }
                        ]
                    ]
                }
            }
        ]
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.gpio; 1, 0, 0,2; 1-29-2016 10:00:54; /db/ztree/library/trees/platform/platform-q17/src/
 */

