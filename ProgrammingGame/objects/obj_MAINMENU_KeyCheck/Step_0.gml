if (keyboard_check_released(ord("E"))) {
    CreateNewWindow(1);
    Transition(rmSetUp, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}
else if (keyboard_check_released(ord("Q"))) { 
    
    programmingResults = {
        PlayedGame : false
    };
    
    var jsonText = json_stringify(programmingResults, true);
    
    var tempPath = string_concat(global.FilePath, ".tmp")
    
    var file = file_text_open_write(tempPath);
    if (file != -1)
    {
        file_text_write_string(file, jsonText);
        file_text_close(file);

        if (file_exists(tempPath))
        {
            file_delete(global.FilePath); 
            file_rename(tempPath, global.FilePath); 
        }
    }
    
    
    game_end();
}