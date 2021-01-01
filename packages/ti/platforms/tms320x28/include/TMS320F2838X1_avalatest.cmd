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
 *  ======== TMS320F2838X1_avalatest.cmd ========
 *  Defines the memory map for CPU 1 of TMS320F2838X.
 *  This is a special cmd file for RAM-only execution for avalatest.
 */
MEMORY
{
   /* BEGIN is used for the "boot to Flash" bootloader mode */
   BEGIN            : origin = 0x80000, length = 0x000002

   /* Part of M0, BOOT rom will use this for stack */
   BOOT_RSVD        : origin = 0x000002, length = 0x0001AE

   RAMM0            : origin = 0x0001B0, length = 0x000250
   RAMM1            : origin = 0x000400, length = 0x000400

   RAMD             : origin = 0x00C000, length = 0x001000

   RAMLS            : origin = 0x008000, length = 0x004000

   RAMGS            : origin = 0x00D000, length = 0x010000

   /* Flash sectors */
   FLASH0           : origin = 0x080002, length = 0x001FFE /* on-chip Flash */
   FLASH1           : origin = 0x082000, length = 0x002000 /* on-chip Flash */
   FLASH2           : origin = 0x084000, length = 0x002000 /* on-chip Flash */
   FLASH3           : origin = 0x086000, length = 0x002000 /* on-chip Flash */
   FLASH4           : origin = 0x088000, length = 0x008000 /* on-chip Flash */
   FLASH5           : origin = 0x090000, length = 0x008000 /* on-chip Flash */
   FLASH6           : origin = 0x098000, length = 0x008000 /* on-chip Flash */
   FLASH7           : origin = 0x0A0000, length = 0x008000 /* on-chip Flash */
   FLASH8           : origin = 0x0A8000, length = 0x008000 /* on-chip Flash */
   FLASH9           : origin = 0x0B0000, length = 0x008000 /* on-chip Flash */
   FLASH10          : origin = 0x0B8000, length = 0x002000 /* on-chip Flash */
   FLASH11          : origin = 0x0BA000, length = 0x002000 /* on-chip Flash */
   FLASH12          : origin = 0x0BC000, length = 0x002000 /* on-chip Flash */
   FLASH13          : origin = 0x0BE000, length = 0x002000 /* on-chip Flash */

   CPU1TOCPU2RAM    : origin = 0x03A000, length = 0x000800
   CPU2TOCPU1RAM    : origin = 0x03B000, length = 0x000800

   CPUTOCMRAM       : origin = 0x039000, length = 0x000800
   CMTOCPURAM       : origin = 0x038000, length = 0x000800

   CANA_MSG_RAM     : origin = 0x049000, length = 0x000800
   CANB_MSG_RAM     : origin = 0x04B000, length = 0x000800

   RESET            : origin = 0x3FFFC0, length = 0x000002
}

SECTIONS
{
   codestart        : > BEGIN

   .text            : > RAMGS

   .cinit           : > RAMGS

   .switch          : > RAMGS

   .reset           : > RESET, TYPE = DSECT /* not used, */

   .stack           : > RAMD

   .bss             : > RAMLS

   .bss:output      : > RAMLS

   .init_array      : > RAMGS

   .const           : > RAMGS

   .data            : > RAMGS

   .sysmem          : > RAMGS

   .binit           : > RAMGS

   ramgs0           : > RAMGS
   ramgs1           : > RAMGS

   .TI.ramfunc : {} LOAD = RAMGS,
                     RUN = RAMLS, table(BINIT),
                     LOAD_START(RamfuncsLoadStart),
                     LOAD_SIZE(RamfuncsLoadSize),
                     LOAD_END(RamfuncsLoadEnd),
                     RUN_START(RamfuncsRunStart),
                     RUN_SIZE(RamfuncsRunSize),
                     RUN_END(RamfuncsRunEnd),
                     ALIGN(4)

   MSGRAM_CPU1_TO_CPU2 > CPU1TOCPU2RAM, type=NOINIT
   MSGRAM_CPU2_TO_CPU1 > CPU2TOCPU1RAM, type=NOINIT
   MSGRAM_CPU_TO_CM    > CPUTOCMRAM,    type=NOINIT
   MSGRAM_CM_TO_CPU    > CMTOCPURAM,    type=NOINIT
}
