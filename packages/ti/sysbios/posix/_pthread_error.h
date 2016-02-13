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
 *  ======== _pthread_error.h ========
 */

#ifndef ti_sysbios_posix__pthread_error__include
#define ti_sysbios_posix__pthread_error__include

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EPERM
#define EPERM        1  /* Do not have permission to do the operation  */
#endif

#ifndef ENOMEM
#define ENOMEM       12      /* Cannot allocate memory */
#endif

#ifndef EBUSY
#define EBUSY        16  /* Device busy */
#endif

#ifndef EINVAL
#define EINVAL       22  /* Invalid argument */
#endif

#ifndef EDEADLK
#define EDEADLK      45 /* Deadlock condition - from gcc tools sys/errno.h
                         * (Different from ndk serrno.h where EDEADLK is
                         * defined as 11.)
                         */
#endif

#ifndef ENOSYS
#define ENOSYS       88 /* Function not implemented */
#endif

#ifndef ETIMEDOUT
#define ETIMEDOUT    60  /* Timed out waiting for resource (from ndk serrno.h
                          * GCC tools sys/errno.h defines ETIMEDOUT to 116.
                          */
#endif

#define EAGAIN       35  /* Semaphore not available (from ndk serrno.h).
                          * GCC tools sys/errno.h defines EAGAIN to 11.
                          */

#ifdef __cplusplus
}
#endif

#endif
