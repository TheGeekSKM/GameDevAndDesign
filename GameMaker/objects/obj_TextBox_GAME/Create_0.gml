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
    
}
var part1 = "[c_yellow]Welcome![/c] Feel free to type commands to get started or use \"help()\"."
var part2 = "[c_lime]REMINDER:[/c] You previously created file: \"ToDoList.txt\" in your V Drive. Due to Persistency Settings, the file was saved and now loaded. Use \"open(ToDoList.txt)\" to access the file!"

OpenTextDisplay("Starting Notes:", string_concat(part1,"\n\n", part2));
