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
 *  ======== GPIO_MSP430FR5738_34_30_28_24_20.xs ========
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
                        "TA0.CCI1A",
                        "TA0.1",
                        "DMAE0",
                        "RTCCLK",
                        "A0/CD0/VeREF-"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P1SEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
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
                        "TA0.CCI2A",
                        "TA0.2",
                        "TA1CLK",
                        "CDOUT",
                        "A1/CD1/VeREF+"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P1SEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
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
                        "TA1.CCI1A",
                        "TA1.1",
                        "TA0CLK",
                        "CDOUT",
                        "A2/CD2"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL0", bitSetMask : 0x04, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL0", bitSetMask : 0x04, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P1SEL1", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x04, bitClearMask : 0x00 }
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
                        "TA1.CCI2A",
                        "TA1.2",
                        "UCB0STE",
                        "A3/CD3"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P1SEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
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
                        "TB0.CCI1A",
                        "TB0.1",
                        "UCA0STE",
                        "A4/CD4"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P1SEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
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
                        "TB0.CCI2A",
                        "TB0.2",
                        "UCA0CLK",
                        "A5/CD5"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P1SEL0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x20, bitClearMask : 0x00 }
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
                        "UCB0SIMO/UCB0SDA",
                        "TA0.CCI0A",
                        "TA0.0"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P1SEL1", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x40, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x40, bitClearMask : 0x00 }
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
                        "UCB0SOMI/UCB0SCL",
                        "TA1.CCI0A",
                        "TA1.0"
                    ],
                    functionConfig : [
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1SEL1", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P1SEL1", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x80, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P1DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL1", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P1SEL0", bitSetMask : 0x80, bitClearMask : 0x00 }
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
                        "UCA0TXD/UCA0SIMO",
                        "TB0CLK",
                        "ACLK"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2SEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "P2SEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
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
                        "UCA0RXD/UCA0SOMI",
                        "TB0.CCI0A",
                        "TB0.0"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2SEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "P2SEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
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
                        "UCB0CLK"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "P2SEL1", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
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
                        "TA0.CCI0B",
                        "TA0.0",
                        "A6/CD10"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "P2SEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2SEL1", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
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
                        "TA1.CCI0B",
                        "TA1.0",
                        "A7/CD11"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "P2SEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2SEL1", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "P2SEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
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
                        "TB0.CCI0B",
                        "TB0.0"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "P2SEL0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.6",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x40, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x40 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x40 }
                        ]
                    ]
                }
            },
            {
                pinName : "P2.7",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output"
                    ],
                    functionConfig : [
                        [
                            { register : "P2DIR", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ],
                        [
                            { register : "P2DIR", bitSetMask : 0x80, bitClearMask : 0x00 },
                            { register : "P2SEL1", bitSetMask : 0x00, bitClearMask : 0x80 },
                            { register : "P2SEL0", bitSetMask : 0x00, bitClearMask : 0x80 }
                        ]
                    ]
                }
            }
        ],
        [
            {
                pinName : "PJ.0",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "TB0OUTH",
                        "SMCLK",
                        "CD6"
                    ],
                    functionConfig : [
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x01 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "PJSEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x01 },
                            { register : "PJSEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "PJSEL1", bitSetMask : 0x01, bitClearMask : 0x00 },
                            { register : "PJSEL0", bitSetMask : 0x01, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "PJ.1",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "MCLK",
                        "CD7"
                    ],
                    functionConfig : [
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x02 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x02 },
                            { register : "PJSEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "PJSEL1", bitSetMask : 0x02, bitClearMask : 0x00 },
                            { register : "PJSEL0", bitSetMask : 0x02, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "PJ.2",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "ACLK",
                        "CD8"
                    ],
                    functionConfig : [
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x04 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x04 },
                            { register : "PJSEL0", bitSetMask : 0x04, bitClearMask : 0x00 }
                        ],
                        [
                            { register : "PJSEL1", bitSetMask : 0x04, bitClearMask : 0x00 },
                            { register : "PJSEL0", bitSetMask : 0x04, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "PJ.3",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "CD9"
                    ],
                    functionConfig : [
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x08 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x08 }
                        ],
                        [
                            { register : "PJSEL1", bitSetMask : 0x08, bitClearMask : 0x00 },
                            { register : "PJSEL0", bitSetMask : 0x08, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "PJ.4",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "XIN"
                    ],
                    functionConfig : [
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x10, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x10 }
                        ],
                        [
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x10 },
                            { register : "PJSEL0", bitSetMask : 0x10, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "PJ.5",
                pinFunction : {
                    functionName : [
                        "GPIO Input",
                        "GPIO Output",
                        "XOUT"
                    ],
                    functionConfig : [
                        [
                            { register : "PJDIR", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "PJDIR", bitSetMask : 0x20, bitClearMask : 0x00 },
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "PJSEL0", bitSetMask : 0x00, bitClearMask : 0x20 }
                        ],
                        [
                            { register : "PJSEL1", bitSetMask : 0x00, bitClearMask : 0x20 },
                            { register : "PJSEL0", bitSetMask : 0x20, bitClearMask : 0x00 }
                        ]
                    ]
                }
            },
            {
                pinName : "PJ.6",
                pinFunction : {
                    functionName : [
                        ""
                    ],
                    functionConfig : [
                        [

                        ]
                    ]
                }
            },
            {
                pinName : "PJ.7",
                pinFunction : {
                    functionName : [
                        ""
                    ],
                    functionConfig : [
                        [

                        ]
                    ]
                }
            }
        ]
    ];
}
/*
 *  @(#) ti.catalog.msp430.peripherals.gpio; 1, 0, 0,; 12-4-2015 21:40:17; /db/ztree/library/trees/platform/platform-q16/src/
 */

