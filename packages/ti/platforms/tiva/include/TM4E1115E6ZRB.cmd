/******************************************************************************
 *
 * Default Linker Command file for the Texas Instruments TM4E1115E6ZRB
 *
 * This is derived from revision 11167 of the TivaWare Library.
 *
 *****************************************************************************/

--retain=g_pfnVectors

MEMORY
{
    CODESRAM (RWX) : origin = 0x00000000, length = 0x00020000
    SRAM (RWX) : origin = 0x20000000, length = 0x00008000
}

/* The following command line options are set as part of the CCS project.    */
/* If you are building using the command line, or for some reason want to    */
/* define them here, you can uncomment and modify these lines as needed.     */
/* If you are using CCS for building, it is probably better to make any such */
/* modifications in your CCS project and leave this file alone.              */
/*                                                                           */
/* --heap_size=0                                                             */
/* --stack_size=256                                                          */
/* --library=rtsv7M4_T_le_eabi.lib                                           */

/* Section allocation in memory */

SECTIONS
{
    .intvecs:   > 0x00000000
    .text   :   > CODESRAM
#ifdef __TI_COMPILER_VERSION
#if __TI_COMPILER_VERSION >= 15009000
    .TI.ramfunc : {} > CODESRAM
#endif
#endif
    .const  :   > CODESRAM
    .cinit  :   > CODESRAM
    .pinit  :   > CODESRAM
    .init_array : > CODESRAM

    .vtable :   > 0x20000000
    .data   :   > SRAM
    .bss    :   > SRAM
    .sysmem :   > SRAM
    .stack  :   > SRAM
}

__STACK_TOP = __stack + 512;
