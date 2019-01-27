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
 *  ======== Core.xdc ========
 */

package ti.sysbios.family.arm.v8a.smp;

import xdc.runtime.Error;
import ti.sysbios.family.arm.v8a.smp.GateSmp;

/*!
 *  ======== Core ========
 *  Core Identification Module.
 *
 *  This Core module supports 2-core SMP mode on cluster 0
 *  and 4-core SMP mode with Core 0 being core 0 on cluster 0.
 *
 *  2-core SMP mode on Cluster 1 is explicitly NOT SUPPORTED.
 */

@ModuleStartup
@CustomHeader

module Core inherits ti.sysbios.interfaces.ICore
{
    /*!
     *  @_nodoc
     *  ======== CPUMASK ========
     */
    config UInt CPUMASK;

    /*!
     *  @_nodoc
     *  ======== baseClusterId ========
     */
    config UInt baseClusterId = 0;

    /*!
     *  @_nodoc
     *  ======== IpcFuncPtr ========
     *  IPC Callback function type definition.
     */
    typedef Void (*IpcFuncPtr)(UArg);

    @Macro
    override UInt hwiDisable();

    @Macro
    override UInt hwiEnable();

    @Macro
    override Void hwiRestore(UInt key);

    /*!
     *  @_nodoc
     *  ======== getRevisionNumber ========
     *  Returns the major and minor revision number for the Cortex-A
     *  processor as a 2-nibble quantity [Major revision: Minor revision]
     *
     *  This API is used internally by different modules to check
     *  the ARM IP revision number and determine whether or not an
     *  errata applies and requires a workaround.
     */
    UInt8 getRevisionNumber();

    /*!
     *  @_nodoc
     *  ======== notifySpinLock ========
     */
    UInt notifySpinLock();

    /*!
     *  @_nodoc
     *  ======== notifySpinUnlock ========
     */
    Void notifySpinUnlock(UInt key);

    /*!
     *  @_nodoc
     *  ======== notify ========
     *  notify all cores specified by 'cpuMask' to execute callback function
     *  and wait for other cores to complete operation.
     *
     *  @param(func)    The callback function that is called by each
     *                  interrupted core. If function pointer is NULL,
     *                  the IPC handler simply returns.
     *  @param(arg)     Argument to be passed to the callback function.
     *  @param(cpuMask) Bit mask of all CPUs that should be interrupted.
     *                  If the MPCore sub-system has 4 CPUs and all need
     *                  to be interrupted, a bit mask of 0b1111 or 0xF
     *                  needs to be passed to Core_notify().
     *
     *  @a(NOTE)
     *  SGI numbers 0, 1, 2 ..., N, where N is the number of cores in MPCore
     *  sub-system, are reserved for the internal use of the kernel.
     *
     *  @a(NOTE)
     *  The call to this function should be protected with a
     *  Core_notifySpinLock()/Core_notifySpinUnlock(). This function should
     *  not be called with the inter-core lock already taken or it will spin
     *  forever as the other cores will not be able to service the notify
     *  interrupts.
     */
     Void notify(IpcFuncPtr func, UArg arg, UInt cpuMask);

internal:

    /*
     *  ======== IpcMsg ========
     *  IPC message structure
     */
    struct IpcMsg {
        IpcFuncPtr  func;
        UArg        arg;
    };

    config GateSmp.Handle gate;

    config Bool initStackFlag = true;

    /*
     *  ======== startCoreX ========
     */
    Void startCoreX();

    /*
     *  ======== exit ========
     */
    Void exit(UArg arg);

    /*
     *  ======== hwiFunc ========
     *
     *  Hwi func attached to Core.interruptCore()
     */
    Void hwiFunc(UArg arg);

    /*
     *  ======== startup ========
     *  Other core's first function
     */
    Void startup();

    /*!
     *  ======== atexit ========
     *  atexit() func used to signal the other core to halt
     */
    Void atexit(Int arg);

    struct Module_State {
        Bool             startupCalled;
        Bool             gateEntered[];
        UInt             schedulerInts[];
        UInt             interrupts[][];
        volatile Bool    syncCores[][];
        volatile IpcMsg  ipcMsg[];
        volatile Bool    notifyLock;
    };
}
