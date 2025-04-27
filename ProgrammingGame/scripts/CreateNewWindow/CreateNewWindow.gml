function CreateNewWindow(_id)
{
    if (global.GAME_INSTANCE_ID != 0) return false; // Only allow parent to create
    
    // Prevent duplicate launch
    switch (_id) {
        case 1:
            if (global.CHILD_PROCESS_ID_1 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(1)); // Force instance ID
            global.CHILD_PROCESS_ID_1 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;

        case 2:
            if (global.CHILD_PROCESS_ID_2 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(2));
            global.CHILD_PROCESS_ID_2 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;

        case 3:
            //if (global.CHILD_PROCESS_ID_3 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(3));
            global.CHILD_PROCESS_ID_3 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;
        
        case 4:
            if (global.CHILD_PROCESS_ID_4 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(4));
            global.CHILD_PROCESS_ID_4 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;
        
        case 5:
            if (global.CHILD_PROCESS_ID_5 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(5));
            global.CHILD_PROCESS_ID_5 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;
    }

    // Reset the GAME_INSTANCE_ID so future spawns default to 0 + 1 logic again
    EnvironmentSetVariable("GAME_INSTANCE_ID", string(global.GAME_INSTANCE_ID));
    return true;
}

function GetArgVFromProcid(proc_id) {
var kinfo_proc, kinfo_argv;
kinfo_proc = ProcInfoFromProcIdEx(proc_id, KINFO_EXEP | KINFO_ARGV);
kinfo_argv[0] = ExecutableImageFilePath(kinfo_proc);
if (CommandLineLength(kinfo_proc) >= 2) {
    for (var i = 1; i < CommandLineLength(kinfo_proc); i++) {
    kinfo_argv[i] = CommandLine(kinfo_proc, i);
    }
}
FreeProcInfo(kinfo_proc);
return kinfo_argv;
}

function ExecProcessFromArgVAsync(kinfo_argv) {
var cmdline = "";
for (var i = 0; i < array_length(kinfo_argv); i++) {
    var tmp = string_replace_all(kinfo_argv[i], "\\", "\\\\");
    tmp = "\"" + string_replace_all(tmp, "\"", "\\\"") + "\"";
    if (i < array_length(kinfo_argv) - 1) tmp += " ";
    cmdline += tmp;
}
return ProcessExecuteAsync(cmdline);
}
