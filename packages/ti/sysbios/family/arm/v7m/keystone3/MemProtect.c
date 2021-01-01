/*
 * Copyright (c) 2017-2020, Texas Instruments Incorporated
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
 *  ======== MemProtect.c ========
 */
/* REQ_TAG(SYSBIOS-1009) */

#include <xdc/std.h>

#include <ti/sysbios/hal/Hwi.h>
/* REQ_TAG(SYSBIOS-571) - module startup implemented in header */
#include <ti/sysbios/hal/MemProtect.h>

#define MemProtect_USER_RW_MASK     0x00000003U
#define MemProtect_PRIV_RW_MASK     0x00000030U

#define MemProtect_domainCreateDone ti_sysbios_hal_MemProtect_domainCreateDone

extern Ptr _privileged_code_begin;
extern Ptr _privileged_code_end;
extern Ptr _privileged_data_begin;
extern Ptr _privileged_data_end;
extern Ptr _privileged_bss_begin;
extern Ptr _privileged_bss_end;
extern Ptr _kernel_wrapper_funcs_begin;
extern Ptr _kernel_wrapper_funcs_end;
extern Ptr _public_code_begin;
extern Ptr _public_code_end;
extern Ptr _public_data_begin;
extern Ptr _public_data_end;
extern Ptr _public_bss_begin;
extern Ptr _public_bss_end;

extern Bool DMSC_programFirewall(Ptr baseAddress, SizeT size, UInt32 flags);
extern Void MemProtect_init();

/* Track if domain was previously created */
static Bool MemProtect_domainCreateDone;

/*
 *  ======== MemProtect_constructDomain ========
 */
/*
 * REQ_TAG(SYSBIOS-1011), REQ_TAG(SYSBIOS-1012), REQ_TAG(SYSBIOS-1013),
 * REQ_TAG(SYSBIOS-1014), REQ_TAG(SYSBIOS-1015), REQ_TAG(SYSBIOS-1016),
 * REQ_TAG(SYSBIOS-1017)
 */
Int MemProtect_constructDomain(MemProtect_Struct *obj, MemProtect_Acl *acl,
    UInt16 aclLength)
{
    UInt16 i;
    UInt   key;
    UInt32 flags;

    key = Hwi_disable();

    if (MemProtect_domainCreateDone == TRUE) {
        Hwi_restore(key);
        return (-3);
    }
    else {
        MemProtect_domainCreateDone = TRUE;
    }

    Hwi_restore(key);

    /* Validate obj base address is in privileged address space */
    if ((obj == NULL) || (acl == NULL) ||
        (MemProtect_isDataInKernelSpace((Ptr)obj,
         sizeof(MemProtect_Struct)) != TRUE)) {
        return (-1);
    }

    for (i = 0; i < aclLength; i++) {

        /* Read flags from ACL entry and extract relevant bit fields */
        flags = acl[i].flags &
            (MemProtect_USER_RW_MASK | MemProtect_PRIV_RW_MASK);

        /*
         * Firewall driver will validate the ACL entry before programming it.
         * If number ACL entries exceeds number of available Firewall slots,
         * the API will return FALSE.
         */
        if (DMSC_programFirewall(acl[i].baseAddress, acl[i].length, flags) == FALSE) {
            return (-2);
        }
    }

    MemProtect_domainCreateDone = FALSE;
    return (0);
}

/*
 *  ======== MemProtect_destructDomain ========
 */
/* REQ_TAG(SYSBIOS-1018) */
Int MemProtect_destructDomain(MemProtect_Struct *obj)
{
    return (0);
}

/*
 *  ======== MemProtect_init ========
 */
/* REQ_TAG(SYSBIOS-1010) */
#if (defined(__GNUC__) && !defined(__ti__)) || (defined(__GNUC__) && defined(__clang__))
Void __attribute__ ((weak)) MemProtect_init()
#else
#pragma WEAK(MemProtect_init)
Void MemProtect_init()
#endif
{
    UInt32 flags;
    SizeT regionSize;

    regionSize = (SizeT)&_privileged_code_end - (SizeT)&_privileged_code_begin;
    flags = MemProtect_PRIV_READ;
    DMSC_programFirewall((Ptr)&_privileged_code_begin,
        regionSize, flags);

    regionSize = (SizeT)&_privileged_data_end - (SizeT)&_privileged_data_begin;
    flags = MemProtect_PRIV_READ | MemProtect_PRIV_WRITE;
    DMSC_programFirewall((Ptr)&_privileged_data_begin,
        regionSize, flags);

    regionSize = (SizeT)&_privileged_bss_end - (SizeT)&_privileged_bss_begin;
    flags = MemProtect_PRIV_READ | MemProtect_PRIV_WRITE;
    DMSC_programFirewall((Ptr)&_privileged_bss_begin,
        regionSize, flags);

    regionSize = (SizeT)&_kernel_wrapper_funcs_end -
        (SizeT)&_kernel_wrapper_funcs_begin;
    flags = MemProtect_PRIV_READ | MemProtect_USER_READ;
    DMSC_programFirewall((Ptr)&_kernel_wrapper_funcs_begin,
        regionSize, flags);

    regionSize = (SizeT)&_public_code_end - (SizeT)&_public_code_begin;
    flags = MemProtect_PRIV_READ | MemProtect_USER_READ;
    DMSC_programFirewall((Ptr)&_public_code_begin,
        regionSize, flags);

    regionSize = (SizeT)&_public_data_end - (SizeT)&_public_data_begin;
    flags = MemProtect_PRIV_READ | MemProtect_PRIV_WRITE |
        MemProtect_USER_READ | MemProtect_USER_WRITE;
    DMSC_programFirewall((Ptr)&_public_data_begin,
        regionSize, flags);

    regionSize = (SizeT)&_public_bss_end - (SizeT)&_public_bss_begin;
    flags = MemProtect_PRIV_READ | MemProtect_PRIV_WRITE |
        MemProtect_USER_READ | MemProtect_USER_WRITE;
    DMSC_programFirewall((Ptr)&_public_bss_begin,
        regionSize, flags);
}

/*
 *  ======== MemProtect_switch ========
 */
Void MemProtect_switch(MemProtect_Struct *obj)
{
    /*
     * Dynamic switching of firewall settings is not supported. Firewall
     * is programmed once during boot and a second time when a domain is
     * constructed/created.
     */
}

/*
 *  ======== MemProtect_isDataInKernelSpace ========
 *  This function validates if a data range is in kernel address space.
 *  This is used by other kernel code to ensure it does not accept kernel
 *  objects residing in user address space from the application.
 *
 *  Another added benefit of the check is that if the kernel object is in
 *  system stack or FLASH, we will catch that too.
 */
Bool MemProtect_isDataInKernelSpace(Ptr obj, SizeT size)
{
    Bool ret = FALSE;
    Ptr begin = obj;
    Ptr end = (Ptr)((SizeT)obj + size);

    if ((begin >= (Ptr)&_privileged_bss_begin) &&
        (end <= (Ptr)&_privileged_bss_end)) {
        ret = TRUE;
    }
    else {
        if ((begin >= (Ptr)&_privileged_data_begin) &&
                (end <= (Ptr)&_privileged_data_end)) {
            ret = TRUE;
        }
    }

    return (ret);
}

#if defined(__IAR_SYSTEMS_ICC__)
__weak Void DMSC_programFirewall(Ptr baseAddress, SizeT size, UInt32 flags)
#elif (defined(__GNUC__) && !defined(__ti__)) || (defined(__GNUC__) && defined(__clang__))
Bool __attribute__((weak)) DMSC_programFirewall(Ptr baseAddress, SizeT size, UInt32 flags)
#else
#pragma WEAK (DMSC_programFirewall)
Bool DMSC_programFirewall(Ptr baseAddress, SizeT size, UInt32 flags)
#endif
{
    return (TRUE);
}
