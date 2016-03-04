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
 *  ======== SR.xs ========
 */
var GetSet;

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init() 
{
    // Activate getter/setter support on current instance
    GetSet.init(this);
    GetSet.init(this.SR);
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init() 
{
    // Get handle to getter/setter service
    GetSet = xdc.module("xdc.services.getset.GetSet");
}

/*
 *  ======== getSCG1 ========
 */
function getSCG1() 
{
    var REGS = this.$module;
    if(this.SR.SCG1 == REGS.SCG1)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setSCG1 ========
 */
function setSCG1(set) 
{
    var REGS = this.$module;
    if(set)
    {
        this.SR.SCG1 = REGS.SCG1;
    }
    else
    {
        this.SR.SCG1 = REGS.SCG1_OFF;
    }
    
    return set;
}

/*
 *  ======== getSCG0 ========
 */
function getSCG0() 
{
    var REGS = this.$module;
    if(this.SR.SCG0 == REGS.SCG0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setSCG0 ========
 */
function setSCG0(set) 
{
    var REGS = this.$module;
        
    if(set)
    {
        this.SR.SCG0 = REGS.SCG0;
    }
    else
    {
        this.SR.SCG0 = REGS.SCG0_OFF;
    }
    
    return set;
}

/*
 *  ======== getOSCOFF ========
 */
function getOSCOFF() 
{
    var REGS = this.$module;
    if(this.SR.OSCOFF == REGS.OSCOFF)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setOSCOFF ========
 */
function setOSCOFF(set) 
{
    var REGS = this.$module;
    
    if(set)
    {
        this.SR.OSCOFF = REGS.OSCOFF;
    }
    else
    {
        this.SR.OSCOFF = REGS.OSCOFF_OFF;
    }
    
    return set;
}

/*
 *  ======== getCPUOFF ========
 */
function getCPUOFF() 
{
    var REGS = this.$module;
    if(this.SR.CPUOFF == REGS.CPUOFF)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setCPUOFF ========
 */
function setCPUOFF(set) 
{
    var REGS = this.$module;
    
    if(set)
    {
        this.SR.CPUOFF = REGS.CPUOFF;
    }
    else
    {
        this.SR.CPUOFF = REGS.CPUOFF_OFF;
    }
    
    return set;
}

/*
 *  ======== getGIE ========
 */
function getGIE() 
{
    var REGS = this.$module;
    if(this.SR.GIE == REGS.GIE)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setGIE ========
 */
function setGIE(set) 
{
    var REGS = this.$module;
    
    if(set)
    {
        this.SR.GIE = REGS.GIE;
    }
    else
    {
        this.SR.GIE = REGS.GIE_OFF;
    }
    
    return set;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.special_function; 1, 0, 0,2; 1-29-2016 10:00:57; /db/ztree/library/trees/platform/platform-q17/src/
 */

