/*
 * Copyright (c) 2015, Texas Instruments Incorporated
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
 *  ======== Timer.xdc ========
 */

package ti.sysbios.family.arm.v7r.rti;

import xdc.rov.ViewInfo;

import xdc.runtime.Assert;
import xdc.runtime.Error;
import xdc.runtime.Types;
import ti.sysbios.interfaces.ITimer;
import ti.sysbios.family.arm.v7r.vim.Hwi;

/*!
 *  ======== Timer ========
 *  Cortex-R5 RTI Timer Peripheral Manager.
 *
 *  @a(Note)
 *  If creating a timer and passing custom Hwi params that set the
 *  Hwi type to FIQ, the 'interrupt' keyword must be added to the
 *  timer function declaration and the timer function must also ack
 *  the timer.
 *
 *  Here's an example showing how to create a timer and set the Hwi
 *  type of the Timer ISR to FIQ:
 *
 *  @p(code)
 *  *.cfg:
 *  xdc.useModule('ti.sysbios.family.arm.v7r.rti.Timer');
 *
 *  *.c:
 *  #include <xdc/std.h>
 *  #include <xdc/runtime/Error.h>
 *
 *  #include <ti/sysbios/family/arm/v7r/rti/Timer.h>
 *  #include <ti/sysbios/family/arm/v7r/vim/Hwi.h>
 *  ...
 *
 *  Timer_Struct timer0;
 *  Timer_Handle handle0;
 *
 *  interrupt Void myIsr()
 *  {
 *      // Timer needs to be stopped only if run mode is One shot.
 *      // For periodic run mode, this function needs to only ack
 *      // the timer interrupt.
 *      Timer_stop(handle0);
 *      Timer_ackInterrupt(handle0);
 *      ...
 *  }
 *
 *  Int main(Int argc, char* argv[])
 *  {
 *      Error_Block eb;
 *      Hwi_Params hwiParams;
 *      Timer_Params timerParams;
 *
 *      Error_init(&eb);
 *
 *      Hwi_Params_init(&hwiParams);
 *      hwiParams.type = Hwi_Type_FIQ;
 *
 *      Timer_Params_init(&timerParams);
 *      timerParams.period = 60000;
 *      timerParams.runMode = Timer_RunMode_ONESHOT;
 *      timerParams.periodType = Timer_PeriodType_MICROSECS;
 *      timerParams.hwiParams = &hwiParams;
 *      Timer_construct(&timer0, -1, (Timer_FuncPtr)&myIsr, &timerParams, &eb);
 *
 *      handle0 = Timer_handle(&timer0);
 *      ...
 *
 *      BIOS_start();
 *      return(0);
 *  }
 *  @p
 *
 *  @p(html)
 *  <h3> Calling Context </h3>
 *  <table border="1" cellpadding="3">
 *    <colgroup span="1"></colgroup> <colgroup span="5" align="center"></colgroup>
 *
 *    <tr><th> Function                 </th><th>  Hwi   </th><th>  Swi   </th><th>  Task  </th><th>  Main  </th><th>  Startup  </th></tr>
 *    <!--                                                                                                                 -->
 *    <tr><td> {@link #getNumTimers}            </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #getStatus}               </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #Params_init}             </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #construct}               </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #create}                  </td><td>   N    </td><td>   N    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #delete}                  </td><td>   N    </td><td>   N    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #destruct}                </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #getCount}                </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td><td>   N    </td></tr>
 *    <tr><td> {@link #getFreq}                 </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #getPeriod}               </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #reconfig}                </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #setPeriod}               </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #setPeriodMicroSecs}      </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td></tr>
 *    <tr><td> {@link #start}                   </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td><td>   N    </td></tr>
 *    <tr><td> {@link #stop}                    </td><td>   Y    </td><td>   Y    </td><td>   Y    </td><td>   N    </td><td>   N    </td></tr>
 *    <tr><td colspan="6"> Definitions: <br />
 *       <ul>
 *         <li> <b>Hwi</b>: API is callable from a Hwi thread. </li>
 *         <li> <b>Swi</b>: API is callable from a Swi thread. </li>
 *         <li> <b>Task</b>: API is callable from a Task thread. </li>
 *         <li> <b>Main</b>: API is callable during any of these phases: </li>
 *           <ul>
 *             <li> In your module startup after this module is started (e.g. Timer_Module_startupDone() returns TRUE). </li>
 *             <li> During xdc.runtime.Startup.lastFxns. </li>
 *             <li> During main().</li>
 *             <li> During BIOS.startupFxns.</li>
 *           </ul>
 *         <li> <b>Startup</b>: API is callable during any of these phases:</li>
 *           <ul>
 *             <li> During xdc.runtime.Startup.firstFxns.</li>
 *             <li> In your module startup before this module is started (e.g. Timer_Module_startupDone() returns FALSE).</li>
 *           </ul>
 *       </ul>
 *    </td></tr>
 *
 *  </table>
 *  @p
 *
 */
@ModuleStartup          /* to configure static timers */

module Timer inherits ti.sysbios.interfaces.ITimer
{
    /*! Max value of Timer period for PeriodType_COUNTS*/
    const UInt MAX_PERIOD = 0xffffffff;

    /*! Number of timer peripherals on chip */
    const Int NUM_TIMER_DEVICES = 2;

    /*! @_nodoc
     *  Min instructions to use in trigger().
     */
    const Int MIN_SWEEP_PERIOD = 8;

    /*! @_nodoc */
    @XmlDtd
    metaonly struct BasicView {
        Ptr         halTimerHandle;
        String      label;
        UInt        id;
        String      startMode;
        String      runMode;
        UInt        periodInCounts;
        UInt        periodInMicroSecs;
        UInt        intNum;
        String      tickFxn[];
        UArg        arg;
        String      extFreq;
        String      hwiHandle;
    };

    /*! @_nodoc */
    metaonly struct DeviceView {
        UInt        id;
        String      device;
        String      devAddr;
        UInt        intNum;
        String      runMode;
        UInt        period;
        UInt        currCount;
        UInt        remainingCount;
        String      state;
    };

    /*! @_nodoc */
    metaonly struct ModuleView {
        String      availMask;      /* available 32-bit timer halves */
    }

    /*! @_nodoc */
    @Facet
    metaonly config ViewInfo.Instance rovViewInfo =
        ViewInfo.create({
            viewMap: [
            [
                'Basic',
                {
                    type: ViewInfo.MODULE_DATA,
                    viewInitFxn: 'viewInitBasic',
                    structName: 'BasicView'
                }
            ],
            [
                'Device',
                {
                    type: ViewInfo.INSTANCE,
                    viewInitFxn: 'viewInitDevice',
                    structName: 'DeviceView'
                }
            ],
            [
                'Module',
                {
                    type: ViewInfo.MODULE,
                    viewInitFxn: 'viewInitModule',
                    structName: 'ModuleView'
                }
            ],
            ]
        });

    /*!
     *  ======== A_invalidTimer ========
     *  Assert raised when timer id specified is not supported.
     */
    config xdc.runtime.Assert.Id A_invalidTimer  = {
        msg: "A_invalidTimer: Invalid Timer Id."
    };

    /*!
     *  Error raised when timer id specified is not supported.
     */
    config Error.Id E_invalidTimer =
        {msg: "E_invalidTimer: Invalid Timer Id %d"};

    /*!
     *  Error raised when timer requested is in use
     */
    config Error.Id E_notAvailable =
        {msg: "E_notAvailable: Timer not available %d"};

    /*!
     *  Error raised when Hwi Params has mask where self is turned on.
     *
     *  This is not allowed because the timers on this platform do not
     *  support one-shot mode and a stub is used to stop it.
     *  Another timer interrupt cannot go off when the ISR is running.
     */
    config Error.Id E_invalidHwiMask  =
        {msg: "E_InvalidMask: Mask in hwiParams cannot enable self"};

    /*!
     *  Error raised when period requested is not supported
     */
    config Error.Id E_cannotSupport  =
        {msg: "E_cannotSupport: Timer cannot support requested period %d"};

    /*!
     * Timer base address
     */
    metaonly config Ptr rtiBaseAddress;

    /*!
     *  ======== anyMask ========
     *  Available mask to be used when select = Timer_ANY
     */
    config UInt anyMask = 0x3;

    /*!
     *  ======== continueOnSuspend ========
     *  Continue counting during emulation halt. Default is false.
     *
     *  When false, timer stops counting during emulation halt. When true,
     *  timer continues to count during emulation halt.
     */
    config Bool continueOnSuspend = false;

    /*!
     *  ======== intFreq ========
     *  Default internal timer input clock frequency.
     *
     *  @a(NOTE)
     *  By default, the RTI timer clock source is VCLK which is configured
     *  to run at 1/2 the CPU frequency (GCLK). If the clock divide ratios
     *  are changed, then this config param can be used to configure this
     *  module to run at a different frequency.
     *
     *  @p(code)
     *  var Timer = xdc.useModule('ti.sysbios.family.arm.v7r.rti.Timer');
     *  Timer.intFreq.lo = 50000000; // = (CPU freq / 2)
     *  Timer.intFreq.hi = 0;
     *  @p
     */
    config Types.FreqHz intFreq = {lo: 0, hi: 0};

    /*!
     *  @_nodoc
     *  RTI timer registers. Symbol "Timer_deviceRegs" is a physical device.
     */
    struct DeviceRegs {
        UInt32 RTIGCTRL;        /*! 0x00h */
        UInt32 RTITBCTRL;       /*! 0x04h */
        UInt32 RTICAPCTRL;      /*! 0x08h */
        UInt32 RTICOMPCTRL;     /*! 0x0Ch */
        UInt32 RTIFRC0;         /*! 0x10h */
        UInt32 RTIUC0;          /*! 0x14h */
        UInt32 RTICPUC0;        /*! 0x18h */
        UInt32 RESERVED0;       /*! 0x1Ch */
        UInt32 RTICAFRC0;       /*! 0x20h */
        UInt32 RTICAUC0;        /*! 0x24h */
        UInt32 RESERVED1;       /*! 0x28h */
        UInt32 RESERVED2;       /*! 0x2Ch */
        UInt32 RTIFRC1;         /*! 0x30h */
        UInt32 RTIUC1;          /*! 0x34h */
        UInt32 RTICPUC1;        /*! 0x38h */
        UInt32 RESERVED3;       /*! 0x3Ch */
        UInt32 RTICAFRC1;       /*! 0x40h */
        UInt32 RTICAUC1;        /*! 0x44h */
        UInt32 RESERVED4;       /*! 0x48h */
        UInt32 RESERVED5;       /*! 0x4Ch */
        UInt32 RTICOMP0;        /*! 0x50h */
        UInt32 RTIUDCP0;        /*! 0x54h */
        UInt32 RTICOMP1;        /*! 0x58h */
        UInt32 RTIUDCP1;        /*! 0x5Ch */
        UInt32 RTICOMP2;        /*! 0x60h */
        UInt32 RTIUDCP2;        /*! 0x64h */
        UInt32 RTICOMP3;        /*! 0x68h */
        UInt32 RTIUDCP3;        /*! 0x6Ch */
        UInt32 RTITBLCOMP;      /*! 0x70h */
        UInt32 RTITBLHCOMP;     /*! 0x74h */
        UInt32 RESERVED6;       /*! 0x78h */
        UInt32 RESERVED7;       /*! 0x7Ch */
        UInt32 RTISETINTENA;    /*! 0x80h */
        UInt32 RTICLEARINTENA;  /*! 0x84h */
        UInt32 RTIINTFLAG;      /*! 0x88h */
        UInt32 RESERVED8;       /*! 0x8Ch */
        UInt32 RTIDWDCTRL;      /*! 0x90h */
        UInt32 RTIDWDPRLD;      /*! 0x94h */
        UInt32 RTIWDSTATUS;     /*! 0x98h */
        UInt32 RTIWDKEY;        /*! 0x9Ch */
        UInt32 RTIDWDCNTR;      /*! 0xA0h */
        UInt32 RTIWWDRXNCTRL;   /*! 0xA4h */
        UInt32 RTIWWDSIZECTRL;  /*! 0xA8h */
        UInt32 RTIINTCLRENABLE; /*! 0xACh */
        UInt32 RTICOMP0CLR;     /*! 0xB0h */
        UInt32 RTICOMP1CLR;     /*! 0xB4h */
        UInt32 RTICOMP2CLR;     /*! 0xB8h */
        UInt32 RTICOMP3CLR;     /*! 0xBCh */
    };

    extern volatile DeviceRegs deviceRegs;

    /*!
     *  ======== oneShotStub ========
     *  @_nodoc
     *  RTI timer does not support one shot mode. This stub stops timer
     *  and disables its interrupt.
     *
     *  @param(arg)     Timer Handle.
     */
    Void oneShotStub(UArg arg);

    /*!
     *  ======== periodicStub ========
     *  @_nodoc
     *
     *  @param(arg)     Timer Handle.
     */
    Void periodicStub(UArg arg);

    /*!
     *  ======== getHandle ========
     *  @_nodoc
     *  Used by TimestampProvider module to get hold of timer handle used by
     *  Clock.
     *
     *  @param(id)      timer Id.
     */
    Handle getHandle(UInt id);

instance:

    /*!
     *  ======== hwiParams ========
     *  Hwi Params for Hwi Object. Default is null.
     */
    config Hwi.Params *hwiParams = null;

    /*!
     *  ======== prescale ========
     *  Prescale factor. Default is 1 (0 is not recommended).
     *
     *  The Prescale factor can be used to achieve longer timer periods.
     *  With a prescale factor specified, the actual timer period is
     *  period * (prescale + 1).
     */
    config UInt8 prescale = 1;

    /*!
     *  ======== reconfig ========
     *  Used to modify static timer instances at runtime.
     *
     *  @param(timerParams)     timer Params
     *  @param(tickFxn)         functions that runs when timer expires.
     */
    Void reconfig(FuncPtr tickFxn, const Params *timerParams, Error.Block *eb);

    /*!
     *  ======== ackInterrupt ========
     *  clear the current timer interrupt flag
     */
    Void ackInterrupt();

internal:   /* not for client use */

    /*!
     *  ======== startupNeeded ========
     *  Flag used to prevent misc code from being brought in
     *  un-necessarily
     */
    config UInt startupNeeded = false;

    /*
     * array of Timer intNums
     */
    config UInt8 intNumDef[2];

    /*
     *  ======== initDevice ========
     *  reset timer to its resting state
     */
    Void initDevice(Object *timer);

    /*
     *  ======== postInit ========
     *  finish initializing static and dynamic Timers
     */
    Int postInit(Object *timer, Error.Block *eb);

    /*
     *  ======== checkOverflow ========
     */
    Bool checkOverflow(UInt32 a, UInt32 b);

    struct Instance_State {
        Bool                    staticInst;
        Int                     id;
        ITimer.RunMode          runMode;
        ITimer.StartMode        startMode;
        UInt                    prescale;
        UInt                    period;
        ITimer.PeriodType       periodType;
        UInt                    intNum;
        UArg                    arg;
        Hwi.FuncPtr             tickFxn;
        Types.FreqHz            extFreq;
        Hwi.Handle              hwi;
    }

    struct Module_State {
        UInt            availMask;      /* available peripherals */
        Handle          handles[];      /* array of handles based on id */
    }
}
