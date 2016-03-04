/* 
 *  Copyright (c) 2008 Texas Instruments. All rights reserved. 
 *  This program and the accompanying materials are made available under the 
 *  terms of the Eclipse Public License v1.0 and Eclipse Distribution License
 *  v. 1.0 which accompanies this distribution. The Eclipse Public License is
 *  available at http://www.eclipse.org/legal/epl-v10.html and the Eclipse
 *  Distribution License is available at 
 *  http://www.eclipse.org/org/documents/edl-v10.php.
 *
 *  Contributors:
 *      Texas Instruments - initial implementation
 * */

/*
 *  ======== timer.h ========
 */

#ifndef ti_catalog_msp430_peripherals_timers_timer_h
#define ti_catalog_msp430_peripherals_timers_timer_h

#include <xdc/std.h>
/* timer register structure (common offsets for type A and B) */ 
typedef volatile struct ti_catalog_msp430_peripherals_timers_TimerRegs {
    UInt control;
    UInt cctl_0;
    UInt cctl_1;
    UInt cctl_2;
    UInt cctl_3;
    UInt cctl_4;
    UInt cctl_5;
    UInt cctl_6;
    UInt count;
    UInt cc_compare_0;
    UInt cc_compare_1;
    UInt cc_compare_2;
    UInt cc_compare_3;
    UInt cc_compare_4;
    UInt cc_compare_5;
    UInt cc_compare_6;
    UInt expansion;
    UInt reserved[6];
    UInt vector;
} ti_catalog_msp430_peripherals_timers_TimerRegs;

#endif
/*
 *  @(#) ti.catalog.msp430.peripherals.timer; 1, 0, 0,2; 1-29-2016 10:00:59; /db/ztree/library/trees/platform/platform-q17/src/
 */

