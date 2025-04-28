// if the game is a programming game, check if the completion status is set to true
if (global.programmingGameID && CompletionStatusFromExecutedProcess(global.programmingGameID))
{
    FreeExecutedProcessStandardInput(global.programmingGameID);
    FreeExecutedProcessStandardOutput(global.programmingGameID);
    global.programmingGameID = 0;
    
    var data = SafeReadJson(game_save_id + "ProgrammingResults.json")
    if (data != undefined)
    {
        if (data.PlayedGame)
        {
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
        else {
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

    // Read score from working_directory + "ProgrammingGame.json"
}


// if the game is an editing game, check if the completion status is set to true
if (global.editingGameID && CompletionStatusFromExecutedProcess(global.editingGameID))
{
    FreeExecutedProcessStandardInput(global.editingGameID);
    FreeExecutedProcessStandardOutput(global.editingGameID);
    global.editingGameID = 0;

    // Read score from working_directory + "EditingGame.json"
    show_message($"TODO: Read score from \"{working_directory}EditingGame.json\"");
}