if (keyboard_check_released(ord("E"))) {
    
    if (os_is_network_connected())
    {
        url_open("https://saimangipudi.dev/documentation")
    }
    else {
        url_open("Pages/documentation.html")
    }
    
    Transition(rmSetUp, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}
else if (keyboard_check_released(ord("Q"))) { 
    
    programmingResults = {
        PlayedGame : false
    };
    
    var jsonText = json_stringify(programmingResults, true);
    
    var tempPath = string_concat(global.ProgrammingFilePath, ".tmp")
    
    var file = file_text_open_write(tempPath);
    if (file != -1)
    {
        file_text_write_string(file, jsonText);
        file_text_close(file);

        if (file_exists(tempPath))
        {
            file_delete(global.ProgrammingFilePath); 
            file_rename(tempPath, global.ProgrammingFilePath); 
        }
    }
    
    
    game_end();
}