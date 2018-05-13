/*
 *  Copyright 2018 by Texas Instruments Incorporated.
 *
 */

/*
 * Copyright (c) 2017, Texas Instruments Incorporated
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
 *  ======== startup.c ========
 *  C runtime initialization.
 */

#include <sys/types.h>
#include <xdc/runtime/Startup.h>

extern int * xdc_runtime_Startup__EXECFXN__C;

extern unsigned int __bss_start__, __bss_end__;
extern unsigned int __data_load__, __data_start__, __data_end__;
extern void (*__init_array_start []) (void);
extern void (*__init_array_end []) (void);

extern int main();
extern void _exit(int code);
extern void xdc_runtime_System_exit__E(int code);
volatile unsigned gnu_targets_arm_rtsv8M_exit = 0;
void * __dso_handle = (void *) &__dso_handle;

/*
 *  ======== startupC ========
 */
void startupC(void)
{
    int retVal;
    unsigned int * bs;
    unsigned int * be;
    unsigned int * dl;
    unsigned int * ds;
    unsigned int * de;
    size_t count;
    size_t i;

    /* initiailize .bss to zero */
    bs = & __bss_start__;
    be = & __bss_end__;
    while (bs < be) {
        *bs = 0;
        bs++;
    }

    /* relocate the .data section */
    dl = & __data_load__;
    ds = & __data_start__;
    de = & __data_end__;
    if (dl != ds) {
        while (ds < de) {
            *ds = *dl;
            dl++;
            ds++;
        }
    }

    /* run Startup_exec */
    xdc_runtime_Startup_exec__E();

    /* run any constructors */
    count = __init_array_end - __init_array_start;
    for (i = 0; i < count; i++) {
        __init_array_start[i]();
    }

    /* call main() */
    retVal = main();

    /* if get here call exit() */
    if (gnu_targets_arm_rtsv8M_exit != 0) {
        _exit(retVal);
    }
    else {
        xdc_runtime_System_exit__E(retVal);
    }

}

/*
 *  ======== _fini ========
 */
void _fini(void) {
}


/*
 *  @(#) gnu.targets.arm.rtsv8M; 1, 0, 0,0; 4-20-2018 17:25:38; /db/ztree/library/trees/xdctargets/xdctargets-q01/src/ xlibrary

 */

