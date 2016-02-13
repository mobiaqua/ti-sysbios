/*
 *  Copyright (c) 2015 by Texas Instruments and others.
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
 *  ======== Boot.c ========
 *
 *  Optionally configure the FLASH controller.
 *
 */
#include <xdc/std.h>

#define Boot_initFlash ti_catalog_c2800_concertoInit_Boot_initFlash

#pragma CODE_SECTION(Boot_initFlash, ".ti_catalog_c2800_concertoInit_flashfuncs")

#define REG(x)     (*((volatile unsigned *)(x)))
#define FRDCNTL_REG          0x4000
#define FRD_INTF_CTRL_REG    0x4180
#define PREFETCH_ENABLE      0x1
#define DCACHE_ENABLE        0x2
#define RWAIT_SHIFT          8
#define NOPS                 8

/*
 *  ======== Boot_initFlash ========
 */
void Boot_initFlash(Bool configWaitStates, UInt waitStates, 
    Bool enablePrefetch, Bool enableDataCache) 
{ 
    UInt tempEnable = 0;
    UInt i;

    asm(" EALLOW");

    /* disable prefetch and data cache */
    REG(FRD_INTF_CTRL_REG) = 0;

    /* set wait states */
    if (configWaitStates) {
        REG(FRDCNTL_REG) = waitStates << RWAIT_SHIFT;
    }

    /* conditionally enable prefetch and data cache */
    if (enablePrefetch) {
        tempEnable |= PREFETCH_ENABLE;
    }
    if (enableDataCache) {
        tempEnable |= DCACHE_ENABLE;
    }
    REG(FRD_INTF_CTRL_REG) = tempEnable;

    asm(" EDIS");

    /* flush pipeline */
    for (i = 0; i < (NOPS - 1); i++) {
        asm(" NOP");
    }

}

/*
 *  @(#) ti.catalog.c2800.concertoInit; 1, 0, 0,; 12-4-2015 21:40:02; /db/ztree/library/trees/platform/platform-q16/src/
 */

