/*
 * Copyright (c) 2016, Texas Instruments Incorporated
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
 *  ======== TNETV107X.xdc ========
 *
 */
package ti.catalog.c6000;

/*!
 *  ======== TNETV107X ========
 */
metaonly module TNETV107X inherits ti.catalog.ICpuDataSheet
{

    config long cacheSizeL1[string] = [
        ["0k",  0x0000],
        ["4k",  0x1000],
        ["8k",  0x2000],
        ["16k", 0x4000],
        ["32k", 0x8000],
    ];

    config long cacheSizeL2[string] = [
        ["0k",   0x00000],
        ["32k",  0x08000],
        ["64k",  0x10000],
        ["128k", 0x20000]
    ];

   readonly config ti.catalog.c6000.ICacheInfo.CacheDesc cacheMap[string] =  [
        ['l1PMode',
             {desc: "L1P Cache",
              base: 0x11E08000,
              map: [["0k", 0x0000],
                    ["4k", 0x1000],
                    ["8k", 0x2000],
                    ["16k", 0x4000],
                    ["32k", 0x8000]],
              defaultValue: "32k",
              memorySection: "L1PSRAM"}
        ],

        ['l1DMode',
            {desc: "L1D Cache",
             base: 0x11F04000,
             map: [["0k", 0x0000],
                   ["4k", 0x1000],
                   ["8k", 0x2000],
                   ["16k", 0x4000],
                   ["32k", 0x8000]],
             defaultValue: "32k",
             memorySection: "L1DSRAM"}
        ],

        ['l2Mode',
            {desc: "L2 Cache",
             base: 0x11800000,
             map: [["0k", 0x0000],
                   ["32k", 0x8000],
                   ["64k", 0x10000],
                   ["128k", 0x20000]],
             defaultValue: "0k",
             memorySection: "L2RAM"}
        ],

    ];

instance:
    override config int     minProgUnitSize = 1;
    override config int     minDataUnitSize = 1;
    override config int     dataWordSize    = 4;

    override config string   cpuCore        = "64x+";
    override config string   isa = "64P";

    config xdc.platform.IPlatform.Memory memMap[string]  = [
        ["L2RAM", {
            comment:    "Internal 128KB L2 memory",
            name:       "L2RAM",
            base:       0x11800000,
            len:        0x00020000,
            space:      "code/data",
            access:     "RWX"
        }],

        ["L1PSRAM", {
            comment:    "Internal 32KB L1 program memory",
            name:       "L1PSRAM",
            base:       0x11E08000,
            len:        0x00008000,
            space:      "code",
            access:     "RWX"
        }],

        ["L1DSRAM", {
            comment:    "Internal 80KB L1 data memory",
            name:       "L1DSRAM",
            base:       0x11F04000,
            len:        0x00014000,
            space:      "data",
            access:     "RW"
        }],
    ];
};
