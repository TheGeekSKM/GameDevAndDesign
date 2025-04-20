function CreateNewWindow(_id)
{
    if (global.GAME_INSTANCE_ID != 0) return;
    
    if (_id == 1) 
    { 
    
        if (global.CHILD_PROCESS_ID_1 != 0) return;
        global.CHILD_PROCESS_ID_1 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf())); // define child process id for later use
        
    } 
    
    else if (_id == 2) 
    { // if child process of game instance 0
        // duplicate current process by executing its own command line
        if (variable_global_exists("CHILD_PROCESS_ID_2")) return;
        global.CHILD_PROCESS_ID_2 = ExecProcessFromArgVAsync(GetArgVFromProcid(ProcIdFromSelf())); // define child process id for later use
        window_set_position((display_get_width() / 2) - window_get_width(), (display_get_height() / 2));
    } 
    
    else if (_id == global.GAME_INSTANCE_MAX - 1) 
    { // if child process of game instance 2
        if (variable_global_exists("CHILD_PROCESS_ID_3")) return;
        global.CHILD_PROCESS_ID_3 = ProcIdFromSelf(); // define child process id for later use
        window_set_position((display_get_width() / 2), (display_get_height() / 2));
    }
}