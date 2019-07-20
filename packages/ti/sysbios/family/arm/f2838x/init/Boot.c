/*
 * Copyright (c) 2018-2019, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * */
/*
 *  ======== Boot.c ========
 */

#include <xdc/std.h>
#include "package/internal/Boot.xdc.h"

#define Boot_disableWatchdog \
    ti_sysbios_family_arm_f2838x_init_Boot_disableWatchdog
#define Boot_initFlash ti_sysbios_family_arm_f2838x_init_Boot_initFlash

#if defined(__ti__)
#pragma CODE_SECTION(Boot_disableWatchdog, ".text:.bootCodeSection")
#pragma CODE_SECTION(Boot_initFlash, ".text:ti_sysbios_family_arm_f2838x_init_Boot_flashfuncs")
#endif

#define REG(x)   (*(volatile UInt32 *)(x))
#define REGH(x)  (*((volatile uint16_t *)(x)))
#define NOP      asm(" ");
#define NOPS     8

/* Flash controller defines */
#define FRDCNTL_REG             0x400FA000
#define FBFALLBACK_REG          0x400FA040
#define FPAC1_REG               0x400FA048
#define FRD_INTF_CTRL_REG       0x400FA300
/* bit masks */
#define FPAC1_PMPPWR_M               0x1
#define FBFALLBACK_BNKPWR0_M         0x3
#define FRD_INTF_CTRL_PREFETCHEN_M   0x1
#define FRD_INTF_CTRL_DATACACHEEN_M  0x2
#define FRDCNTL_RWAIT_M              0xF00
#define FRDCNTL_RWAIT_S              8

/* Watchdog defines */
#define WD_BASE              0x40080000U
#define WWD_O_WDCR           0xCU
#define WWD_WDCR_WDDIS       0x40U
#define SYSCTL_WD_CHKBITS    0x0028U

/*
 *  ======== Boot_disableWatchdog ========
 */
Void ti_sysbios_family_arm_f2838x_init_Boot_disableWatchdog()
{
    REGH(WD_BASE + WWD_O_WDCR) |= SYSCTL_WD_CHKBITS | WWD_WDCR_WDDIS;
}

/*
 *  ======== Boot_initFlash ========
 */
void Boot_initFlash(Bool configWaitStates, UInt waitStates,
    Bool enableProgramCache, Bool enableDataCache)
{
    UInt cacheEnable = 0;
    Int i;

    /* power up flash bank and pump */
    REG(FPAC1_REG) |= FPAC1_PMPPWR_M;

    /* set fallback mode to active */
    REG(FBFALLBACK_REG) |= FBFALLBACK_BNKPWR0_M;

    /* disable prefetch and data cache */
    REG(FRD_INTF_CTRL_REG) = 0;

    /* set wait states */
    if (configWaitStates) {
        REG(FRDCNTL_REG) = (waitStates << FRDCNTL_RWAIT_S) & FRDCNTL_RWAIT_M;
    }

    /* enable prefetch? */
    if (enableProgramCache) {
        cacheEnable |= FRD_INTF_CTRL_PREFETCHEN_M;
    }

    /* enable data cache? */
    if (enableDataCache) {
        cacheEnable |= FRD_INTF_CTRL_DATACACHEEN_M;
    }

    /* write to read interface control register */
    REG(FRD_INTF_CTRL_REG) = cacheEnable;

    /* flush pipeline before returning from RAM function */
    for (i = 0; i < (NOPS - 1); i++) {
        NOP;
    }
}
