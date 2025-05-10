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
var part1 = "[c_yellow]Welcome![/c] Feel free to type commands to get started or use [c_player][wave]\"help\"[/]."
var part2 = "[c_lime]REMINDER:[/c] You previously created file: \"ToDoList.txt\" in your V Drive. Due to Persistency Settings, the file was saved and now loaded. \nUse [c_player][wave]\"start todolist.txt\"[/] to access the file!"

OpenTextDisplay("Starting Notes:", string_concat(part1,"\n\n", part2));

AddMessage("[c_player]NOTE:[/] Please do not hesitate to use the [c_gold][wave]\"help\"[/] command to open the Command Help Window!")
