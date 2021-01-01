/*
 * Copyright (c) 2020, Texas Instruments Incorporated
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

#include <xdc/std.h>

#include <ti/sysbios/family/c7x/Mmu.h>
#include <ti/sysbios/hal/MemProtect.h>

#define MemProtect_USER_FLAGS_MASK  0x0000000F
#define MemProtect_PRIV_FLAGS_MASK  0x000000F0
#define MemProtect_MEM_FLAGS_MASK   0x0FFFFF00

#define MemProtect_parseFlags       ti_sysbios_hal_MemProtect_parseFlags
#define MemProtect_programMpuEntry  ti_sysbios_hal_MemProtect_programMpuEntry

extern Ptr _privileged_data_begin;
extern Ptr _privileged_data_end;
extern Ptr _privileged_bss_begin;
extern Ptr _privileged_bss_end;
extern Ptr _privileged_code_begin;
extern Ptr _privileged_code_end;
extern Ptr _kernel_wrapper_funcs_begin;
extern Ptr _kernel_wrapper_funcs_end;
extern Ptr _public_code_begin;
extern Ptr _public_code_end;
extern Ptr _public_data_begin;
extern Ptr _public_data_end;
extern Ptr _public_bss_begin;
extern Ptr _public_bss_end;

extern UInt64* ti_sysbios_family_c7x_Mmu_level1Table_NS;

UInt32 MemProtect_parseFlags(UInt32 flags, Mmu_MapAttrs *attrs);
Void MemProtect_programMpuEntry(UInt64 begin, UInt64 end, UInt32 flags);

static MemProtect_Struct prevSwitchAcl;

/*
 *  ======== MemProtect_constructDomain ========
 */
Int MemProtect_constructDomain(MemProtect_Struct *obj, MemProtect_Acl *acl,
    UInt16 aclLength)
{
    UInt16  i;
    UInt32  rv;

    /* Validate obj base address is in privileged address space */
    if ((obj == NULL) || (acl == NULL) ||
        (MemProtect_isDataInKernelSpace((Ptr)obj,
         sizeof(MemProtect_Struct)) != TRUE)) {
        return (-1);
    }

    if (aclLength > MemProtect_NUM_USER_ACL_ENTRIES) {
        return (-2);
    }

    for (i = 0; i < aclLength; i++) {
        /* Validate ACL entry */
        // TODO enumerate return codes

        obj->acl[i].baseAddress = acl[i].baseAddress;
        obj->acl[i].length = acl[i].length;

        rv = MemProtect_parseFlags(acl[i].flags, &obj->acl[i].attrs);
        if (rv == (~0)) {
            return (-3);
        }

        /* Validate address range falls in unprivileged address space */
        // TODO
    }
    for (; i < MemProtect_NUM_USER_ACL_ENTRIES; i++) {
        obj->acl[i].baseAddress = 0;
        obj->acl[i].length = 0;
    }

    return (0);
}

/*
 *  ======== MemProtect_destructDomain ========
 */
Int MemProtect_destructDomain(MemProtect_Struct *obj)
{
    return (0);
}

/*
 *  ======== MemProtect_parseFlags ========
 */
UInt32 MemProtect_parseFlags(UInt32 flags, Mmu_MapAttrs *attrs)
{
    UInt32 userFlags = flags & MemProtect_USER_FLAGS_MASK;
    UInt32 privFlags = flags & MemProtect_PRIV_FLAGS_MASK;
    UInt32 memFlags  = flags & MemProtect_MEM_FLAGS_MASK;

    Mmu_initMapAttrs(attrs);

    if ((userFlags & 0x3) == MemProtect_USER_READ) {
        if ((privFlags & 0x30) == MemProtect_PRIV_READ) {
            /* Priv Read-only, User Read-only */
            attrs->accessPerm = Mmu_AccessPerm_PRIV_RO_USER_RO;
        }
        else if ((privFlags & 0x30) ==
            (MemProtect_PRIV_READ | MemProtect_PRIV_WRITE)) {
            /* Priv Read Write, User Read-only */
            attrs->accessPerm = Mmu_AccessPerm_PRIV_RW_USER_RW;
        }
        else {
            return (~0);
        }
    }
    else if ((userFlags & 0x3) ==
             (MemProtect_USER_READ | MemProtect_USER_WRITE)) {
        if ((privFlags & 0x30) ==
            (MemProtect_PRIV_READ | MemProtect_PRIV_WRITE)) {
            /* Priv Read Write, User Read Write */
            attrs->accessPerm = Mmu_AccessPerm_PRIV_RW_USER_RW;
        }
        else {
            return (~0);
        }
    }
    else if ((userFlags & 0x3) == MemProtect_USER_WRITE) {
        return (~0);
    }
    else {
        if ((privFlags & 0x30) == MemProtect_PRIV_READ) {
            /* Priv Read-only, User No Access */
            attrs->accessPerm = Mmu_AccessPerm_PRIV_RO_USER_NONE;
        }
        else if ((privFlags & 0x30) ==
            (MemProtect_PRIV_READ | MemProtect_PRIV_WRITE)) {
            /* Priv Read Write, User No Access */
            attrs->accessPerm = Mmu_AccessPerm_PRIV_RW_USER_NONE;
        }
        else if ((privFlags & 0x30) == MemProtect_PRIV_WRITE) {
            return (~0);
        }
        else {
            /* Priv No Access, User No Access */
            attrs->accessPerm = Mmu_AccessPerm_PRIV_RO_USER_NONE;
        }
    }

    if ((userFlags & MemProtect_USER_EXEC) == MemProtect_USER_EXEC) {
        attrs->userExecute = TRUE;
    }
    else {
        attrs->userExecute = FALSE;
    }

    if ((privFlags & MemProtect_PRIV_EXEC) == MemProtect_PRIV_EXEC) {
        attrs->privExecute = TRUE;
    }
    else {
        attrs->privExecute = FALSE;
    }

    if (memFlags & MemProtect_SHAREABLE) {
        attrs->shareable = Mmu_Shareable_OUTER;
    }
    else {
        attrs->shareable = Mmu_Shareable_NONE;
    }

    attrs->ns = 1;
    attrs->attrIndx = Mmu_AttrIndx_MAIR7;

    return (1);
}

/*
 *  ======== MemProtect_programMpuEntry ========
 */
Void MemProtect_programMpuEntry(UInt64 begin, UInt64 end, UInt32 flags)
{
    UInt64 baseAddress, regionSize;
    Mmu_MapAttrs attrs;

    Mmu_initMapAttrs(&attrs);

    baseAddress = begin;
    regionSize = end - begin;

    MemProtect_parseFlags(flags, &attrs);

    Mmu_map(baseAddress, baseAddress, regionSize, &attrs, 0);
}

/*
 *  ======== MemProtect_startup ========
 */
Void MemProtect_startup()
{
    UInt i;
    UInt64 tableEnd;

    MemProtect_programMpuEntry((UInt64)&_kernel_wrapper_funcs_begin,
        (UInt64)&_kernel_wrapper_funcs_end, (MemProtect_PRIV_READ |
        MemProtect_USER_READ | MemProtect_PRIV_EXEC | MemProtect_USER_EXEC |
        MemProtect_WRITETHROUGH | MemProtect_SHAREABLE));

    MemProtect_programMpuEntry((UInt64)&_privileged_code_begin,
        (UInt64)&_privileged_code_end, (MemProtect_PRIV_READ |
        MemProtect_USER_READ | MemProtect_PRIV_EXEC | MemProtect_USER_EXEC |
        MemProtect_WRITETHROUGH | MemProtect_SHAREABLE));

    MemProtect_programMpuEntry((UInt64)&_public_code_begin,
        (UInt64)&_public_code_end, (MemProtect_PRIV_READ |
        MemProtect_USER_READ | MemProtect_PRIV_EXEC | MemProtect_USER_EXEC |
        MemProtect_WRITETHROUGH | MemProtect_SHAREABLE));

    MemProtect_programMpuEntry((UInt64)&_public_data_begin,
        (UInt64)&_public_data_end, (MemProtect_PRIV_READ |
        MemProtect_PRIV_WRITE | MemProtect_USER_READ |
        MemProtect_USER_WRITE | MemProtect_WRITETHROUGH |
        MemProtect_SHAREABLE));

    MemProtect_programMpuEntry((UInt64)&_public_bss_begin,
        (UInt64)&_public_bss_end, (MemProtect_PRIV_READ |
        MemProtect_PRIV_WRITE | MemProtect_USER_READ |
        MemProtect_USER_WRITE | MemProtect_WRITETHROUGH |
        MemProtect_SHAREABLE));

    tableEnd = ((UInt64)ti_sysbios_family_c7x_Mmu_level1Table_NS) +
               (Mmu_tableArrayLen * Mmu_granuleSize);
    MemProtect_programMpuEntry((UInt64)ti_sysbios_family_c7x_Mmu_level1Table_NS,
        tableEnd, (MemProtect_PRIV_READ | MemProtect_PRIV_WRITE |
                   MemProtect_USER_READ | MemProtect_USER_WRITE |
                   MemProtect_WRITETHROUGH | MemProtect_SHAREABLE));

    for (i = 0; i < MemProtect_NUM_USER_ACL_ENTRIES; i++) {
        prevSwitchAcl.acl[i].length = 0;
        prevSwitchAcl.acl[i].attrs.ns = TRUE;
        prevSwitchAcl.acl[i].attrs.accessPerm =
                                   Mmu_AccessPerm_PRIV_RW_USER_NONE;
        prevSwitchAcl.acl[i].attrs.privExecute = FALSE;
        prevSwitchAcl.acl[i].attrs.userExecute = FALSE;
        prevSwitchAcl.acl[i].attrs.shareable = Mmu_Shareable_OUTER;
        prevSwitchAcl.acl[i].attrs.attrIndx = Mmu_AttrIndx_MAIR7;
        prevSwitchAcl.acl[i].attrs.global = TRUE;
    }
}

/*
 *  ======== MemProtect_switch ========
 */
Void MemProtect_switch(MemProtect_Struct *obj)
{
    UInt i;

    if (obj == NULL) {
        return;
    }

    for (i = 0; i < MemProtect_NUM_USER_ACL_ENTRIES; i++) {
        if (prevSwitchAcl.acl[i].length != 0) {
            Mmu_map((UInt64)prevSwitchAcl.acl[i].baseAddress,
                    (UInt64)prevSwitchAcl.acl[i].baseAddress,
                    prevSwitchAcl.acl[i].length,
                    &prevSwitchAcl.acl[i].attrs, 0);
        }
    }

    for (i = 0; i < MemProtect_NUM_USER_ACL_ENTRIES; i++) {
        if (obj->acl[i].length != 0) {
            Mmu_map((UInt64)obj->acl[i].baseAddress,
                    (UInt64)obj->acl[i].baseAddress,
                    obj->acl[i].length, &obj->acl[i].attrs, 0);
        }
        prevSwitchAcl.acl[i].baseAddress = obj->acl[i].baseAddress;
        prevSwitchAcl.acl[i].length = obj->acl[i].length;
    }
}

/*
 *  ======== MemProtect_isDataInKernelSpace ========
 *
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
    else if ((begin >= (Ptr)&_privileged_data_begin) &&
             (end <= (Ptr)&_privileged_data_end)) {
        ret = TRUE;
    }

    return (ret);
}
