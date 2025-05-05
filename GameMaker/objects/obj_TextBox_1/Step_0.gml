// Calculate top-left corner
var scroll_dir = 0;



// Scroll input only when mouse is over the box
if (point_in_rectangle(guiMouseX, guiMouseY, x, y, x + sprite_width, y + sprite_height)) {
    
    // Scroll one "step" per wheel tick
    scroll_dir = mouse_wheel_up() - mouse_wheel_down();
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) scroll_dir += 0.5;
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) scroll_dir += -0.5;
    var scroll_step = 32;
    target_scroll_offset -= scroll_dir * scroll_step;
}

// Calculate total scrollable content height properly
var content_height = __getTotalLineHeight() + (array_length(line_heights) - 1) * padding;

// Prevent overscroll: clamp so last line ends at the bottom
max_scroll = max(0, content_height - display_height);
target_scroll_offset = clamp(target_scroll_offset, 0, max_scroll);

// Clamp scroll again for safety
scroll_offset = clamp(scroll_offset, 0, max_scroll);

// Smooth scroll
scroll_offset = lerp(scroll_offset, target_scroll_offset, scroll_speed);

// Check if we're near top or bottom
atTop = (scroll_offset <= 1);
atBottom = (abs(scroll_offset - max_scroll) <= 1);
