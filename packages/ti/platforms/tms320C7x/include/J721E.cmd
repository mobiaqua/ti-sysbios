/*----------------------------------------------------------------------------*/
/* J721E.cmd                                                                  */
/*                                                                            */
/* (c) Texas Instruments 2019-2020, All rights reserved.                      */
/*                                                                            */

-c
-heap  0x20000
-stack 0x20000
--args 0x1000

/* Set L1D, L1P and L2 Cache Sizes */
ti_sysbios_family_c7x_Cache_l1dSize = 0;
ti_sysbios_family_c7x_Cache_l1pSize = 0;
ti_sysbios_family_c7x_Cache_l2Size = 0;

MEMORY
{
        MSMC:   o = 70000000h   l = 00800000h
        DDR:    o = 80000000h   l = 80000000h
}

SECTIONS
{
    .vecs       >       MSMC ALIGN(0x400000)
    .text       >       MSMC

    .bss        >       MSMC  /* Zero-initialized data */
    .data       >       MSMC  /* Initialized data */

    .cinit      >       MSMC  /* could be part of const */
    .init_array >       MSMC  /* C++ initializations */
    .stack      >       MSMC ALIGN(0x10000)
    .args       >       MSMC
    .cio        >       MSMC
    .const      >       MSMC
    .switch     >       MSMC /* For exception handling. */
                             /* Not a default ELF section -- remove?  */
                             /* could be part of const */
    .sysmem     >       MSMC /* heap */

 /*
    .tbss       >       MSMC  TLS static
    .tdata      >       MSMC  TLS initialized data

    .got        >       MSMC
    .plt        >       MSMC

    .ppinfo     >       MSMC Need default behavior for non-common sections?
    .ppdata     >       MSMC Need default behavior for non-common sections?
 */
}
