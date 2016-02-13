/*
 * Copyright (c) 2015, Texas Instruments Incorporated
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
 *  ======== genMpuHtml.xs ========
 *
 *  This script is used to generate the html code for the default MPU settings
 *  found in the MPU module's cdoc.
 */

/*
 *  ======== createTable ========
 *  Create a HTML table that shows the default MPU region settings/attributes
 *  for each device in DeviceTable
 */
function createTable(deviceTable, fileBase)
{
    // create a hash to track duplicates.  There are dups between C6000 and ARM.
    // e.g. OMAPL137 has a timer entry for both arm and c6000.  However, the timer
    // addrs are the same for these, so don't generate a table for OMAPL137 twice.
    var dupTracker = new Array();

    var scriptStart = "\nvar m_count = 0;\nm_items = new Array(\n";

    // these variables will contain the html code to generate
    var tableStart = "";
    var tableRows  = "";
    var tableEnd   = "";

    // create the output file.
    // We will generate the contents of this javascript script
    var outputFile =
         java.io.File(fileBase + "/doc-files/MpuRegions.js");

    /* Delete the HTML file first if it exists. */
    if (outputFile.exists()) {
        outputFile["delete"]();
    }

    var fos = java.io.FileWriter(outputFile);

    // insert the beginning of the script
    fos.write(scriptStart);

    // print out the title
    var title = "\"<h3>Default MPU Region Settings/Attributes</h3>\",\n";
    fos.write(title);

    //
    // cycle thru the entire deviceArray from Timer.xs.  Goal is to grab all
    // mappings of timer id to actual timer name and address, then use these
    // values to generate the html tables.
    //

    //for each device (e.g. RM57D8xx)
    var sortedDeviceArray = new Array();
    for (var device in deviceTable) {
        // create sorted array of device names
        sortedDeviceArray.push(device);
    }
    // sort it!
    sortedDeviceArray.sort();

    for (var y = 0; y < sortedDeviceArray.length; y++) {
        var device = sortedDeviceArray[y];

        var numCores = 0;
        for (var coreId in deviceTable[device]) {
            numCores++;
        }
        for (var coreId in deviceTable[device]) {
            var deviceTitle;
            if (numCores > 1) {
                deviceTitle = device + " " + coreId;
            }
            else {
                deviceTitle = device;
            }

            // get the current device's MPU region settings array
            var regionArray = deviceTable[device][coreId].regionSettings;

            var tableStart;
            if (regionArray.length == 0) {
                tableStart = "\"<h5>" + deviceTitle + "</h5>\",\n" +
                    "\"No MPU region entries are programmed/enabled by " +
                    "default. The background region is used as the default " +
                    "memory map when the MPU is enabled.\",\n";
            }
            else {
                // This is the beginning of the HTML table. Write this out *once*
                // for each device
                var tableStart =
                  "\"<h5>" + deviceTitle + "</h5>\",\n" +
                  "\"<table border=1 cellpadding=3>\",\n" +
                  " \"<colgroup span=1></colgroup> <colgroup span=5 align=center></colgroup>\",\n" +
                  "   \"<tr><th> Mpu Region Id </th>" +
                  "<th> Base Address </th><th> Region Size </th>" +
                  "<th> Region Enabled </th><th> Bufferable </th>" +
                  "<th> Cacheable </th><th> Shareable </th><th> Tex </th>" +
                  "<th> NoExecute </th><th> AccessPermission </th>" +
                  "<th> SubregionDisableMask </th></tr>\",\n";
            }
            fos.write(tableStart);

            // cycle thru all regions
            for (var i = 0; i < regionArray.length; i++) {

                var regionId = regionArray[i].regionId;
                var baseAddress = "0x" + regionArray[i].baseAddress.toString(16);
                var enable = regionArray[i].enable;
                var bufferable = regionArray[i].bufferable;
                var cacheable = regionArray[i].cacheable;
                var shareable = regionArray[i].shareable;
                var noExecute = regionArray[i].noExecute;
                var tex = regionArray[i].tex;
                var subregionDisableMask = "0x" +
                    regionArray[i].subregionDisableMask.toString(16);

                var regionSize;
                var sizeIdx = (regionArray[i].regionSize >>> 1) + 1;

                if (sizeIdx < 32) {
                    regionSize = 1 << sizeIdx;
                    if ((regionSize / 1024) < 1) {
                        regionSize = Number(regionSize).toString(10) + " Bytes";
                    }
                    else if ((regionSize / (1024*1024)) < 1) {
                        regionSize = Number(regionSize / 1024).toString(10) + " KBytes";
                    }
                    else if ((regionSize / (1024*1024*1024)) < 1) {
                        regionSize = Number(regionSize / (1024*1024)).toString(10) +
                            " MBytes";
                    }
                    else {
                        regionSize =
                            Number(regionSize / (1024*1024*1024)).toString(10) + " GBytes";
                    }
                }
                else {
                    regionSize = "4 GBytes";
                }

                var accPerm;
                switch (regionArray[i].accPerm) {
                    case 0: accPerm = "No Access at any Privilege Level";
                            break;
                    case 1: accPerm = "Supervisor RW access";
                            break;
                    case 2: accPerm = "Supervisor RW and User R-only access";
                            break;
                    case 3: accPerm = "Supervisor and User RW access";
                            break;
                    case 4: accPerm = "Unpredictable";
                            break;
                    case 5: accPerm = "Supervisor R-only";
                            break;
                    case 6: accPerm = "Supervisor and User R-only access";
                            break;
                    case 7: accPerm = "Unpredictable";
                            break;
                    default:
                        accPerm = "Unpredictable";
                }

                // write out a row for each MPU region
                tableRows += "   \"<tr><td> " + regionId +
                    "        </td><td> " +
                    baseAddress +
                    "   </td><td> " +
                    // print address in hex
                    regionSize +
                    "         </td><td> " +
                    enable +
                    "         </td><td> " +
                    bufferable +
                    "         </td><td> " +
                    cacheable +
                    "         </td><td> " +
                    shareable +
                    "         </td><td> " +
                    tex +
                    "         </td><td> " +
                    noExecute +
                    "         </td><td> " +
                    accPerm +
                    "         </td><td> " +
                    subregionDisableMask +
                    "         </td></tr>\",\n";
            }

            // write out all of the rows we just generated for this device
            fos.write(tableRows);

            // reset the rows for the next device
            tableRows = "";

            if (regionArray.length != 0) {
                // This is the end of the HTML table. Write this out *once* for each
                // device
                var tableEnd = " \"</table>\",\n";
                // write out this device's table to the script file
                fos.write(tableEnd);
            }

        } // for (var coreId in deviceTable[device]) ...

        // now we're done with this device's table, loop on to the next
        // device

    } // for (var device in deviceTable) ...

    // write out the closing code of the script
    // insert comment as last array elem (in order to ensure last elem does not
    // have a "," as this causes the script to fail)
    var scriptEnd =
      "\"<!-- -->\"\n" +
      ");\n\n// gen below code only 1 time\nwhile (m_count < m_items.length) {\n\ \ \ \ document.write(m_items[m_count]);\n\ \ \ \ m_count++;\n}";
    fos.write(scriptEnd);

    // close the file, the script is complete
    fos.close();
}

/* ======== MAIN ======== */

/* This is the entry point */

/* Get the canonical path */
var path = arguments[0];
path = String(java.io.File(path).getCanonicalPath());

/* this flag is needed in order to access MPU.xs deviceTable */
var genCdoc = true;

/*
 * This variable must be defined or else the processing of MPU.xs will fail.
 */
var Program = {};
var cpu = {};
Program.cpu = cpu;

// load the Mpu.xs file.  All of the MPU region info comes from the
// deviceTable structure that's defined in this file:
var MpuXs = xdc.loadCapsule(path + "/MPU.xs");

// generate the HTML and javascript code based on region settings in deviceTable
createTable(MpuXs.deviceTable, path);
