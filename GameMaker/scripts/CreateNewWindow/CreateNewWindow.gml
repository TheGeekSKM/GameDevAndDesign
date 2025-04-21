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
            if (global.CHILD_PROCESS_ID_3 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(3));
            global.CHILD_PROCESS_ID_3 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;
        
        case 4:
            if (global.CHILD_PROCESS_ID_3 != 0) return false;
            EnvironmentSetVariable("GAME_INSTANCE_ID", string(4));
            global.CHILD_PROCESS_ID_3 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf()));
            break;
    }

    // Reset the GAME_INSTANCE_ID so future spawns default to 0 + 1 logic again
    EnvironmentSetVariable("GAME_INSTANCE_ID", string(global.GAME_INSTANCE_ID));
    return true;
}

function OpenTextDisplay(_title, _text)
{
    if (global.GAME_INSTANCE_ID != 0) return false; // Only allow parent to create

    var textDisplay = {
        "title": _title,
        "text": string_trim(_text)
    }

    var textJSON = json_stringify(textDisplay);

    SafeWriteJson(working_directory + "TextDisplay.json", textJSON);

    CreateNewWindow(3);
}


function OpenGamePlanner()
{
    CreateNewWindow(4)
}