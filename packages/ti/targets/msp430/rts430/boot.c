/*
 *  Copyright 2018 by Texas Instruments Incorporated.
 *
 */

#if __TI_COMPILER_VERSION__ >= 4004000
#include "boot_4.4.c"
#elif __TI_COMPILER_VERSION__ >= 4003000
#include "boot_4.3.c"
#elif __TI_COMPILER_VERSION__ >= 4000000
#include "boot_4.0.c"
#elif __TI_COMPILER_VERSION__ >= 3003000
#include "boot_3.3.c"
#elif __TI_COMPILER_VERSION__ >= 3002000
#include "boot_3.2.c"
#else
#include "boot_2.1.c"
#endif
/*
 *  @(#) ti.targets.msp430.rts430; 1, 0, 0,0; 4-20-2018 17:27:23; /db/ztree/library/trees/xdctargets/xdctargets-q01/src/ xlibrary

 */

