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
 */

/*
 *  ======== Boot.c ========
 *  C28 CPU boot time initialization.
 */
#include <xdc/std.h>

#define Boot_disableWatchdog ti_sysbios_family_c28_f2838x_init_Boot_disableWatchdog
#define Boot_initSharedRAMs ti_sysbios_family_c28_f2838x_init_Boot_initSharedRAMs
#define Boot_configurePllDivs ti_sysbios_family_c28_f2838x_init_Boot_configurePllDivs
#define Boot_initFlash ti_sysbios_family_c28_f2838x_init_Boot_initFlash
#define Boot_limpAbort ti_sysbios_family_c28_f2838x_init_Boot_limpAbort
#define Boot_defaultLimpAbortFunction  ti_sysbios_family_c28_f2838x_init_Boot_defaultLimpAbortFunction

#if defined(__ti__)
#pragma CODE_SECTION(Boot_disableWatchdog, ".text:.bootCodeSection")
#pragma CODE_SECTION(Boot_initSharedRAMs, ".text:.bootCodeSection")
#pragma CODE_SECTION(Boot_configurePllDivs, ".text:.bootCodeSection")
#pragma CODE_SECTION(Boot_initFlash, ".text:ti_sysbios_family_c28_f2838x_init_Boot_flashfuncs")
#endif

#define Boot_delay ti_sysbios_family_c28_f2838x_init_Boot_delay
extern void Boot_delay(UInt32 count);
extern Fxn Boot_limpAbort();

#define EALLOW   asm(" EALLOW")
#define EDIS     asm(" EDIS")
#define NOP      asm(" NOP");

#define REG(x)   (*(volatile UInt32 *)(x))
#define REGH(x)  (*((volatile uint16_t *)(x)))
#define NOPS     8

/* Clock control registers */
#define CLKSRCCTL1_REG   0x05D208
#define SYSPLLCTL1_REG   0x05D20E
#define SYSPLLMULT_REG   0x05D214
#define SYSPLLSTS_REG    0x05D216
#define SYSCLKDIVSEL_REG 0x05D222
#define MCDCR_REG        0x05D22E
#define CMCLKCTL_REG     0x05D238

/* bit masks */
#define CLKSRCCTL1_OSCCLKSRCSEL_M    0x3
#define SYSPLLCTL1_PLLEN_M           0x1
#define SYSPLLCTL1_PLLCLKEN_M        0x2
#define SYSPLLMULT_REFDIV_M          0x1F000000
#define SYSPLLMULT_REFDIV_S          0x18
#define SYSPLLMULT_ODIV_M            0x1F0000
#define SYSPLLMULT_ODIV_S            0x10
#define SYSPLLMULT_IMULT_M           0x7F
#define SYSPLLSTS_LOCKS_M            0x1
#define SYSCLKDIVSEL_PLLSYSCLKDIV_M  0x3F
#define MCDCR_MCLKSTS_M              0x1
#define CMCLKCTL_CMCLKDIV_S          0x1
#define CMCLKCTL_CM_M                0xF

/* Flash controller defines */
#define FRDCNTL_REG             0x05F800
#define FBFALLBACK_REG          0x05F820
#define FPAC1_REG               0x05F824
#define FRD_INTF_CTRL_REG       0x05F980
/* bit masks */
#define FPAC1_PMPPWR_M               0x1
#define FBFALLBACK_BNKPWR0_M         0x3
#define FRD_INTF_CTRL_PREFETCHEN_M   0x1
#define FRD_INTF_CTRL_DATACACHEEN_M  0x2
#define FRDCNTL_RWAIT_M              0xF00
#define FRDCNTL_RWAIT_S              8

/* Global Shared RAM Master Select Register */
#define GSxMSEL_REG          0x05F444

/* Watchdog defines */
#define WD_BASE             0x00007000U
#define SYSCTL_O_WDCR       0x29U
#define SYSCTL_WD_CHKBITS   0x0028U
#define SYSCTL_WDCR_WDDIS   0x40U


/*
 *  ======== Boot_disableWatchdog ========
 */
Void Boot_disableWatchdog(Void)
{
    EALLOW;

    REGH(WD_BASE + SYSCTL_O_WDCR) |= SYSCTL_WD_CHKBITS | SYSCTL_WDCR_WDDIS;

    EDIS;
}

/*
 *  ======== Boot_initSharedRams ========
 */
Void Boot_initSharedRAMs(UInt16 sharedRamMask)
{
    EALLOW;

    REG(GSxMSEL_REG) = sharedRamMask;

    EDIS;
}

/*
 *  ======== Boot_configurePllDivs ========
 *
 */
Void Boot_configurePllDivs(UInt16 pllIMULT, UInt16 pllREFDIV, UInt16 pllODIV,
    UInt16 sysClkDiv, UInt16 oscClkSrcVal, UInt16 cmSrc, UInt16 cmDiv)
{
    UInt32 pllMULT;
    UInt32 cmClkCtl;

    /* check missing clock status bit; if yes call abort function */
    if (REG(MCDCR_REG) & MCDCR_MCLKSTS_M) {
        Boot_limpAbort();
    }

    EALLOW;

    /* bypass the PLL */
    REG(SYSPLLCTL1_REG) &= ~((UInt32)SYSPLLCTL1_PLLCLKEN_M);

    /* power down the PLL */
    REG(SYSPLLCTL1_REG) &= ~((UInt32)SYSPLLCTL1_PLLEN_M);

    /* wait for PLL power down */
    Boot_delay(5);

    /* select the reference (OSCCLK) source */
    REG(CLKSRCCTL1_REG) = (REG(CLKSRCCTL1_REG) & ~CLKSRCCTL1_OSCCLKSRCSEL_M) |
                           oscClkSrcVal;

    /* set system clock divider to /1 for fast PLL configuration */
    REG(SYSCLKDIVSEL_REG) = REG(SYSCLKDIVSEL_REG) &
                            ~SYSCLKDIVSEL_PLLSYSCLKDIV_M;

    pllMULT = (UInt32)pllREFDIV << SYSPLLMULT_REFDIV_S;

    /* form the SYSPLLMULT register value */
    pllMULT = (((UInt32)pllREFDIV << SYSPLLMULT_REFDIV_S)
                  & SYSPLLMULT_REFDIV_M) |
              (((UInt32)pllODIV << SYSPLLMULT_ODIV_S) & SYSPLLMULT_ODIV_M) |
              pllIMULT;

    /* set SYSPLLMULT in single write, automatically enables PLL */
    REG(SYSPLLMULT_REG) = (REG(SYSPLLMULT_REG) & ~SYSPLLMULT_IMULT_M) |
                          pllMULT;

    /* wait for PLL lock */
    while ((REG(SYSPLLSTS_REG) & SYSPLLSTS_LOCKS_M == 0)) {
    };

    /* set SYSCLKDIVSEL divider to sysClkDiv plus one, to limit current  */
    REG(SYSCLKDIVSEL_REG) = (REG(SYSCLKDIVSEL_REG) &
                            ~SYSCLKDIVSEL_PLLSYSCLKDIV_M) | (sysClkDiv + 1);

    /* enable PLL as system clock */
    REG(SYSPLLCTL1_REG) |= SYSPLLCTL1_PLLCLKEN_M;

    /* wait for voltage regulator to stabilize */
    Boot_delay(40);

    /* set SYSCLKDIVSEL divider to intended sysClkDiv  */
    REG(SYSCLKDIVSEL_REG) = (REG(SYSCLKDIVSEL_REG) &
                            ~SYSCLKDIVSEL_PLLSYSCLKDIV_M) | sysClkDiv;

    /* set CM clock source and divider */
    cmClkCtl = cmSrc | (cmDiv << CMCLKCTL_CMCLKDIV_S);
    REG(CMCLKCTL_REG) = (REG(CMCLKCTL_REG) & ~CMCLKCTL_CM_M) | cmClkCtl;

    EDIS;
}

/*
 *  ======== Boot_defaultLimpAbortFunction ========
 */
void Boot_defaultLimpAbortFunction(void)
{
    while(1) {
    }
}

/*
 *  ======== Boot_initFlash ========
 */
void Boot_initFlash(Bool configWaitStates, UInt waitStates,
    Bool enableProgramCache, Bool enableDataCache)
{
    Int i;
    UInt cacheEnable = 0;

    EALLOW;

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

    EDIS;

    /* flush pipeline before returning from RAM function */
    for (i = 0; i < (NOPS - 1); i++) {
        NOP;
    }
}
