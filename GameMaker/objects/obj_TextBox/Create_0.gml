// Configuration
display_width = sprite_width;
display_height = sprite_height;
padding = 5;
line_height = 20;
font_used = VCR_OSD_Mono; // Optional: assign a font here
text_color = c_white;

topLeftX = 0;
topLeftY = 0;

// State
message_list = [];
scroll_offset = 0;
target_scroll_offset = 0;
scroll_speed = 0.2;

function AddMessage(_msg) {
    array_push(message_list, _msg);
    
    var scribbleStruct = scribble($"> {_msg}")
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono")
        .transform(0.75, 0.75, 0)
        .wrap(780 * 1.333)
    
    line_height = scribbleStruct.get_height();
    
    var total_height = array_length(message_list) * (line_height + padding);
    if (total_height > display_height) {
        var overflow = total_height - display_height;
        target_scroll_offset = overflow;
    }
}

function ClearBox()
{
    message_list = [];
    scroll_offset = 0;
    target_scroll_offset = 0;
    scroll_speed = 0.2;
}