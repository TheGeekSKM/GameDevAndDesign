if (keyboard_check_released(ord("E")))
{
    // play
    Transition(rmEditingGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}

if (keyboard_check_released(ord("Q")))
{
    var editingResults = {
        PlayedGame : false
    };

    var jsonText = json_stringify(editingResults, true);
    SafeWriteJson(global.EditingFilePath, jsonText);

    game_end();
}