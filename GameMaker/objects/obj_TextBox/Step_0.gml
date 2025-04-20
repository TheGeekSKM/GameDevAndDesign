// Calculate top-left corner
topLeftX = x - (sprite_width / 2);
topLeftY = y - (sprite_height / 2);

// Check if mouse is over the text box
if (!point_in_rectangle(guiMouseX, guiMouseY, topLeftX, topLeftY, topLeftX + display_width, topLeftY + display_height)) {
    return;
}

// Scroll one "line" per wheel tick
var scroll_dir = mouse_wheel_up() - mouse_wheel_down();
var scroll_step = 32; // Can also use average line height if preferred
target_scroll_offset -= scroll_dir * scroll_step;

// Calculate proper total content height
var content_height = __getTotalLineHeight() + ((array_length(line_heights) - 1) * padding);
target_scroll_offset = clamp(target_scroll_offset, 0, max(0, content_height - display_height));

// Smooth scroll
scroll_offset = lerp(scroll_offset, target_scroll_offset, scroll_speed);
