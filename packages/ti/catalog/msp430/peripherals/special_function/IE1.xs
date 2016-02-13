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
 *  ======== IE1.xs ========
 */
var REGS;
var GetSet;
/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    REGS = this;
    GetSet = xdc.module("xdc.services.getset.GetSet");
}

/*
 *  ======== instance$meta$init ========
 */
function instance$meta$init()
{
    // Activate getter/setter support on current instance
    GetSet.init(this);
    GetSet.init(this.IE1);

    /* save "this" for use inside setter */
    var inst = this;
    var group = GetSet.createGroup();

    this.interruptSource[0].registerName = "WDTIE";
    this.interruptSource[0].registerDescription = "WDT+ Interrupt Enable";
    this.interruptSource[0].interruptEnable = false;
    this.interruptSource[0].interruptHandler = false;

    this.interruptSource[1].registerName = "OFIE";
    this.interruptSource[1].registerDescription = "Oscillator Fault Interrupt Enable";
    this.interruptSource[1].interruptEnable = false;
    this.interruptSource[1].interruptHandler = false;

    this.interruptSource[2].registerName = "";
    this.interruptSource[2].registerDescription = "";
    this.interruptSource[2].interruptEnable = false;
    this.interruptSource[2].interruptHandler = false;

    this.interruptSource[3].registerName = "";
    this.interruptSource[3].registerDescription = "";
    this.interruptSource[3].interruptEnable = false;
    this.interruptSource[3].interruptHandler = false;

    this.interruptSource[4].registerName = "NMIIE";
    this.interruptSource[4].registerDescription = "NMI Pin Interrupt Enable";
    this.interruptSource[4].interruptEnable = false;
    this.interruptSource[4].interruptHandler = false;

    this.interruptSource[5].registerName = "ACCVIE";
    this.interruptSource[5].registerDescription = "Flash Ctrl Access Violation Int Enable";
    this.interruptSource[5].interruptEnable = false;
    this.interruptSource[5].interruptHandler = false;

    this.interruptSource[6].registerName = "";
    this.interruptSource[6].registerDescription = "";
    this.interruptSource[6].interruptEnable = false;
    this.interruptSource[6].interruptHandler = false;

    this.interruptSource[7].registerName = "";
    this.interruptSource[7].registerDescription = "";
    this.interruptSource[7].interruptEnable = false;
    this.interruptSource[7].interruptHandler = false;

    function monitorAccvIe() {
        if(inst.IE1.ACCVIE == REGS.ACCVIE) {
            inst.IFG1.ACCVIFG = REGS.ACCVIFG;
        }
        else {
            inst.IFG1.ACCVIFG = REGS.ACCVIFG_OFF;
        }
    }
    group.onSet(inst.IE1, "ACCVIE", monitorAccvIe);

    function monitorWdtIe() {
        if(inst.IE1.WDTIE == REGS.WDTIE) {
            inst.IFG1.WDTIFG = REGS.WDTIFG;
        }
        else {
            inst.IFG1.WDTIFG = REGS.WDTIFG_OFF;
        }
    }
    group.onSet(inst.IE1, "WDTIE", monitorWdtIe);

    function monitorOfIe() {
        if(inst.IE1.OFIE == REGS.OFIE) {
            //inst.IFG1.OFIFG = REGS.OFIFG;
        }
        else {
            //inst.IFG1.OFIFG = REGS.OFIFG_OFF;
        }
    }
    group.onSet(inst.IE1, "OFIE", monitorOfIe);

    function monitorNmiIe() {
        if(inst.IE1.NMIIE == REGS.NMIIE) {
            inst.IFG1.NMIIFG = REGS.NMIIFG;
        }
        else {
            inst.IFG1.NMIIFG = REGS.NMIIFG_OFF;
        }
    }
    group.onSet(inst.IE1, "NMIIE", monitorNmiIe);
}



/*
 *  ======== getACCVIE ========
 */
function getACCVIE()
{
    var REGS = this.$module;

    if(this.IE1.ACCVIE == REGS.ACCVIE)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setACCVIE ========
 */
function setACCVIE(set)
{
    var REGS = this.$module;
    if(set)
    {
        this.IE1.ACCVIE = REGS.ACCVIE;
    }
    else
    {
        this.IE1.ACCVIE = REGS.ACCVIE_OFF;
    }

    return set;
}

/*
 *  ======== getWDTIE ========
 */
function getWDTIE()
{
    var REGS = this.$module;
    if(this.IE1.WDTIE == REGS.WDTIE)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setWDTIE ========
 */
function setWDTIE(set)
{
    var REGS = this.$module;

    if(set)
    {
        this.IE1.WDTIE = REGS.WDTIE;
    }
    else
    {
        this.IE1.WDTIE = REGS.WDTIE_OFF;
    }

    return set;
}

/*
 *  ======== getWDTIFG ========
 */
function getWDTIFG()
{
    var REGS = this.$module;
    if(this.IFG1.WDTIFG == REGS.WDTIFG)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setWDTIFG ========
 */
function setWDTIFG(set)
{
    var REGS = this.$module;

    if(set)
    {
        this.IFG1.WDTIFG = REGS.WDTIFG;
    }
    else
    {
        this.IFG1.WDTIFG = REGS.WDTIFG_OFF;
    }

    return set;
}

/*
 *  ======== getOFIE ========
 */
function getOFIE()
{
    var REGS = this.$module;
    if(this.IE1.OFIE == REGS.OFIE)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setOFIE ========
 */
function setOFIE(set)
{
    var REGS = this.$module;

    if(set)
    {
        this.IE1.OFIE = REGS.OFIE;
    }
    else
    {
        this.IE1.OFIE = REGS.OFIE_OFF;
    }

    return set;
}

/*
 *  ======== getOFIFG ========
 */
function getOFIFG()
{
    var REGS = this.$module;
    if(this.IFG1.OFIFG == REGS.OFIFG)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setOFIFG ========
 */
function setOFIFG(set)
{
    var REGS = this.$module;

    if(set)
    {
        this.IFG1.OFIFG = REGS.OFIFG;
    }
    else
    {
        this.IFG1.OFIFG = REGS.OFIFG_OFF;
    }

    return set;
}

/*
 *  ======== getNMIIE ========
 */
function getNMIIE()
{
    var REGS = this.$module;
    if(this.IE1.NMIIE == REGS.NMIIE)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setNMIIE ========
 */
function setNMIIE(set)
{
    var REGS = this.$module;

    if(set)
    {
        this.IE1.NMIIE = REGS.NMIIE;
    }
    else
    {
        this.IE1.NMIIE = REGS.NMIIE_OFF;
    }

    return set;
}

/*
 *  ======== getNMIIFG ========
 */
function getNMIIFG()
{
    var REGS = this.$module;
    if(this.IFG1.NMIIFG == REGS.NMIIFG)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*
 *  ======== setNMIIE ========
 */
function setNMIIFG(set)
{
    var REGS = this.$module;

    if(set)
    {
        this.IFG1.NMIIFG = REGS.NMIIFG;
    }
    else
    {
        this.IFG1.NMIIFG = REGS.NMIIFG_OFF;
    }

    return set;
}
/*
 *  @(#) ti.catalog.msp430.peripherals.special_function; 1, 0, 0,; 12-4-2015 21:40:21; /db/ztree/library/trees/platform/platform-q16/src/
 */

