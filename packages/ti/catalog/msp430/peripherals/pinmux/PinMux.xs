/* 
 *  Copyright (c) 2008 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 *
 *  Contributors:
 *      Texas Instruments - initial implementation
 *
 * */

/*
 *  ======== PinMux.xs ========
 */

var PinMux = null;
/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
    /* Only process during "cfg" phase */
    if (xdc.om.$name != "cfg") {
        return;
    }
    PinMux = this;
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    var Program = xdc.useModule('xdc.cfg.Program');

    /* These registers are on all FR devices */
    PinMux.forceSetDefaultRegister.$add({ register : "p1sel0" , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p1sel1" , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p1out"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p1dir"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p1ren"  , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p1ies"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p1ifg"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p1ie"   , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p2out"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p2sel0" , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p2sel1" , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p2dir"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p2ren"  , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "p2ies"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p2ifg"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "p2ie"   , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "pjout"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "pjsel0" , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "pjsel1" , regForceSet : false });
    PinMux.forceSetDefaultRegister.$add({ register : "pjdir"  , regForceSet : true  });
    PinMux.forceSetDefaultRegister.$add({ register : "pjren"  , regForceSet : false });

    /* Add the following registers for these devices */
    if (Program.cpu.deviceName.match(/^MSP430FR57(39|37|35|33|31|29|27|25|23|21)/i) ||
        Program.cpu.deviceName.match(/^MSP430FR5(9|8)/i)) {

        PinMux.forceSetDefaultRegister.$add({ register : "p3out"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p3sel0" , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p3sel1" , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p3dir"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p3ren"  , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p3ies"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p3ifg"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p3ie"   , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p4out"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p4sel0" , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p4sel1" , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p4dir"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p4ren"  , regForceSet : false });
        PinMux.forceSetDefaultRegister.$add({ register : "p4ies"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p4ifg"  , regForceSet : true  });
        PinMux.forceSetDefaultRegister.$add({ register : "p4ie"   , regForceSet : false });
    }
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
}
/*
 *  @(#) ti.catalog.msp430.peripherals.pinmux; 1, 0, 0,2; 1-29-2016 10:00:55; /db/ztree/library/trees/platform/platform-q17/src/
 */

