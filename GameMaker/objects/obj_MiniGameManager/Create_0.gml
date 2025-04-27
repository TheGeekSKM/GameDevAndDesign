global.MiniGameManager = id;
global.programmingGameID = 0;
global.editingGameID = 0;
EnvironmentSetVariable("OWNER_WINDOW_ID", string(int64(window_handle())));

function LaunchProgrammingMinigame()
{
    if (os_type == os_windows) 
    {
        if (!global.programmingGameID) 
        {
            global.programmingGameID = ProcessExecuteAsync("\"" + working_directory + "programmingGame\\game.exe\"");
        }
    } 
    else if (os_type == os_linux) 
    {
        if (!file_exists(game_save_id + "game.AppImage")) 
        {
            file_copy(working_directory + "programmingGame/game.AppImage", game_save_id + "game.AppImage");
            var tmp = ProcessExecute("chmod u+x \"" + game_save_id + "game.AppImage\"");
            FreeExecutedProcessStandardInput(tmp);
            FreeExecutedProcessStandardOutput(tmp);
        }
        if (!global.programmingGameID) 
        {
            global.programmingGameID = ProcessExecuteAsync("\"" + game_save_id + "game.AppImage\"");
        }
    }
}

function LaunchEditingMinigame()
{
    if (os_type == os_windows) 
    {
        if (!global.editingGameID) 
        {
            global.editingGameID = ProcessExecuteAsync("\"" + working_directory + "editingGame\\game.exe\"");
        }
    } 
    else if (os_type == os_linux) 
    {
        if (!file_exists(game_save_id + "game.AppImage")) 
        {
            file_copy(working_directory + "editingGame/game.AppImage", game_save_id + "game.AppImage");
            var tmp = ProcessExecute("chmod u+x \"" + game_save_id + "game.AppImage\"");
            FreeExecutedProcessStandardInput(tmp);
            FreeExecutedProcessStandardOutput(tmp);
        }
        if (!global.editingGameID) 
        {
            global.editingGameID = ProcessExecuteAsync("\"" + game_save_id + "game.AppImage\"");
        }
    }
}