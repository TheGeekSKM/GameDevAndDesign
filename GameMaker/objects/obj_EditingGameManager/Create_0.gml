corruptedSlideCount = 0;
Subscribe("AddCorruptedSlide", function(_id) {
    corruptedSlideCount++;
})

Subscribe("ClearCorruptedSlide", function(_id) {
    corruptedSlideCount--;
    
    if (corruptedSlideCount <= 0)
    {
        var editingResults = {
            PlayedGame : true,
            Score : obj_PlatformingPlayer.timePlaying / game_get_speed(gamespeed_fps)
        }
        
        var jsonString = json_stringify(editingResults);
        SafeWriteJson(global.EditingFilePath, jsonString);
        
        Transition(rmEditingEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    }
})
