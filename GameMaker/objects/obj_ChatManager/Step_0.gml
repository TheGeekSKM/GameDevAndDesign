Read(); 


topLeftX = x - (sprite_width / 2);
topLeftY = y - (sprite_height / 2);

if (!point_in_rectangle(
        guiMouseX, guiMouseY, 
        x - (sprite_width / 2), y - (sprite_width / 2),  
        x + (sprite_width / 2), y + (sprite_width / 2)))
{
    return;
}

    
// Scroll with mouse wheel
var scroll_dir = mouse_wheel_up() - mouse_wheel_down();
__target_scroll_offset -= scroll_dir * (line_height + padding);

// Clamp to scrollable range
var content_height = array_length(message_list) * (line_height + padding);
__target_scroll_offset = clamp(__target_scroll_offset, 0, max(0, content_height - display_height));

// Smooth scroll
__scroll_offset = lerp(__scroll_offset, __target_scroll_offset, scroll_speed);

