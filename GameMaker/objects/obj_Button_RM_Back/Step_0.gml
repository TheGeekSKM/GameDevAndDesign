// Inherit the parent event
event_inherited();

if (!enabled) return;

if (keyboard_check_pressed(vk_escape)) OnMouseLeftClick();
else if (keyboard_check_released(vk_escape)) OnMouseLeftClickRelease();