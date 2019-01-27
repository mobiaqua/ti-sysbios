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
 *  ======== Core.c ========
 */

#include <stdlib.h>     /* for abort() */

#include <xdc/std.h>

#include <xdc/runtime/Error.h>
#include <xdc/runtime/Startup.h>

#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/knl/Swi.h>
#include <ti/sysbios/knl/Task.h>
#define ti_sysbios_family_arm_gicv3_Hwi__internalaccess
#include <ti/sysbios/family/arm/gicv3/Hwi.h>
#include <ti/sysbios/family/arm/v8a//Cache.h>
#include <ti/sysbios/family/arm/v8a/smp/GateSmp.h>

#include "package/internal/Core.xdc.h"

#define REG16(A)    (*(volatile UInt16 *) (A))
#define REG32(A)    (*(volatile UInt32 *) (A))

extern void _exit(int code);
extern Void ti_sysbios_hal_Hwi_initStack(Void);

/*
 * Core_waitForCore0
 *
 * used to throttle non Core 0 startup code
 * until Core 0 has performed C Init
 */
volatile UInt64 ti_sysbios_family_arm_v8a_smp_Core_waitForCore0;

/*
 *  ======== Core_Module_startup ========
 */
Int Core_Module_startup(Int status)
{
    Core_module->startupCalled = TRUE;

    /* grab Hwi/Swi/Task schedulers */
    /* Task and Swi scheduler is locked by default */
    Core_lock();

    return (Startup_DONE);
}

/*
 *  ======== Core_lock ========
 */
IArg Core_lock()
{
    /*
     * Core_lock() calls before Core 0 has initialized the Core module
     * will simply disable local interrupts. The other Cores will be
     * parked waiting for Core 0 to finish system initialization.
     *
     * Memory accesses by LDXR and STXR in GateSmp_enter() would result
     * in an abort if performed before Cache and MMU are initialized.
     *
     * Mmu_startup() is called by Cache_startup() (a resetFxn) before
     * Core_Module_startup().
     */
    if (Core_module->startupCalled) {
         return (GateSmp_enter(Core_gate));
    }
    else {
        return (Core_hwiDisable());
    }
}

/*
 *  ======== Core_unlock ========
 */
Void Core_unlock()
{
    if (Task_enabled() && Swi_enabled()) {
        GateSmp_leave(Core_gate, 0);
    }
}

/*
 *  ======== Core_hwiFunc ========
 */
Void Core_hwiFunc(UArg arg)
{
    UInt coreId = Core_getId();

    /* count these events for diagnostic purposes */
    Core_module->interrupts[arg][coreId] += 1;

    if (arg == Core_numCores) {
        /* Scheduler interrupt */
        Core_module->schedulerInts[coreId] += 1;
    }
    else {
        if (Core_module->ipcMsg[arg].func) {
            Core_module->ipcMsg[arg].func(Core_module->ipcMsg[arg].arg);
        }

        /* Signal operation complete */
        Core_module->syncCores[arg][coreId] = TRUE;
    }
}

/*
 *  ======== Core_exit ========
 */
Void Core_exit(UArg arg)
{
    UInt coreId = Core_getId();

    /* disable all local interrupts */
    Hwi_gicMap[coreId].gics->ICENABLER0 = 0xffffffff;
    Hwi_gicMap[coreId].gics->ICPENDR0 = 0xffffffff;
    Hwi_gicMap[coreId].gics->ICACTIVER0 = 0xffffffff;

    Task_unlockSched();
    Swi_unlockSched();
    Core_unlock();

    /* Signal operation complete */
    Core_module->syncCores[arg][Core_getId()] = TRUE;

    /*
     * Call _exit() instead of abort. abort() internally
     * calls raise() which will invoke ReentSupport_getReent()
     * from a Hwi context and cause an assertion failure.
     */
    _exit(0);
}

/*
 *  ======== Core_atexit ========
 */
Void Core_atexit(Int arg)
{
    UInt key;
    UInt coreId = Core_getId();
    UInt i;

    /* disable all local interrupts */
    Hwi_gicMap[coreId].gics->ICENABLER0 = 0xffffffff;
    Hwi_gicMap[coreId].gics->ICPENDR0 = 0xffffffff;
    Hwi_gicMap[coreId].gics->ICACTIVER0 = 0xffffffff;

    /* disable all global interrupts */
    for (i = 1; i < Hwi_NUM_GICD_ENABLE_REGS; i++) {
        Hwi_gicd.ICENABLER[i] = 0xffffffff;
        Hwi_gicd.ICPENDR[i] = 0xffffffff;
        Hwi_gicd.ICACTIVER[i] = 0xffffffff;
    }

    Task_unlockSched();
    Swi_unlockSched();
    Core_unlock();

    /* force other cores to exit */
    key = Core_notifySpinLock();
    Core_notify(&Core_exit, (UArg)coreId, (Core_CPUMASK ^ (0x1 << coreId)));
    Core_notifySpinUnlock(key);
}

/*
 *  ======== Core_InterruptCore ========
 */
Void Core_interruptCore(UInt dstCoreId)
{
    Hwi_SgiIntAffinity affinity;

    affinity.routingMode = Hwi_RoutingMode_NODE;
    affinity.targetList = 1 << (dstCoreId & 1);
    if (dstCoreId > 1) {
        affinity.aff1 = 1;  /* cluster 1 for cores 2, 3 */
    }
    else {
        affinity.aff1 = 0;  /* cluster 0 for cores 0, 1 */
    }
    Hwi_raiseSGI(affinity, Core_numCores);
}

/*
 *  ======== Core_notify ========
 */
Void Core_notify(Core_IpcFuncPtr func, UArg arg, UInt mask)
{
    UInt idx, coreId;
    Hwi_SgiIntAffinity affinity;

    /* Store function ptr, argument and sync flag in msg buffer */
    coreId = Core_getId();
    Core_module->ipcMsg[coreId].func = func;
    Core_module->ipcMsg[coreId].arg = arg;

    /* Init syncCores flag */
    for (idx = 0; idx < Core_numCores; idx++) {
        Core_module->syncCores[coreId][idx] = FALSE;
    }

    /* Interrupt other cores */
    affinity.routingMode = Hwi_RoutingMode_ALL;
    affinity.targetList = mask;
    affinity.aff1 = (coreId & 0x2) > 1; /* cluster id */

    Hwi_raiseSGI(affinity, coreId);

    /* Wait for all other cores */
    for (idx = 0; idx < Core_numCores; idx++) {
        if ((idx != coreId) && (mask & (0x1 << idx))) {
            while (!(Core_module->syncCores[coreId][idx]));
            Core_module->syncCores[coreId][idx] = FALSE;
        }
    }
}

/*
 *  ======== notifySpinLock ========
 */
UInt Core_notifySpinLock()
{
    UInt key;

    key = Hwi_disable();

    while (1) {
        if (!Core_module->notifyLock) {
            Core_module->notifyLock = TRUE;
            break;
        }
        else {
            /* Re-enable interrupts and release inter-core lock */
            Hwi_restore(key);
            /* Wait for lock to be released */
            while (Core_module->notifyLock);
            key = Hwi_disable();
        }
    }

    /* Release inter-core lock */
    Core_unlock();

    return (key);
}

/*
 *  ======== notifySpinUnlock ========
 */
Void Core_notifySpinUnlock(UInt key)
{
    /* Acquire inter-core lock */
    Core_lock();

    /* Release notify lock */
    Core_module->notifyLock = FALSE;

    Hwi_restore(key);
}

/*
 *  ======== Core_startup ========
 *  Other core's initial thread.
 *  Executes on stack provided by Core module.
 */
Void Core_startup()
{
    /* wait for Core 0 to perform C runtime initialize */
    while (ti_sysbios_family_arm_v8a_smp_Core_waitForCore0 != 0x1234567) {
        ;
    }

    /* Install vector table */
    Hwi_init();

    /* Init Cache and MMU */
    Cache_startup();

    /*
     * Initialize GIC CPU Interface and FIQ stack
     *
     * Note: GIC Distributor will be initialized by core 0
     */
    Hwi_initIntControllerCoreX();

    /*
     * initialize this core's isr stack (sp_el1) and
     * then switch to sp_el0 (the task stack).
     */
    Hwi_switchFromBootStack();

    /* Initialize this core's Hwi stack to enable stack checking */
    if (Core_initStackFlag) {
        ti_sysbios_hal_Hwi_initStack();
    }

    /* Signal to core 0 that this core's startup routine is complete */
    Core_module->syncCores[0][Core_getId()] = TRUE;

    /* Wait for store to complete */
    __asm__ __volatile__ (
        "dmb ish"
        ::: "memory"
    );

    /* Wait for core 0's signal to start running tasks */
    while(!Core_module->syncCores[0][0]);

    Task_startCore(Core_getId());
}

Void Core_startCoreX(Void)
{
    UInt idx;

    /* Init syncCores flag */
    Core_module->syncCores[0][0] = FALSE;

    /* push syncCores array to L3 so other cores can see it */
    Cache_wb((Ptr)&Core_module->syncCores, 128, 0, 0);

    ti_sysbios_family_arm_v8a_smp_Core_waitForCore0 = 0x01234567;

    /* push waitForCore0 L3 so other cores can see it */
    Cache_wb((Ptr)&ti_sysbios_family_arm_v8a_smp_Core_waitForCore0, 8, 0, 0);

    /* Wait for all other cores to run their startup sequence */
    for (idx = 1; idx < Core_numCores; idx++) {
        while (!(Core_module->syncCores[0][idx]));
        Core_module->syncCores[0][idx] = FALSE;
    }

    /* Let all other cores run */
    Core_module->syncCores[0][0] = TRUE;
}
