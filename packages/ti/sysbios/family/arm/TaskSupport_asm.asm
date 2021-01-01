;
;  Copyright (c) 2014-2020, Texas Instruments Incorporated
;  All rights reserved.
; 
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions
;  are met:
; 
;  *  Redistributions of source code must retain the above copyright
;     notice, this list of conditions and the following disclaimer.
; 
;  *  Redistributions in binary form must reproduce the above copyright
;     notice, this list of conditions and the following disclaimer in the
;     documentation and/or other materials provided with the distribution.
; 
;  *  Neither the name of Texas Instruments Incorporated nor the names of
;     its contributors may be used to endorse or promote products derived
;     from this software without specific prior written permission.
; 
;  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
;  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
;  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
;  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
;  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
;  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
;  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
;  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
;
; ======== TaskSupport_asm.asm ========
;
        .cdecls C,NOLIST
        %{
            #define TRUE    1
            #define FALSE   0
        %}

    .if __TI_EABI_ASSEMBLER
        .asg ti_sysbios_family_arm_TaskSupport_swap__E, _ti_sysbios_family_arm_TaskSupport_swap__E
        .asg ti_sysbios_family_arm_TaskSupport_glue, _ti_sysbios_family_arm_TaskSupport_glue
        .asg ti_sysbios_family_arm_TaskSupport_glueUnpriv, _ti_sysbios_family_arm_TaskSupport_glueUnpriv
        .asg ti_sysbios_knl_Task_self__E, _ti_sysbios_knl_Task_self__E
    .endif

        .state32

        .global _ti_sysbios_family_arm_TaskSupport_swap__E
    .global ti_sysbios_knl_Task_exit__E
        .global _ti_sysbios_family_arm_TaskSupport_glue
        .global _ti_sysbios_family_arm_TaskSupport_glueUnpriv

        .align  4

;
;  ======== TaskSupport_swap ========
;
;  TaskSupport_swap(oldSP, newSP)
;

OLD     .set    r0                      ; 1st argument
NEW     .set    r1                      ; 2nd argument

        .sect ".text:_ti_sysbios_family_arm_TaskSupport_swap__E"
        .clink
        .armfunc _ti_sysbios_family_arm_TaskSupport_swap__E

_ti_sysbios_family_arm_TaskSupport_swap__E:
        .asmfunc
    .if  __TI_ARM_V7__
        clrex
    .endif
        push    {r4-r11, lr}
    .if __TI_VFP_SUPPORT__ | __TI_NEON_SUPPORT__
        vstmdb  {D8-D15}, r13!          ; push vfp caller regs
    .endif
        str     sp, [OLD]

    .if (ti_sysbios_BIOS_smpEnabled__D)
        clrex                           ; clear exclusive monitor status
        ;  This instruction is not supported on ARM9 but since SMP is never
        ;  enabled for ARM9, it is okay to make execution of clrex conditional
        ;  on SMP being enabled.
    .endif

        ldr     sp, [NEW]
    .if __TI_VFP_SUPPORT__ | __TI_NEON_SUPPORT__
        vldmia  {D8-D15}, r13!           ; pop vfp caller regs
    .endif
        pop     {r4-r11, pc}

        .endasmfunc
;
;  ======== TaskSupport_glue ========
;
;  This glue function is executed immediately before executing the "fxn"
;  passed to Task_start.  This function loads the parameters to "fxn" into
;  registers - necessary for the arm register passing model.
;

        .sect ".text:_ti_sysbios_family_arm_TaskSupport_glue"
        .clink
        .armfunc _ti_sysbios_family_arm_TaskSupport_glue

_ti_sysbios_family_arm_TaskSupport_glue:
        .asmfunc

        ldr     r0, [sp, #16]   ; Task enter function
        blx     r0              ; call Task enter function

; return from Task enter function here
        ldr     r0, [sp, #0]    ; task arg0
        ldr     r1, [sp, #4]    ; task arg1
        ldr     r2, [sp, #8]    ; task fxn

        ldr     lr, [sp, #12]   ; Task exit function
        bx      r2              ; call task fxn,  ("returns" to exit func)

        .endasmfunc

;
;  ======== TaskSupport_glueUnpriv ========
;
;  This glue function is executed immediately before executing the "fxn"
;  passed to Task_start.  This function loads the parameters to "fxn" into
;  registers - necessary for the m3 register passing model. This function
;  alse switches execution state to unprivileged before jumping to "fxn" and
;  switches execution state back to privileged when "fxn" returns.
;

        .sect ".text:ti_sysbios_family_arm_TaskSupport_glueUnpriv"
        .clink
        .thumbfunc ti_sysbios_family_arm_TaskSupport_glueUnpriv

ti_sysbios_family_arm_TaskSupport_glueUnpriv:
        .asmfunc

        .if  __TI_ARM_V7__
        ldr     r0, [sp, #16]   ; Task enter function
        blx     r0              ; call Task enter function

; return from Task enter function here
        svc     #1              ; Enter unprivileged mode

        ldr     r0, [sp, #0]    ; task arg0
        ldr     r1, [sp, #4]    ; task arg1
        ldr     r2, [sp, #8]    ; task fxn
        mov     r3, #0          ; clear register to prevent data leak
        mov     r4, #0          ; clear register to prevent data leak
        mov     r5, #0          ; clear register to prevent data leak
        mov     r6, #0          ; clear register to prevent data leak
        mov     r7, #0          ; clear register to prevent data leak
        mov     r8, #0          ; clear register to prevent data leak
        mov     r9, #0          ; clear register to prevent data leak
        mov     r10, #0         ; clear register to prevent data leak
        mov     r11, #0         ; clear register to prevent data leak
        mov     r12, #0         ; clear register to prevent data leak
        blx     r2              ; call task fxn

; Below code reads Task_exit() address from code memory. This is
; unlike the Task_glue() function which reads the Task_exit() address
; from the stack. This is to prevent an attacker from directly
; jumping to the svc instruction below and inserting a custom
; function address on the stack so the attacker's code is
; executed in privileged mode
        svc     #0              ; Enter priv mode
        movw    r0, ti_sysbios_knl_Task_exit
        movt    r0, ti_sysbios_knl_Task_exit
        ldr     r0, [r0]
        bx      r0
        .endif
ti_sysbios_knl_Task_exit:
        .word          ti_sysbios_knl_Task_exit__E

        .endasmfunc
