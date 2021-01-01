/*
 *  Copyright 2020 by Texas Instruments Incorporated.
 *
 */

/*****************************************************************************/
/* BOOT.C   v1.0.0A15352 - Initialize the C70 C runtime environment          */
/*                                                                           */
/* Copyright (c) 2015-2016 Texas Instruments Incorporated                    */
/* http://www.ti.com/                                                        */
/*                                                                           */
/*  Redistribution and  use in source  and binary forms, with  or without    */
/*  modification,  are permitted provided  that the  following conditions    */
/*  are met:                                                                 */
/*                                                                           */
/*     Redistributions  of source  code must  retain the  above copyright    */
/*     notice, this list of conditions and the following disclaimer.         */
/*                                                                           */
/*     Redistributions in binary form  must reproduce the above copyright    */
/*     notice, this  list of conditions  and the following  disclaimer in    */
/*     the  documentation  and/or   other  materials  provided  with  the    */
/*     distribution.                                                         */
/*                                                                           */
/*     Neither the  name of Texas Instruments Incorporated  nor the names    */
/*     of its  contributors may  be used to  endorse or  promote products    */
/*     derived  from   this  software  without   specific  prior  written    */
/*     permission.                                                           */
/*                                                                           */
/*  THIS SOFTWARE  IS PROVIDED BY THE COPYRIGHT  HOLDERS AND CONTRIBUTORS    */
/*  "AS IS"  AND ANY  EXPRESS OR IMPLIED  WARRANTIES, INCLUDING,  BUT NOT    */
/*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    */
/*  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT    */
/*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    */
/*  SPECIAL,  EXEMPLARY,  OR CONSEQUENTIAL  DAMAGES  (INCLUDING, BUT  NOT    */
/*  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,    */
/*  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY    */
/*  THEORY OF  LIABILITY, WHETHER IN CONTRACT, STRICT  LIABILITY, OR TORT    */
/*  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE    */
/*  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.     */
/*                                                                           */
/*****************************************************************************/
#include <stdint.h>
#include <autoinit.h>

#include <xdc/runtime/Startup.h>

extern __FAR__ int xdc_runtime_Startup__RESETFXN__C;
extern __FAR__ void xdc_runtime_System_exit__E(int status);

extern int _args_main();

/*---------------------------------------------------------------------------*/
/* ALLOCATE THE MEMORY FOR THE SYSTEM STACK.  THIS SECTION WILL BE SIZED     */
/* BY THE LINKER.                                                            */
/*---------------------------------------------------------------------------*/
extern char __TI_STACK_END[];
register volatile uint64_t __SP;

#pragma DATA_ALIGN   (_stack, 8);
#pragma DATA_SECTION (_stack, ".stack");
char _stack[16];

/*****************************************************************************/
/* C_INT00() - C ENVIRONMENT ENTRY POINT                                     */
/*****************************************************************************/
extern void _c_int00()
{
    int retVal;

   /*------------------------------------------------------------------------*/
   /* SETUP __SP IN A POSITION-INDEPENDENT MANNER (I.E. NO _symval())        */
   /*------------------------------------------------------------------------*/
    __SP = (((uint64_t)&__TI_STACK_END) - 16) & ~0b111;

   /*------------------------------------------------------------------------*/
   /* Call hook configured into Startup_resetFxn                             */
   /*------------------------------------------------------------------------*/
   if (_symval(&xdc_runtime_Startup__RESETFXN__C) == 1) {
      xdc_runtime_Startup_reset__I();
   }

   /*------------------------------------------------------------------------*/
   /* CALL THE AUTOINITIALIZATION ROUTINE.                                   */
   /*------------------------------------------------------------------------*/
   AUTO_INIT();

   retVal = _args_main();

   /*------------------------------------------------------------------------*/
   /* CALL System_exit                                                       */
   /*------------------------------------------------------------------------*/
   xdc_runtime_System_exit__E(retVal);
}
/*

 */

