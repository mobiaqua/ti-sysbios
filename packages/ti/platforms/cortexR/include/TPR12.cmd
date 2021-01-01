/*----------------------------------------------------------------------------*/
/* TPR12.cmd                                                              */
/*                                                                            */
/* (c) Texas Instruments 2019-2020, All rights reserved.                           */
/*                                                                            */

/* USER CODE BEGIN (0) */
/* USER CODE END */

/*----------------------------------------------------------------------------*/
/* Memory Map                                                                 */
MEMORY{
    VECTORS       (X) : origin=0x00000000 length=0x00000100
    TCMA_RAM    (RWX) : origin=0x00000100 length=0x00003f00
    TCMB_RAM    (RWX) : origin=0x00080000 length=0x00004000
    L2_RAM_BANK0 (RW) : origin=0x10200000 length=0x00080000
    L2_RAM_BANK1 (RW) : origin=0x10280000 length=0x00070000
    L3_RAM       (RW) : origin=0x88000000 length=0x000C0000
}

/*----------------------------------------------------------------------------*/
/* Section Configuration                                                      */
SECTIONS{
    .text    align(8) : {} >> TCMA_RAM | TCMB_RAM | L2_RAM_BANK1
    .const   align(8) : {} >> TCMA_RAM | TCMB_RAM | L2_RAM_BANK0
    .data             : {} >> L2_RAM_BANK1 | L2_RAM_BANK0
    .cinit   align(8) : {} > TCMA_RAM | TCMB_RAM | L2_RAM_BANK0
    .pinit   align(8) : {} > TCMA_RAM | TCMB_RAM | L2_RAM_BANK0
    .bss              : {} > L2_RAM_BANK1 | L2_RAM_BANK0
    .sysmem           : {} > L2_RAM_BANK1 | L2_RAM_BANK0
    .args             : {} > L2_RAM_BANK1 | L2_RAM_BANK0
    .stack            : {} > TCMA_RAM | TCMB_RAM | L2_RAM_BANK1 | L2_RAM_BANK0 fill=0xFFFFFFFF

    .boot:{
       *.*(*ti_sysbios_family_arm_MPU*)
       boot.aer5f(*.text)
       *.*(*startup*)
       *.*(*Startup*)
       *.*(*Cache*)
     } > TCMA_RAM | TCMB_RAM

}
/*----------------------------------------------------------------------------*/
