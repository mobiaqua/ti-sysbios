/**
 * @main.js - This script mimics Texas Instruments' load6x stand-alone
 * simulator base functionality but will work with any TI target (HW or
 * Simulator) that is supported by Debug Server Scripting.
 */

// Run loadti.
testEnv = {};
var debugServer = null;
var isDebugServer = false;

run();

/**
 * Send message to the console and log (if logging is enabled)
 * @param {String} The string to output to the console/log.
 */
function printTrace(string)
{
    if (!testEnv.quietMode) {
        dssScriptEnv.traceWrite(string);
    }
}

/**
 * Get error code from the given exception.
 * @param {exception} The exception from which to get the error code.
 */
function getErrorCode(exception)
{
    var ex2 = exception.javaException;
    if (ex2 instanceof
        Packages.com.ti.ccstudio.scripting.environment.ScriptingException) {
        return ex2.getErrorID();
    }
    return 0;
}

function configureDebugServer(config, dssScriptEnv)
{
    errCode = 0;
    debugServer = dssScriptEnv.getServer("DebugServer.1");
    isDebugServer = true;

    // Do DSS Linux XPCOM specific setup.
    try {
        debugServer.setConfig(config);
    }
    catch (ex) {
        errCode = getErrorCode(ex);
        dssScriptEnv.traceWrite("Error code #" + errCode
            + ", could not import configuration " + config + "\nAborting!");
    }
    return errCode;
}

/**
 * Get arguments from command-line.
 */
function getArgs()
{
    var argCt = 0;
    var argvNum = 1;

    arguments = this.arguments;

    testEnv.timeoutValue = -1;   // set default script timeout to infinite

    testEnv.initBss = false;
    testEnv.initBssValue = 0;

    testEnv.asyncRun = false;
    testEnv.onlyLoad = false;
    testEnv.quietMode = false;
    testEnv.resetTarget = false;
    testEnv.verboseMode = false;

    testEnv.cioFile = null;
    testEnv.dssPath = "";
    testEnv.loadtiPath = "";
    testEnv.loadDat = [];
    testEnv.loadRaw = [];
    testEnv.noProfile = false;
    testEnv.logFile = null;
    testEnv.outFiles = null;
    testEnv.saveDat = [];
    testEnv.saveRaw = [];
    testEnv.setupCfgFile = null;

    // pull all the ARGV arguments off command line
    testEnv.argvArgs = [];

    // Split arguments containing '=' into multiple arguments. This is needed because on Windows the arguments array
    // is already broken up in this manner, but on Linux it is not.
    var args2 = [];
    for (var i = 0; i < arguments.length; ++i) {
        splitArgs = arguments[i].split("=");
        args2 = args2.concat(splitArgs);
    }
    arguments = args2;

        // If any option files have been provided, then parse and insert their contents into "arguments".
        for (var i = 0; i < arguments.length; ++i) {
                if (arguments[i] == "-@" || arguments[i] == "--options-file" || arguments[i] == "--options_file")
                {
                        // Open the options file.
                        var fr = new java.io.FileReader(arguments[i+1]);
                        var reader = new java.io.BufferedReader(fr);

                        // Remove the option file argument from "arguments"
                        arguments.splice(i, 2);

                        // Create and setup the parser.
                        var st = new java.io.StreamTokenizer(reader);
                        st.ordinaryChars(33, 33); // "!"
                        st.wordChars(33, 33);
                        st.ordinaryChars(35, 38); // "#" -> "&"
                        st.wordChars(35, 38);
                        st.ordinaryChars(40, 60); // "(" -> "<"
                        st.wordChars(40, 60);
                        st.ordinaryChars(62, 64); // ">" -> "@"
                        st.wordChars(62, 64);
                        st.ordinaryChars(91, 96); // "[" -> "`"
                        st.wordChars(91, 96);
                        st.ordinaryChars(123, 126); // "{" -> "~"
                        st.wordChars(123, 126);

                        // Parse and insert the option file's contents into "arguments".
                        var ttype;
                        var j = i;
                        while ((ttype = st.nextToken()) != java.io.StreamTokenizer.TT_EOF)
                        {
                                if (ttype == java.io.StreamTokenizer.TT_WORD || ttype == 34 || ttype == 39)
                                {
                                        var s = st.sval;
                                        arguments.splice(j++, 0, s);
                                }
                        }

                        reader.close();
                        --i;
                }
        }

    // Parse arguments passed to script.
        while (argCt < arguments.length)
        {
                // if an option, get the option
                if (arguments[argCt].match(/^-(.*)/))
                {
                        ++argCt;

                        switch(RegExp.$1)
                        {
                                case "a":
                                case "-async-run":
                                case "-async_run":
                                        testEnv.asyncRun = true;
                                        break;
                                case "b":
                                case "-init-bss-section":
                                case "-init_bss_section":
                                        testEnv.initBss = true;
                                        if (argCt != arguments.length)
                                        {
                                                var n = parseInt(arguments[argCt]);
                                                if (isFinite(n))
                                                {
                                                        testEnv.initBssValue = n;
                                                        ++argCt;
                                                }
                                        }
                                        break;
                                case "c":
                                case "-cfg-file":
                                case "-cfg_file":
                                        if (argCt == arguments.length || arguments[argCt].substr(0, 1) == "-")
                                        {
                                                throw new Error("Invalid use of option `" + arguments[argCt-1] + "', argument expected");
                                        }
                                        testEnv.setupCfgFile = arguments[argCt++];
                                        break;
                                case "f":
                                case "-fileio":
                                        if (argCt == arguments.length || arguments[argCt].substr(0, 1) == "-")
                                        {
                                                throw new Error("Invalid use of option `" + arguments[argCt-1] + "', argument expected");
                                        }
                                        testEnv.fileIOFolder = arguments[argCt++];
                                        break;
                                case "n":
                                case "-no-profile":
                                case "-no_profile":
                    testEnv.noProfile = true;
                    break;
                                case "o":
                                case "-out-file":
                                case "-out_file":
                                case "-out-files":
                                case "-out_files":
                                        if (argCt == arguments.length || arguments[argCt].substr(0, 1) == "-")
                                        {
                                                exitWithArgError("Invalid use of option `" + arguments[argCt-1] + "', argument expected");
                                        }
                                        testEnv.outFiles = arguments[argCt++];
                    break;
                                case "q":
                                case "-quiet":
                                        testEnv.quietMode = true;
                                        break;
                                case "r":
                                case "-reset":
                                        testEnv.resetTarget = true;
                                        break;
                                case "s":
                                case "-stdout-file":
                                case "-stdout_file":
                                        if (argCt == arguments.length || arguments[argCt].substr(0, 1) == "-")
                                        {
                                                exitWithArgError("Invalid use of option `" + arguments[argCt-1] + "', argument expected");
                                        }
                                        testEnv.cioFile = arguments[argCt++];
                                        break;
                                case "t":
                                case "-timeout":
                                        if (argCt == arguments.length || arguments[argCt].substr(0, 1) == "-")
                                        {
                                                exitWithArgError("Invalid use of option `" + arguments[argCt-1] + "', argument expected");
                                        }
                                        testEnv.timeoutValue = parseInt(arguments[argCt++]);
                                        break;
                                case "v":
                                case "-verbose":
                                        testEnv.verboseMode = true;
                                        break;
                                case "x":
                                case "-xml-log":
                                case "-xml_log":
                                        if (argCt == arguments.length || arguments[argCt].substr(0, 1) == "-")
                                        {
                                                exitWithArgError("Invalid use of option `" + arguments[argCt-1] + "', argument expected");
                                        }
                                        testEnv.logFile = arguments[argCt++];
                                        break;
                                default:
                                        throw new Error("Unrecognized option `" + arguments[argCt-1] + "'");
                                        break;
                        }
                }
                else
                {
                        // it is the outfile list, and all arguments that follow it are arguments to be passed to main

                        testEnv.outFiles = arguments[argCt++];

                        while (argCt < arguments.length)
                        {
                                testEnv.argvArgs[argvNum++] = arguments[argCt++];
                        }

                        break;
                }
        }
}



/**
 * This function is called to perform some clean up before exiting (or
 * aborting) the script. It assumes that the the scripting environment and
 * debug and profile servers have been created.
 */
function quit(retVal)
{

    if (isDebugSession) {
        // Close debug session.
        debugSession.terminate();
    }

    if (isDebugServer) {
        debugServer.stop();
    }

    date = new Date();
    printTrace("\nEND: " + date.toTimeString());

    if (testEnv.logFile != null) {
        // Close log.
        dssScriptEnv.traceEnd();
    }

    delete testEnv;

    // Terminate JVM and return main return value.
    java.lang.System.exit(retVal);
}

/*
 * Main function.
 */
function run()
{
    var inst;

    var errCode = 0;
    var retVal = 0;
    var date = 0;
    var defaultTimeout = -1;

    isDebugServer = false;
    isDebugSession = false;

    //print(java.lang.System.getProperty("user.dir"));
    getArgs();

    // Create base scripting environment.
    dssScriptEnv = Packages.com.ti.ccstudio.scripting.environment.ScriptingEnvironment.instance();

    // Set overall script timeout value.
    dssScriptEnv.setScriptTimeout(defaultTimeout);

    // Set console verbosity.
    if (testEnv.verboseMode) {
        dssScriptEnv.traceSetConsoleLevel(Packages.com.ti.ccstudio.scripting.environment.TraceLevel.ALL);
    }

    printTrace("\n***** DSS Generic Loader *****\n");

    date = new Date();
    printTrace("START: " + date.toTimeString() + "\n");

    // Configure the Debug Server.
    if (testEnv.setupCfgFile != null)
    {
        printTrace("Configuring Debug Server for specified target...");

        //load(java.lang.System.getenv("LOADTI_PATH") + "/dsSetup.js");
        //load("./dsSetup.js");

        errCode = configureDebugServer(testEnv.setupCfgFile, dssScriptEnv);
        if (errCode != 0)
        {
            quit(errCode);
        }

        printTrace("Done");

        // There's no more to do if no outfiles have been provided.
        if (testEnv.outFiles == null) {
            quit(0);
        }
    }
    else {
        if (java.lang.System.getProperty("os.name").contains("Linux"))
        {
            dssScriptEnv.traceWrite("No target setup configuration file specified. Aborting!");
            quit(1);
        }

        printTrace("No target setup configuration file specified. Using existing setup");
    }

    // Open Debug Server session.
    if (!isDebugServer)
    {
        debugServer = dssScriptEnv.getServer("DebugServer.1");
        isDebugServer = true;
    }

    debugSession = debugServer.openSession("*", "*");
    isDebugSession = true;

    //Set the default File IO folder
    debugSession.options.setString(
        "FileIODefaultDirectory", testEnv.fileIOFolder);

    printTrace("TARGET: " + debugSession.getBoardName());

    printTrace("Connecting to target...");

    // Connect to target. If target is simulator or already connected, a warning will be reported.
    try {
        debugSession.target.connect();
    }
    catch (ex) {
        errCode = getErrorCode(ex);
        dssScriptEnv.traceWrite("Error code #" + errCode + ", could not connect to target!\nAborting!");
        quit(errCode != 0 ? errCode : 1);
    }

    if (testEnv.resetTarget)
    {
        printTrace("Resetting target...");

        // Reset target.
        try {
            debugSession.target.reset();
        }
        catch (ex) {
            errCode = getErrorCode(ex);
            dssScriptEnv.traceWrite("Error code #" + errCode + ", could reset target!\nAborting!");
            quit(errCode != 0 ? errCode : 1);
        }
    }

    // Load and run each program provided.
    //java.lang.System.out.println("testEnv.outFiles: " + testEnv.outFiles);
    var st = new java.util.StringTokenizer(testEnv.outFiles, "+");
    while (st.hasMoreTokens()) {
        var outFile = st.nextToken();

        var filePath = new java.io.File(outFile);
        var outFileName = filePath.getName();
        testEnv.argvArgs[0] = outFileName;

        printTrace("Loading " + outFile);

        // Load program and pass arguments to main (if applicable).
        try {
            if (testEnv.initBss) {
                debugSession.memory.setBssInitValue(testEnv.initBssValue);
            }

            if (testEnv.argvArgs.length < 2) {
                debugSession.memory.loadProgram(outFile);
            }
            else {
                debugSession.memory.loadProgram(outFile, testEnv.argvArgs);
            }
        }
        catch (ex) {
            errCode = getErrorCode(ex);
            printTrace("Error code #" + errCode + ", " + outFile + " load failed!\nAborting!");
            quit(errCode != 0 ? errCode : 1);
        }

        printTrace("Done");

        if (!testEnv.onlyLoad) {
            printTrace("Target running...");

            // Set script timeout value for run API.
            dssScriptEnv.setScriptTimeout(testEnv.timeoutValue);

            if (testEnv.cioFile != null) {
                // Begin CIO logging.
                debugSession.beginCIOLogging(testEnv.cioFile);
            }

            // Run to end of program (or timeout) and return total cycles unless asynch run.
            try {
                /* Is the target already at the end of the program? If so, do
                 * not try to run again.
                 * Note: we need to check the existance of the symbol first,
                 * since the evaluate function does not, and will return errors
                 * if the symbol does not exist, causing the script to exit.
                 * Note: This check is to fix the following use case: if the
                 * debugger is configured to Auto Run to a label after program
                 * load but that label is not hit then the loadti script may
                 * cause the program to enter an infinite loop.
                 */
                if ( ( debugSession.symbol.exists("C$$EXIT") &&
                       debugSession.expression.evaluate( "PC == C$$EXIT" ) ) ||
                     ( debugSession.symbol.exists("C$$EXITE") &&
                       debugSession.expression.evaluate( "PC == C$$EXITE") ) ||
                     ( debugSession.symbol.exists("abort") &&
                       debugSession.expression.evaluate( "PC == abort") ) ) {
                    printTrace( "Target failed to run to desired user label after program load, and is at end of program.  Script execution aborted." );
                }
                else {
                    // continue with running the program
                    if (!testEnv.asyncRun) {
                        printTrace("Interrupt to abort . . .");

                        if (!testEnv.noProfile) {
                            var cycles = debugSession.clock.runBenchmark();
                        }
                        else {
                            debugSession.target.run();
                        }
                    }
                    else {
                        debugSession.target.runAsynch();
                    }
                }
            }
            catch (ex) {
                errCode = getErrorCode(ex);
                if (errCode == 1001) {
                    printTrace(">> OVERALL TIMED OUT");
                    debugSession.target.halt();
                }
                else {
                    dssScriptEnv.traceWrite("Error code #" + errCode +
                        ", error encountered during program execution!\nAborting!");
                    quit(errCode != 0 ? errCode : 1);
                }
            }

            if (testEnv.cioFile != null && !testEnv.asyncRun) {
                // Stop CIO logging.
                debugSession.endCIOLogging();
            }

            // Set script timeout value to default.
            dssScriptEnv.setScriptTimeout(defaultTimeout);

            if (!testEnv.asyncRun && !testEnv.noProfile) {
                // Print cycle counts unless script timout occurred on program execution.
                if (errCode != 1001) {
                    printTrace("NORMAL COMPLETION: " + cycles + " cycles");
                }
            }
        }
    }
    // End automation.
    quit(retVal);
}
