/*
 *  ======== select.h ========
 *  This header selects an appropriate target name based on TI compiler
 *  predefined macros and includes the appropriate target-specific std.h.
 *
 *  This header is entirely optional: the user can directly select any
 *  existing target by adding definition of the following two symbols to
 *  the compile line:
 *    xdc_target_name__     the short name of the target; e.g., C64P
 *    xdc_target_types__    a package path relative path to the types header
 *                          for the target; e.g., ti/targets/std.h
 *
 *  For more information about these symbols see:
 *  http://rtsc.eclipse.org/docs-tip/Integrating_RTSC_Modules
 */

#if defined (__arm__) && defined (__ARM_EABI__)
#include <gnu/targets/arm/select.h>
#endif
