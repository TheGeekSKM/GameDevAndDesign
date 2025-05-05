global.MiniGameManager = id;
function LaunchProgrammingMinigame()
{
    
    //if (os_type == os_windows) 
    //{
        //if (!global.programmingGameID) 
        //{
            //global.programmingGameID = ProcessExecuteAsync("\"" + working_directory + "programmingGame\\game.exe\"");
        //}
    //} 
    //else if (os_type == os_linux) 
    //{
        //if (!file_exists(game_save_id + "game.AppImage")) 
        //{
            //file_copy(working_directory + "programmingGame/game.AppImage", game_save_id + "game.AppImage");
            //var tmp = ProcessExecute("chmod u+x \"" + game_save_id + "game.AppImage\"");
            //FreeExecutedProcessStandardInput(tmp);
            //FreeExecutedProcessStandardOutput(tmp);
        //}
        //if (!global.programmingGameID) 
        //{
            //global.programmingGameID = ProcessExecuteAsync("\"" + game_save_id + "game.AppImage\"");
        //}
    //}
    
    CreateNewWindow(6);
}

function LaunchEditingMinigame()
{
    // if (os_type == os_windows) 
    // {
    //     if (!global.editingGameID) 
    //     {
    //         global.editingGameID = ProcessExecuteAsync("\"" + working_directory + "editingGame\\game.exe\"");
    //     }
    // } 
    // else if (os_type == os_linux) 
    // {
    //     if (!file_exists(game_save_id + "game.AppImage")) 
    //     {
    //         file_copy(working_directory + "editingGame/game.AppImage", game_save_id + "game.AppImage");
    //         var tmp = ProcessExecute("chmod u+x \"" + game_save_id + "game.AppImage\"");
    //         FreeExecutedProcessStandardInput(tmp);
    //         FreeExecutedProcessStandardOutput(tmp);
    //     }
    //     if (!global.editingGameID) 
    //     {
    //         global.editingGameID = ProcessExecuteAsync("\"" + game_save_id + "game.AppImage\"");
    //     }
    // }
    CreateNewWindow(8);
}

function ProgrammingGameEnded()
{
    global.CHILD_PROCESS_ID_6 = 0;
    
    var data = SafeReadJson(game_save_id + "ProgrammingResults.json")
    if (data != undefined)
    {
        if (data.PlayedGame)
        {
            if (!variable_global_exists("GameData") || global.GameData[$ "Quality"] == undefined) 
            {
                global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You spent hours working on a prototype, but because you didn't plan for a game, the prototype didn't pan out and was abandoned...");
                return;
            }
            
            var quality = data.Score + random_range(5, 7);
            global.GameData.Quality += quality;
            
            var burnout = round(quality / 15);
            global.GameData.Burnout += min(burnout, 1);
            Raise("BurnoutModified", global.GameData.Burnout);
    
            global.GameData.CurrentDay++;
            if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
            {
                Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
            }
            
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a lot of progress in 8hrs, despite the tremendous lack of prebuilt systems! Check your log to see updates! Don't forget to Devlog!!");
        }
        else 
        {
            if (!variable_global_exists("GameData") || global.GameData[$ "Quality"] == undefined) 
            {
                global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You spent hours working on a prototype, but because you didn't plan for a game, the prototype didn't pan out and was abandoned...");
                return;
            }
            
            var quality = random_range(5, 7);
            global.GameData.Quality += quality;
            
            var burnout = round(quality / 15);
            global.GameData.Burnout += min(burnout, 1);
            Raise("BurnoutModified", global.GameData.Burnout);
    
            global.GameData.CurrentDay++;
            if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
            {
                Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
            }
            
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made little progress in 8hrs, because of the tremendous lack of prebuilt systems! Check your log to see updates! Don't forget to Devlog!!");
        }
    }
    else 
    {
        show_message("DATA UNDEFINED")
    }
}

function EditingGameEnded()
{
    global.CHILD_PROCESS_ID_8 = 0;
    
    var data = SafeReadJson(global.EditingFilePath)
    if (data != undefined)
    {
        if (data.PlayedGame)
        {
            if (!variable_global_exists("GameData") || global.GameData[$ "Quality"] == undefined)
            {
                global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You spent hours setting up OBS with graphics and transitions before realizing that you had no content to record...");
            }
            
            var quality = TimeToScore(data.Score);
            global.GameData.Interest += quality;
            
            var burnout = round(quality / 15);
            global.GameData.Burnout += min(burnout, 1);
            Raise("BurnoutModified", global.GameData.Burnout);
    
            global.GameData.CurrentDay++;
            if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
            {
                Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
            }
            
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a lot of progress in 8hrs! Your devlog got {global.GameData.Interest} views!! Check your log to see updates! Don't forget to Code!!");
        }
        else 
        {
            if (!variable_global_exists("GameData") || global.GameData[$ "Quality"] == undefined)
            {
                global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You spent hours setting up OBS with graphics and transitions before realizing that you had no content to record...");
            }
            
            var quality = random_range(5, 7);
            global.GameData.Interest += quality;
            
            var burnout = round(quality / 15);
            global.GameData.Burnout += min(burnout, 1);
            Raise("BurnoutModified", global.GameData.Burnout);
    
            global.GameData.CurrentDay++;
            if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
            {
                Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
            }
            
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a little bit of progress in 8hrs! Your devlog only got {global.GameData.Interest} views!! Check your log to see updates! Don't forget to Code!!");;
        }
    }
    else 
    {
        show_message("DATA UNDEFINED")
    }
}