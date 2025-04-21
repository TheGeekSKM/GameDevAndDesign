global.WindowManager = id;

// min number of game instances (one based)
global.GAME_INSTANCE_MIN = 1;

global.saveLocation = working_directory;

// max number of game instances (one based)
global.GAME_INSTANCE_MAX = 20;
global.CHILD_PROCESS_ID_1 = 0;
global.CHILD_PROCESS_ID_2 = 0;
global.CHILD_PROCESS_ID_3 = 0;
global.CHILD_PROCESS_ID_4 = 0;
global.CHILD_PROCESS_ID_5 = 0;

// define game instance (zero based); increase one to game instance id environment and global variables
global.GAME_INSTANCE_ID = int64(bool(EnvironmentGetVariableExists("GAME_INSTANCE_ID")) ? EnvironmentGetVariable("GAME_INSTANCE_ID") : string(0));
EnvironmentSetVariable("GAME_INSTANCE_ID", string(global.GAME_INSTANCE_ID + 1));

if (global.GAME_INSTANCE_ID == 0) 
{ 
    // if parent processs of game instance 1
    // previous run file cleanup
    var dname = global.saveLocation + "proc/";
    
    if directory_exists(dname) directory_destroy(dname);
    directory_create(dname);
    
    if (file_exists(working_directory + "chatMessages.json")){
        file_delete(working_directory + "chatMessages.json")
    }
    
    if (file_exists(working_directory + "GameData.json")) {
        file_delete(working_directory + "GameData.json");
    }
    
    if (file_exists(working_directory + "TextDisplay.json")) {
        file_delete(working_directory + "TextDisplay.json");
    }
    
    global.GameData = {
        Name : "Undefined",
        GenreName : "Dark Fantasy RPG",
        PersonalSatisfactionModifier : 0,
        Interest : 0,
        MaxNumOfDays : irandom_range(10, 14),
        CurrentDay : 0,
        Quality : 0,
        Burnout : 0,
    }
    
    room_goto(rmMainMenu);
    
}

else if (global.GAME_INSTANCE_ID == 1)
{
    echo(global.GAME_INSTANCE_ID)
    room_goto(rmCredits);
    window_set_position((display_get_width() / 2), (display_get_height() / 2) - window_get_height());
}

else if (global.GAME_INSTANCE_ID == 2)
{
    room_goto(rmChat);
}

else if (global.GAME_INSTANCE_ID == 3)
{
    room_goto(rmTextDisplay);
}

else if (global.GAME_INSTANCE_ID == 4)
{
    global.GameData = {
        Name : "Undefined",
        GenreName : "Dark Fantasy RPG",
        PersonalSatisfactionModifier : 0,
        Interest : 0,
        MaxNumOfDays : irandom_range(10, 14),
        CurrentDay : 0,
        Quality : 0,
        Burnout : 0,
    }
    room_goto(rmGamePlanner);
}

else if (global.GAME_INSTANCE_ID == 5)
{
    room_goto(rmCommands);
}


function GameEnd()
{
    //if game instance has child
    if (global.GAME_INSTANCE_ID == 0) { // if parent process
        
        // global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        if (global.CHILD_PROCESS_ID_1 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_1)) 
        {
        
            // tell grandchild process the child process is going to die so grandchild can also die (see step event)
            var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_1) + ".tmp";
            var fd = file_text_open_write(fname);
            if (fd != -1) 
            {
                file_text_write_string(fd, "GAME_PROCESS_DIED");
                file_text_writeln(fd);
                file_text_close(fd);
            } 
            else 
            {
                show_error("ERROR: failed to open file for writing!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
            }
        }
        
        // global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        if (global.CHILD_PROCESS_ID_2 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_2)) 
        {
        
            // tell grandchild process the child process is going to die so grandchild can also die (see step event)
            var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_2) + ".tmp";
            var fd = file_text_open_write(fname);
            if (fd != -1) 
            {
                file_text_write_string(fd, "GAME_PROCESS_DIED");
                file_text_writeln(fd);
                file_text_close(fd);
            } 
            else 
            {
                show_error("ERROR: failed to open file for writing!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
            }
        }
        
        // global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        if (global.CHILD_PROCESS_ID_3 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_3)) 
        {
        
            // tell grandchild process the child process is going to die so grandchild can also die (see step event)
            var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_3) + ".tmp";
            var fd = file_text_open_write(fname);
            if (fd != -1) 
            {
                file_text_write_string(fd, "GAME_PROCESS_DIED");
                file_text_writeln(fd);
                file_text_close(fd);
            } 
            else 
            {
                show_error("ERROR: failed to open file for writing!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
            }
        }
        
        // global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        if (global.CHILD_PROCESS_ID_4 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_4)) 
        {
        
            // tell grandchild process the child process is going to die so grandchild can also die (see step event)
            var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_4) + ".tmp";
            var fd = file_text_open_write(fname);
            if (fd != -1) 
            {
                file_text_write_string(fd, "GAME_PROCESS_DIED");
                file_text_writeln(fd);
                file_text_close(fd);
            } 
            else 
            {
                show_error("ERROR: failed to open file for writing!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
            }
        }
        
        // global.CHILD_PROCESS_ID == 0 if not successfully executed and CompletionStatusFromExecutedProcess() == true if child is dead
        if (global.CHILD_PROCESS_ID_5 != 0 && !CompletionStatusFromExecutedProcess(global.CHILD_PROCESS_ID_5)) 
        {
        
            // tell grandchild process the child process is going to die so grandchild can also die (see step event)
            var fname = global.saveLocation + "proc/" + string(global.CHILD_PROCESS_ID_5) + ".tmp";
            var fd = file_text_open_write(fname);
            if (fd != -1) 
            {
                file_text_write_string(fd, "GAME_PROCESS_DIED");
                file_text_writeln(fd);
                file_text_close(fd);
            } 
            else 
            {
                show_error("ERROR: failed to open file for writing!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
            }
        }
    }
    
    // if game instance has parent
    else if (global.GAME_INSTANCE_ID > global.GAME_INSTANCE_MIN - 1) 
    { 
        // if child process
        var fname = global.saveLocation + "/proc/" + string(ProcIdFromSelf()) + ".tmp";
        var fd = file_text_open_write(fname);
        if (fd != -1) 
        {
            file_text_write_string(fd, "CHILD_PROCESS_DIED");
            file_text_writeln(fd);
            file_text_close(fd);
        } 
        else 
        {
            show_error("ERROR: failed to open file for writing!\n\nERROR DETAILS: Too many file descriptors opened by the current process or insufficient priviledges to access file!", true);
        }
    }
}
