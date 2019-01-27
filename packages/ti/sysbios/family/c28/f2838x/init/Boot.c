/*
 * Copyright (c) 2018, Texas Instruments Incorporated
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
 *
 *  C28 CPU boot time initialization.
 *
 */
#include <xdc/std.h>

#define Boot_disableWatchdog ti_sysbios_family_c28_f2838x_init_Boot_disableWatchdog

#if defined(__ti__)
#pragma CODE_SECTION(Boot_disableWatchdog, ".text:.bootCodeSection")
#endif

#define HWREGH(x)        (*((volatile uint16_t *)(x)))

#define EALLOW           asm(" EALLOW")
#define EDIS             asm(" EDIS")

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

    HWREGH(WD_BASE + SYSCTL_O_WDCR) |= SYSCTL_WD_CHKBITS | SYSCTL_WDCR_WDDIS;

    EDIS;
}
