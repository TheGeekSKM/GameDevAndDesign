// min number of game instances (one based)
global.GAME_INSTANCE_MIN = 1;

global.saveLocation = working_directory;

// max number of game instances (one based)
global.GAME_INSTANCE_MAX = 4;
global.CHILD_PROCESS_ID_1 = 0;
global.CHILD_PROCESS_ID_2 = 0;
global.CHILD_PROCESS_ID_3 = 0;

// define game instance (zero based); increase one to game instance id environment and global variables
global.GAME_INSTANCE_ID = int64(bool(EnvironmentGetVariableExists("GAME_INSTANCE_ID")) ? EnvironmentGetVariable("GAME_INSTANCE_ID") : string(0));
EnvironmentSetVariable("GAME_INSTANCE_ID", string(global.GAME_INSTANCE_ID + 1));

if (global.GAME_INSTANCE_ID == 0) 
{ 
    // if parent processs of game instance 1
    // previous run file cleanup
    var dname = global.saveLocation + "proc/";
    
    if directory_exists(dname) 
    {
        directory_destroy(dname);
    }
    directory_create(dname);
    
    room_goto(rmMainMenu);
    
}

else if (global.GAME_INSTANCE_ID == 1)
{
    echo(global.GAME_INSTANCE_ID)
    room_goto(rmCredits);
    window_set_position((display_get_width() / 2), (display_get_height() / 2) - window_get_height());
}
