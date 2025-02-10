function SaveGame(){
    var _string = json_stringify(global.TimeStruct);
    var _file = file_text_open_write("save.json");
    file_text_write_string(_file, _string);
    file_text_close(_file);
}

function LoadGame()
{
    if (file_exists("save.json"))
    {
        var _file = file_text_open_read("save.json");
        var _json = file_text_read_string(_file);
        
        var _stuct = json_parse(_json);
        
        global.TimeStruct.realTime = _stuct.realTime;
        global.TimeStruct.realTimeNoMenu = _stuct.realTimeNoMenu;
        global.TimeStruct.won = _stuct.won;
    }
}