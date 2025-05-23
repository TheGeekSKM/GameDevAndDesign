
// Calculate top-left corner
topLeftX = x - (sprite_width / 2);
topLeftY = y - (sprite_height / 2);

var shiftHeld = keyboard_check(vk_lshift);


// Scroll input only when mouse is over the box
if (point_in_rectangle(guiMouseX, guiMouseY, topLeftX, topLeftY, topLeftX + sprite_width, topLeftY + sprite_height)) {
    
    // Scroll one "step" per wheel tick
    var scroll_dir = mouse_wheel_up() - mouse_wheel_down();
    scroll_dir += (shiftHeld && keyboard_check_pressed(vk_up)) - (shiftHeld && keyboard_check_pressed(vk_down)) * 2;
    var scroll_step = 32;
    target_scroll_offset -= scroll_dir * scroll_step;
}

// Calculate total scrollable content height properly
var content_height = __getTotalLineHeight() + (array_length(line_heights) - 1) * padding;

// Prevent overscroll: clamp so last line ends at the bottom
var max_scroll = max(0, content_height - display_height);
target_scroll_offset = clamp(target_scroll_offset, 0, max_scroll);

// Clamp scroll again for safety
scroll_offset = clamp(scroll_offset, 0, max_scroll);

// Smooth scroll
scroll_offset = lerp(scroll_offset, target_scroll_offset, scroll_speed);

// Check if we're near top or bottom
atTop = (scroll_offset <= 1);
atBottom = (abs(scroll_offset - max_scroll) <= 1);


if (variable_global_exists("GameData") && global.GameData[$ "Burnout"] != undefined)
{
    burnoutNum = global.GameData.Burnout > 8 ? 1 : 0;
}

