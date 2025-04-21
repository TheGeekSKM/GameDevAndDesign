// Inherit the parent event
event_inherited();

global.MainTextBox = id;

function ClearBox()
{
    message_list = [];
    line_heights = [];
    scroll_offset = 0;
    target_scroll_offset = 0;
    scroll_speed = 0.2;
    
    AddMessage("Cleared Text Stream")
}

AddMessage("[c_yellow]Welcome![/c] Feel free to type commands to get started or use \"help()\".")
AddMessage("[c_lime]REMINDER:[/c] You previously created file: \"ToDoList.txt\" in your V Drive. Due to Persistency Settings, the file was saved and now loaded. Use \"open(ToDoList.txt)\" to access the file!")