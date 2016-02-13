/******************************************************************************
 *
 *
 * cc26xx_ccs.cmd - CCS linker configuration file.
 *
 *
 *****************************************************************************/

--retain=g_pfnVectors

/* The following command line options are set as part of the CCS project.    */
/* If you are building using the command line, or for some reason want to    */
/* define them here, you can uncomment and modify these lines as needed.     */
/* If you are using CCS for building, it is probably better to make any such */
/* modifications in your CCS project and leave this file alone.              */
/*                                                                           */
/* --heap_size=0                                                             */
/* --stack_size=256                                                          */
/* --library=rtsv7M3_T_le_eabi.lib                                           */

/* The starting address of the application.  Normally the interrupt vectors  */
/* must be located at the beginning of the application.                      */
#define APP_BASE                0x0
#define FLASH_CCFG_BASE         0x1FFD8
#define RAM_BASE                0x20000000
#define RAM_SIZE                0x4000


/* System memory map */

MEMORY
{
    /* Application stored in and executes from internal flash */
    /* Flash Size 128 KB */
    FLASH (RX) : origin = APP_BASE, length = 0x0001FFD4
    /* Customer Configuration Area and Bootloader Backdoor configuration in flash, 40 bytes*/
    FLASH_CCFG (RX) : origin = FLASH_CCFG_BASE, length = 40
    /* Application uses internal RAM for data */
    /* RAM Size 16 KB */
    SRAM (RWX) : origin = RAM_BASE, length = RAM_SIZE
}

/* Section allocation in memory */

SECTIONS
{
    .intvecs        :   > APP_BASE
    .text           :   > FLASH
#ifdef __TI_COMPILER_VERSION
#if __TI_COMPILER_VERSION >= 15009000
    .TI.ramfunc     : {} load=FLASH, run=SRAM, table(BINIT)
#endif
#endif
    .const          :   > FLASH
    .cinit          :   > FLASH
    .pinit          :   > FLASH
    .init_array     :   > FLASH
    .ccfg   	    :   > FLASH_CCFG

    .vtable_ram     :   > SRAM
    .vtable         :   > SRAM
    .data           :   > SRAM
    .bss            :   > SRAM
    .sysmem         :   > SRAM
    .stack          :   > SRAM (HIGH)
    .nonretenvar    :   > SRAM
}

/* Create global constant that points to top of stack */
/* CCS: Change stack size under Project Properties    */
__STACK_TOP = __stack + __STACK_SIZE;
