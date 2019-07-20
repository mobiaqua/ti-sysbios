/*
 * Copyright (c) 2019, Texas Instruments Incorporated
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
 *  ======== Timer.c ========
 */

#include <xdc/std.h>
#include <xdc/runtime/Error.h>
#include <xdc/runtime/Assert.h>
#include <xdc/runtime/Startup.h>
#include <xdc/runtime/Types.h>

#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/family/arm/m3/Hwi.h>
#include "package/internal/Timer.xdc.h"

/* Timer TCR register bit positions/masks */
#define TIF_M   0x00008000
#define TIE_M   0x00004000
#define FREE_M  0x00000800
#define SOFT_M  0x00000400
#define TRB_M   0x00000020
#define TSS_M   0x00000010

/* Timer TPR register bit positions/masks/shifts */
#define PSCH_M  0xFF000000
#define TDDRH_M 0x00FF0000
#define PSCL_M  0x0000FF00
#define TDDRL_M 0x000000FF
#define PSCH_S  24
#define TDDRH_S 16
#define PSCL_S  8
#define TDDRL_S 0

/* SYSCTL defines for enable/disable of timer peripherals */
#define CMSYSCTL_BASE            0x400FC000U
#define SYSCTL_O_CMPCLKCR0       0x0U
#define SYSCTL_CMSYSCTL_KEY      0x5634U
#define SYSCTL_CMPCLKCR0_KEY_M   0xFFFF0000U
#define SYSCTL_PERIPH_REG_M      0x001FU
#define SYSCTL_PERIPH_REG_S      0x0000U
#define SYSCTL_PERIPH_BIT_M      0x1F00U
#define SYSCTL_PERIPH_BIT_S      0x0008U
#define SYSCTL_PERIPH_CLK_TIMER0 0x0002U
#define SYSCTL_PERIPH_CLK_TIMER1 0x0102U
#define SYSCTL_PERIPH_CLK_TIMER2 0x0202U

/* Timer registers */
typedef struct TimerRegs {
    UInt32  TIM;  /* counter register */
    UInt32  PRD;  /* period register */
    UInt32  TCR;  /* control register */
    UInt32  TPR;  /* prescale register */
} TimerRegs;

/*
 * The three CPU timer registers are layed out consecutively in memory,
 * from 0x40084000 to 0x40084020:
 *   Timer 0: 0x40084000
 *   Timer 1: 0x40084010
 *   Timer 2: 0x40084020
 */
#define TimerDevices ((volatile TimerRegs *)(0x40084000))

#define HWREG(x) (*((volatile UInt32 *)(x)))

/*
 *  ======== Timer_getNumTimers ========
 */
UInt Timer_getNumTimers()
{
    return (Timer_NUM_TIMER_DEVICES);
}

/*
 *  ======== Timer_getStatus ========
 */
Timer_Status Timer_getStatus(UInt timerId)
{
    Assert_isTrue(timerId < Timer_NUM_TIMER_DEVICES, NULL);

    if (Timer_module->availMask & (0x1 << timerId)) {
        return (Timer_Status_FREE);
    }
    else {
        return (Timer_Status_INUSE);
    }
}

/*
 *  ======== Timer_getMaxTicks ========
 */
UInt32 Timer_getMaxTicks(Timer_Object *obj)
{
    return (0);
}

/*
 *  ======== Timer_setNextTick ========
 */
Void Timer_setNextTick(Timer_Object *obj, UInt32 ticks)
{
}

/*
 *  ======== Timer_Module_startup ========
 *  Calls postInit for all statically-created & constructed timers to stop and
 *  initialize them.
 *
 *  At reset, the period and count for each timer is 0. Also, the timer control
 *  register's interrupt flag and interrupt enable bits are cleared.
 *  The timer is "running" at reset (the stop bit, TSS, is 0), but since the
 *  period is 0, this doesn't mean anything.
 */
Int Timer_Module_startup(Int status)
{
    Int i;
    Timer_Object *obj;

    if (Timer_startupNeeded) {
        /* Run post init on all statically created or constructed Timers. */
        for (i = 0; i < Timer_NUM_TIMER_DEVICES; i++) {
            obj = Timer_module->staticTimers[i];
            if (obj != NULL) {
                Timer_postInit(obj, NULL);
            }
        }
    }
    return (Startup_DONE);
}

/*
 *  ======== Timer_startup ========
 *  Here after main(), called from BIOS_start().
 */
Void Timer_startup()
{
    Int i;
    Timer_Object *obj;

    if (Timer_startupNeeded) {
        for (i = 0; i < Timer_NUM_TIMER_DEVICES; i++) {
            obj = Timer_module->staticTimers[i];
            /* if timer was statically created/constructed */
            if ((obj != NULL) && (obj->startMode == Timer_StartMode_AUTO)) {
                Timer_start(obj);
            }
        }
    }
}

/*
 *  ======== Timer_Instance_init ========
 *  1. Select timer based on id
 *  2. Mark timer as in use
 *  3. Save timer handle if necessary
 *  4. Init obj using params
 *  5. Create Hwi if tickFxn !=NULL
 *  6. Timer_init()
 *  7. Timer configuration (wrt emulation, external frequency etc)
 *  8. Timer_setPeriod()
 *  9. Timer_start()
 */
Int Timer_Instance_init(Timer_Object *obj, Int id, Timer_FuncPtr tickFxn,
                        const Timer_Params *params, Error_Block *eb)
{
    UInt key;
    Int i, status;
    Hwi_Params hwiParams;

    UInt tempId = 0xffff;

    /* Make sure id is a valid timer id. */
    Assert_isTrue((id == Timer_ANY) ||
                  ((id >= 0) && (id < Timer_NUM_TIMER_DEVICES)),
                  Timer_A_invalidTimer);

    /*
     * Disable interrupts while modifying part of the Timer module state which
     * may be accessed by other creates.
     */
    key = Hwi_disable();

    /* If timer id is "any timer" (-1) */
    if (id == Timer_ANY) {
        for (i = Timer_NUM_TIMER_DEVICES - 1; i >= 0; i--) {
            if ((Timer_anyMask & (1 << i))
                && (Timer_module->availMask & (1 << i))) {
                Timer_module->availMask &= ~(1 << i);

                /* Assign the timer */
                tempId = i;
                break;
            }
        }
    }

    /* Otherwise, if the requested timer is available... */
    else if (Timer_module->availMask & (1 << id)) {
        Timer_module->availMask &= ~(1 << id);

        /* Assign the timer */
        tempId = id;
    }

    Hwi_restore(key);

    /*
     * If a timer has not been assigned because either the requested timer was
     * unavailable or 'any timer' was requested and none were available...
     */
    if (tempId == 0xffff) {
        Error_raise(eb, Timer_E_notAvailable, id, 0);
        return (2);
    }
    else {
        obj->id = tempId;
    }

    /* Fill in the instance fields */
    obj->emulationModeInit.free = params->emulationModeInit.free;
    obj->emulationModeInit.soft = params->emulationModeInit.soft;
    obj->runMode = params->runMode;
    obj->startMode = params->startMode;
    obj->prescale = params->prescale;
    obj->period = params->period;
    obj->periodType = params->periodType;

    if (obj->periodType == Timer_PeriodType_MICROSECS) {
        Timer_enableFunc(obj->id);
        if (!Timer_setPeriodMicroSecs(obj, obj->period)) {
            Error_raise(eb, Timer_E_cannotSupport, obj->period, 0);
            Hwi_restore(key);
            return (4);
        }
    }

    obj->intNum = Timer_intNumDef[obj->id];
    obj->arg = params->arg; // Save arg to pass it to the tickFxn in the stubs.
    obj->tickFxn = tickFxn;

    /* Create the hwi object if an isr function was specified */
    /* extFreq.hi is ignored */
    if (params->extFreq.lo) {
        obj->extFreq.lo = params->extFreq.lo;
    }

    if (obj->tickFxn != NULL) {
        if (params->hwiParams) {
            Hwi_Params_copy(&hwiParams, (params->hwiParams));
        }
        else {
            /* Default mask setting is SELF */
            Hwi_Params_init(&hwiParams);
        }

        /* If run mode is continuous, just create a Hwi with their isr */
        if (obj->runMode == Timer_RunMode_CONTINUOUS) {
            hwiParams.arg = obj->arg;
            obj->hwi = Hwi_create(obj->intNum, obj->tickFxn,
                                  &hwiParams, eb);
        }
        /*
         * If the run mode is one shot, create a Hwi with a oneShotStub
         * which will call the user's function and disable the hwi
         */
        else if (obj->runMode == Timer_RunMode_ONESHOT) {
            hwiParams.arg = (UArg) obj;
            obj->hwi = Hwi_create(obj->intNum,
                                  (Hwi_FuncPtr) Timer_oneShotStub,
                                  &hwiParams, eb);
        }
        else {
            Assert_isTrue(FALSE, Timer_A_invalidRunMode);
        }

        if (obj->hwi == NULL) {
            return (4);
        }
    }
    else {
        /*
         * If there is no function specified, we don't create a Hwi instance
         * and we won't enable the Timer interrupt.
         */
        obj->hwi = NULL;
    }

    status = Timer_postInit(obj, eb);

    if (status) {
        return (status);
    }

    if (obj->startMode == Timer_StartMode_AUTO) {
        Timer_start(obj);
    }

    return (0);
}

/*
 *  ======== Timer_reconfig ========
 *  1. Init obj using params
 *  2. Reconfig Hwi
 *  3. Timer_init()
 *  4. Timer configuration (wrt emulation, external frequency etc)
 *  5. Timer_setPeriod()
 *  6. Timer_start()
 */
Void Timer_reconfig (Timer_Object *obj, Timer_FuncPtr tickFxn,
                     const Timer_Params *params, Error_Block *eb)
{
    Hwi_Params hwiParams;

    /* Fill in the instance fields */
    obj->emulationModeInit.free = params->emulationModeInit.free;
    obj->emulationModeInit.soft = params->emulationModeInit.soft;
    obj->runMode = params->runMode;
    obj->startMode = params->startMode;
    obj->prescale = params->prescale;
    obj->period = params->period;
    obj->periodType = params->periodType;

    if (obj->periodType == Timer_PeriodType_MICROSECS) {
        if (!Timer_setPeriodMicroSecs(obj, obj->period)) {
            Error_raise(eb, Timer_E_cannotSupport, obj->period, 0);
        }
    }

    obj->intNum = Timer_intNumDef[obj->id];
    /* Save arg to pass it to the tickFxn in the stubs. */
    obj->arg = params->arg;
    obj->tickFxn = tickFxn;
    if (params->extFreq.lo) {
        obj->extFreq.lo = params->extFreq.lo;
    }
    /* Create the hwi object if an isr function was specified */
    if (obj->tickFxn) {
        if (params->hwiParams) {
            Hwi_Params_copy(&hwiParams, (params->hwiParams));
        }
        else {
            /* Default mask setting is SELF */
            Hwi_Params_init(&hwiParams);
        }

        if (obj->runMode == Timer_RunMode_CONTINUOUS) {
            hwiParams.arg = obj->arg;
            Hwi_reconfig (obj->hwi, obj->tickFxn, &hwiParams);
        }
        /*
         * If the run mode is one shot, create a Hwi with an oneShotStub
         * which will call the user's function and disable the hwi
         */
        else if (obj->runMode == Timer_RunMode_ONESHOT) {
            hwiParams.arg = (UArg) obj;
            Hwi_reconfig(obj->hwi, Timer_oneShotStub, &hwiParams);
        }
        else {
            Assert_isTrue(FALSE, Timer_A_invalidRunMode);
        }
    }

    Timer_postInit(obj, eb);

    if (obj->startMode == Timer_StartMode_AUTO) {
        Timer_start(obj);
    }
}

/*
 *  ======== Timer_postInit ========
 *  The postInit function contains Timer startup code common to both statically
 *  and dynamically created Timer instances. It contains the code which
 *  actually initializes the Timer devices.
 */
Int Timer_postInit(Timer_Object *obj, Error_Block *eb)
{
    UInt key;

    key = Hwi_disable();

    /* enable, stop, and clear the timer */
    Timer_enableFunc(obj->id);
    Timer_stopAndClear(obj);

    /* Set the emulation mode */
    if (obj->emulationModeInit.soft) {
        TimerDevices[obj->id].TCR |= SOFT_M;
    }
    else {
        TimerDevices[obj->id].TCR &= ~SOFT_M;
    }
    if (obj->emulationModeInit.free) {
        TimerDevices[obj->id].TCR |= FREE_M;
    }
    else {
        TimerDevices[obj->id].TCR &= ~FREE_M;
    }

    Timer_setPeriod(obj, obj->period);
    Timer_setPrescale(obj, obj->prescale);

    Hwi_restore(key);

    return (0);
}

/*
 *  ======== Timer_Instance_finalize ========
 */
Void Timer_Instance_finalize(Timer_Object *obj, Int status)
{
    UInt key;

    /* NOTE: switch contains intentional fall-throughs */
    switch (status) {
        /* Timer_delete() */
        case 0:
            // fall through

        /* setPeriodMicroSecs failed */
        case 4:
        case 5:
            Timer_stopAndClear(obj);
            Timer_disableFunc(obj->id);
            if (obj->hwi) {
                Hwi_delete(&obj->hwi);
            }

        /* Hwi create failed */

        /* hwiMask is wrong */
        case 3:

        /* timer not available */
        case 2:

        /* invalid timer id */
        case 1:

        default:
            break;
    };

    key = Hwi_disable();
    Timer_module->availMask |= (0x1 << obj->id);
    Hwi_restore(key);
}

/*
 *  ======== Timer_stopAndClear ========
 *  This helper function clears and disables a timer. It is used
 *  by postInit in initializing a timer, as well as in instance finalize
 *  to clear the device for later use.
 *
 *  It takes the following steps:
 *    1. stop timer
 *    2. disable timer interrupt. (IER and any timer specific interrupt enable)
 *    3. clear pending interrupt. (IFR and any timer specific interrupt flags)
 *    4. Set control registers back to reset value.
 *    5. clear counters
 *    6. clear period register.
 */
Void Timer_stopAndClear(Timer_Object *obj)
{
    UInt key;
    key = Hwi_disable();

    /* Stop the timer. The timer starts immediately at reset. */
    TimerDevices[obj->id].TCR |= TSS_M;

    /* Clear the Timer device's interrupt enable and interrupt flag bits. */
    TimerDevices[obj->id].TCR &= ~TIE_M;
    TimerDevices[obj->id].TCR &= ~TIF_M;

    /* Clear CPU's Timer IER and IFR bits */
    if (obj->hwi) {
        Hwi_disableInterrupt(obj->intNum);
        Hwi_clearInterrupt(obj->intNum);
    }

    /* Set other TCR bits back to reset value */
    TimerDevices[obj->id].TCR &= ~SOFT_M;
    TimerDevices[obj->id].TCR &= ~FREE_M;

    /* Clear counter */
    TimerDevices[obj->id].TIM = 0;

    /* Clear period */
    TimerDevices[obj->id].PRD = 0;

    /* Clear prescale period and counter */
    TimerDevices[obj->id].TPR = 0;

    Hwi_restore(key);
}

/*
 *  ======== Timer_start ========
 *  1. Hwi_disable();
 *  2. Clear the counters
 *  3. Clear IFR
 *  4. Enable timer interrupt
 *  5. Start timer
 *  6. Hwi_restore()
 */
Void Timer_start(Timer_Object *obj)
{
    UInt key;

    key = Hwi_disable();

    if (obj->hwi) {
        Hwi_clearInterrupt(obj->intNum);
        Hwi_enableInterrupt(obj->intNum);
    }

    TimerDevices[obj->id].TCR |= TIE_M;

    /*
     * Reload the timer counter register with the period.
     * Also reloads the prescale counter.
     */
    TimerDevices[obj->id].TCR |= TRB_M;

    /* Start the timer. (stop = 0)*/
    TimerDevices[obj->id].TCR &= ~TSS_M;

    Hwi_restore(key);
}

/*
 *  ======== Timer_stop ========
 */
Void Timer_stop(Timer_Object *obj)
{
    TimerDevices[obj->id].TCR |= TSS_M;
    if (obj->hwi) {
        Hwi_disableInterrupt(obj->intNum);
    }
}

/*
 *  ======== Timer_setPeriod ========
 *  1. Stop timer
 *  2. Set period register
 */
Void Timer_setPeriod(Timer_Object *obj, UInt32 period)
{
    Timer_stop(obj);
    obj->period = period;
    TimerDevices[obj->id].PRD = period;
}

/*
 *  ======== Timer_setPeriodMicroSecs ========
 */
Bool Timer_setPeriodMicroSecs(Timer_Object *obj, UInt32 period)
{
    Types_FreqHz freqHz;
    UInt64 counts;
    UInt32 prdCounts;
    UInt32 freqKHz;

    /*
     * stop timer
     * compute counts
     * set period register
     */
    Timer_stop(obj);
    Timer_getFreq(obj, &freqHz);

    freqKHz = freqHz.lo / 1000;

    /*
     * checkOverflow is given counts/ms and period in ms, and will return true
     * if the result of multiplying the two would overflow (if the result is
     * larger than Timer_MAX_PERIOD).
     */
    if (Timer_checkOverflow(freqKHz, period / 1000)) {
        return (FALSE);
    }
    else {
        /*
         * counts = (counts/ms) * (period in ms)
         * This must be done as a 64-bit calculation. We cannot divide by 1000
         * first because the resulting value might be truncated. So, we must do
         * the multiplication first, and the result of this multiplication may
         * require 64-bits to hold.
         */
        counts = ((UInt64) freqKHz * (UInt64) period) / (UInt64) 1000;
        prdCounts = counts / ((UInt64)obj->prescale+1);
        TimerDevices[obj->id].PRD = prdCounts;
        obj->period = prdCounts;
        obj->periodType = Timer_PeriodType_COUNTS;
        return (TRUE);
    }
}

/*
 *  ======== Timer_getPeriod ========
 */
UInt32 Timer_getPeriod(Timer_Object *obj)
{
    return (TimerDevices[obj->id].PRD);
}

/*
 *  ======== Timer_getCount ========
 *  The CPU timers count downward from PRD to 0, but getCount
 *  should return the number of counts that have passed, so
 *  the counter register is subtracted from the period.
 */
UInt32 Timer_getCount(Timer_Object *obj)
{
    return (TimerDevices[obj->id].PRD - TimerDevices[obj->id].TIM);
}

/*
 *  ======== Timer_setPrescale ========
 *  The prescaler is comprised of two registers: PSC and TDDR. The Timer
 *  Divide-Down Register (TDDR) stores the prescale factor; it essentially
 *  establishes the period of the timer. The Prescale Counter (PSC) decrements
 *  on every timer clock source. Once the PSC reaches 0, the timer is
 *  decremented.
 *
 *  The PSC and TDDR registers are divided across two registers, TPR and TPRH.
 *  TPR contains the lower halves of PSC and TDDR, and TPRH contains the upper
 *  halves of PSC and TDDR.
 *
 *  TPR: Timer Prescale Register
 *    PSC  (Bits 15-8): Prescale Counter
 *    TDDR  (Bits 7-0): Timer Divide Down Register
 *
 *  PSCH:PSC = TPRH(15:8):TPR(15:8)
 *  TDDRH:TDDR = TPRH(7:0):TPR(7:0)
 *
 *  To set the prescale, we load the prescale value into TDDR and set PSC to 0.
 */
Void Timer_setPrescale(Timer_Object *obj, UInt16 prescale)
{
    UInt32 temp;

    /* The prescale value determines the period of the timer ticks */
    obj->prescale = prescale;

    /* Load the prescale value into TDDR */
    temp = ((prescale >> 8) << TDDRH_S) + (prescale & TDDRL_M);
    TimerDevices[obj->id].TPR = temp & (TDDRH_M + TDDRL_M);

    /* Reload the timer */
    TimerDevices[obj->id].TCR |= TRB_M;
}

/*
 *  ======== Timer_getPrescale ========
 */
UInt16 Timer_getPrescale(Timer_Object *obj)
{
    UInt16 prescale;
    UInt32 temp;

    /* Load the TDDR into prescale */
    temp = TimerDevices[obj->id].TPR;
    prescale = (UInt16) ((temp >> 8) & 0xFF00);
    prescale += (UInt16) (temp & 0xFF);

    return (prescale);
}

/*
 *  ======== Timer_getPrescaleCount ========
 */
UInt16 Timer_getPrescaleCount(Timer_Object *obj)
{
    UInt16 count;
    UInt32 temp;

    /* Load the PSC into count */
    temp = TimerDevices[obj->id].TPR;
    count = (UInt16) ((temp >> 16) & 0xFF00);
    count += (UInt16) ((temp >> 8) & 0xFF);

    return (count);
}

/*
 *  ======== Timer_oneShotStub ========
 */
Void Timer_oneShotStub(UArg arg)
{
    Timer_Object *obj = (Timer_Object *) arg;

    /* Stop the timer */
    Timer_stop(obj);

    /* Clear the CPU interrupt */
    Hwi_clearInterrupt(obj->intNum);

    /* Clear the Timer Interrupt flag by writing 1 to it. */
    TimerDevices[obj->id].TCR |= TIF_M;

    /* Call the user's isr. */
    obj->tickFxn(obj->arg);
}

/*
 *  ======== Timer_getExpiredCounts ========
 */
UInt32 Timer_getExpiredCounts(Timer_Object *obj)
{
    return (0);
}

/*
 *  ======== Timer_getExpiredTicks ========
 */
UInt32 Timer_getExpiredTicks(Timer_Object *obj, UInt32 tickPeriod)
{
    return (0);
}

/*
 *  ======== Timer_getCurrentTick ========
 */
UInt32 Timer_getCurrentTick(Timer_Object *obj, Bool saveFlag)
{
    return (0);
}

/*
 *  ======== Timer_getFreq ========
 */
Void Timer_getFreq(Timer_Object *obj, Types_FreqHz *freq)
{
    BIOS_getCpuFreq(freq);
    Assert_isTrue((freq->hi == 0), NULL);
}

/*
 *  ======== Timer_getFunc ========
 */
Timer_FuncPtr Timer_getFunc(Timer_Object *obj, UArg *arg)
{
    *arg = obj->arg;
    return (obj->tickFxn);
}

/*
 *  ======== Timer_setFunc ========
 */
Void Timer_setFunc(Timer_Object *obj, Timer_FuncPtr fxn, UArg arg)
{
    obj->tickFxn = fxn;
    obj->arg = arg;

    if (obj->runMode == Timer_RunMode_CONTINUOUS) {
        Hwi_setFunc(obj->hwi, obj->tickFxn, obj->arg);
    }
    else {
        Hwi_setFunc(obj->hwi, Timer_oneShotStub, (UArg)obj);
    }
}

/*
 *  ======== Timer_checkOverflow ========
 *  Parameter 'a' is counts per ms, and parameter 'b' is the desired
 *  period in ms.
 *  Returns true if a * b is greater than MAX_PERIOD (overflow).
 */
Bool Timer_checkOverflow(UInt32 a, UInt32 b)
{
    return ((b > 0) && (a > (Timer_MAX_PERIOD / b)));
}

/*
 *  ======== Timer_trigger ========
 *  The timer frequency is equal to the CPU frequency, so just set the period
 *  to the number of instructions.
 */
Void Timer_trigger(Timer_Object *obj, UInt32 instructions)
{
    UInt key;

    /* follow proper procedure for dynamic period change */
    key = Hwi_disable();
    Timer_setPeriod(obj, instructions);
    Timer_start(obj);
    Hwi_restore(key);
}

/*
 *  ======== Timer_disableCM ========
 *  Disable the timer peripheral.
 */
Void Timer_disableCM(Int id)
{
    UInt16 periphID = 0;
    UInt16 regIndex;
    UInt16 bitIndex;
    UInt32 clearvalue;
    UInt key;

    /* convert timer ID to peripheral ID */
    if (id == 0) {
        periphID = SYSCTL_PERIPH_CLK_TIMER0;
    }
    else if (id == 1) {
        periphID = SYSCTL_PERIPH_CLK_TIMER1;
    }
    else if (id == 2) {
        periphID = SYSCTL_PERIPH_CLK_TIMER2;
    }

    if (periphID != 0) {
        key = Hwi_disable();

        /* extract SYSCTL register and bit index */
        regIndex = (uint16_t)4U * ((uint16_t)periphID &
            (uint16_t)SYSCTL_PERIPH_REG_M);
        bitIndex = ((uint16_t)periphID & SYSCTL_PERIPH_BIT_M) >>
            SYSCTL_PERIPH_BIT_S;

        /* turn off peripheral clock */
        clearvalue = HWREG(CMSYSCTL_BASE + SYSCTL_O_CMPCLKCR0 + regIndex);
        clearvalue &= ~((uint32_t)1U << bitIndex);
        HWREG(CMSYSCTL_BASE + SYSCTL_O_CMPCLKCR0 + regIndex) =
            (((uint32_t)SYSCTL_CMSYSCTL_KEY << 16U) &
            SYSCTL_CMPCLKCR0_KEY_M) | clearvalue;

        Hwi_restore(key);
    }
}

/*
 *  ======== Timer_enableCM ========
 *  Enable the timer peripheral.
 */
Void Timer_enableCM(Int id)
{
    UInt16 periphID = 0;
    UInt16 regIndex;
    UInt16 bitIndex;
    UInt key;

    /* convert timer ID to peripheral ID */
    if (id == 0) {
        periphID = SYSCTL_PERIPH_CLK_TIMER0;
    }
    else if (id == 1) {
        periphID = SYSCTL_PERIPH_CLK_TIMER1;
    }
    else if (id == 2) {
        periphID = SYSCTL_PERIPH_CLK_TIMER2;
    }

    if (periphID != 0) {
        key = Hwi_disable();

        /* extract SYSCTL register and bit index */
        regIndex = (uint16_t)4U * ((uint16_t)periphID &
            (uint16_t)SYSCTL_PERIPH_REG_M);
        bitIndex = ((uint16_t)periphID & SYSCTL_PERIPH_BIT_M) >>
            SYSCTL_PERIPH_BIT_S;

        /* turn on peripheral clock */
        HWREG(CMSYSCTL_BASE + SYSCTL_O_CMPCLKCR0 + regIndex) |=
            (((uint32_t)1U << bitIndex) |
            (((uint32_t)SYSCTL_CMSYSCTL_KEY << 16U ) & SYSCTL_CMPCLKCR0_KEY_M));

        Hwi_restore(key);
    }
}
