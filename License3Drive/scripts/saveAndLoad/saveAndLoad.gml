function SaveGame(){
    if (global.TimeStruct.timeNoMenu < global.OldTimeStruct.timeNoMenu or !file_exists("save.json"))
    {
    
        var _string = json_stringify(global.TimeStruct);
        var _file = file_text_open_write("save.json");
        file_text_write_string(_file, _string);
        file_text_close(_file);
    }
}

function LoadGame()
{
    global.OldTimeStruct = { 
        time: 0, 
        timeNoMenu : 0, 
        won : false
    }
    
    if (file_exists("save.json"))
    {
        var _file = file_text_open_read("save.json");
        var _json = file_text_read_string(_file);
        
        var _stuct = json_parse(_json);
        
        global.OldTimeStruct.time = _stuct.time;
        global.OldTimeStruct.timeNoMenu = _stuct.timeNoMenu;
        global.OldTimeStruct.won = _stuct.won;
    }
}
