if (!canDraw) return;
draw_self(); // If your object has a visual background or UI


var yy = topLeftY + 10 - scroll_offset;
var line_x = topLeftX + 10 + 5;

// Go through each line in the message list
for (var i = 0; i < array_length(message_list); i++) {
    var line = message_list[i];
    
    var scrib = scribble($"{string_trim(line)}")
            .align(fa_left, fa_top)
            .starting_format("VCR_OSD_Mono")
            .transform(textTransform, textTransform, 0)
            .wrap(sprite_width / textTransform - 20);
            
    scrib.draw(line_x + irandom_range(-burnoutNum, burnoutNum), yy + irandom_range(-burnoutNum, burnoutNum));
    
    //scribble_draw(line, line_x, yy);
    yy += line_heights[i] + padding;
}
