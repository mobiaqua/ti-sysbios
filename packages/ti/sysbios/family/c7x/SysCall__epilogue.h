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

#ifndef ti_sysbios_family_c7x_SysCall__epilogue__include
#define ti_sysbios_family_c7x_SysCall__epilogue__include

#ifdef __cplusplus
extern "C" {
#endif

#if defined(xdc_target__isaCompatible_71)

/*
 *  ======== SysCall_enterPrivMode ========
 */
#define ti_sysbios_family_c7x_SysCall_enterPrivMode() asm(" \
	\tmvc.s1 rp, a8; \n \
	||\tstd.d1 a8, *d15++(-0x10); \n \
	\tsyscall.b1 0; \n \
	\tmvc.s1 a8, rp; \n \
	\tldd.d1 *d15(0x10), a8; \n \
	||\taddd.d2 d15, 0x10, d15; ");

/*
 *  ======== SysCall_enterUnprivMode ========
 */
#define ti_sysbios_family_c7x_SysCall_enterUnprivMode() asm(" \
	\tmvc.s1 rp, a8; \n \
	||\tstd.d1 a8, *d15++(-0x10); \n \
	\tsyscall.b1 1; \n \
	\tmvc.s1 a8, rp; \n \
	\tldd.d1 *d15(0x10), a8; \n \
	||\taddd.d2 d15, 0x10, d15; ");

/*
 *  ======== SysCall_restorePrivMode ========
 */
#define ti_sysbios_family_c7x_SysCall_restorePrivMode() asm(" \
	\tmvc.s1 rp, a8; \n \
	||\tstd.d1 a8, *d15++(-0x10); \n \
	\tsyscall.b1 2; \n \
	\tmvc.s1 a8, rp; \n \
	\tldd.d1 *d15(0x10), a8; \n \
	||\taddd.d2 d15, 0x10, d15; ");

#endif /* defined(xdc_target__isaCompatible_71) */

#ifdef __cplusplus
}
#endif

#endif /* ti_sysbios_family_c7x_SysCall__epilogue__include */
