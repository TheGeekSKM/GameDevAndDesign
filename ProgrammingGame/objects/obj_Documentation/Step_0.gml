// Inherit the parent event
event_inherited();

// Check if we're near top or bottom
atTop = (scroll_offset <= 1);
atBottom = (abs(scroll_offset - max_scroll) <= 1);