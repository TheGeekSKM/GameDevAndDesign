// Inherit the parent event
event_inherited();

if (open) image_angle = lerp(image_angle, 180, 0.2);
else image_angle = lerp(image_angle, 90, 0.2);