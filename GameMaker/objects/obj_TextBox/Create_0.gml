// Configuration
display_width = sprite_width;
display_height = sprite_height;
padding = 5;
font_used = VCR_OSD_Mono; // Optional: assign a font here
text_color = c_white;

topLeftX = 0;
topLeftY = 0;

// State
message_list = [];
line_heights = [];
scroll_offset = 0;
target_scroll_offset = 0;
scroll_speed = 0.2;

function __getTotalLineHeight()
{
    var result = 0;
    for (var i = 0; i < array_length(line_heights); i++)
    {
        result += line_heights[i];
    }
    
    return result;
}

function AddMessage(_msg) {
    array_push(message_list, _msg);

    var scribbleStruct = scribble($"{_msg}")
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono")
        .transform(0.75, 0.75, 0)
        .wrap(sprite_width * 1.333);

    var lineHeight = scribbleStruct.get_height();
    array_push(line_heights, lineHeight);

    var total_height = __getTotalLineHeight() + ((array_length(line_heights) - 1) * padding);
    target_scroll_offset = max(0, total_height - display_height);
}


function ClearBox()
{
    message_list = [];
    scroll_offset = 0;
    target_scroll_offset = 0;
    scroll_speed = 0.2;
}