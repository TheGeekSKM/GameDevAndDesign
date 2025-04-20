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