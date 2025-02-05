#macro guiMouseX device_mouse_x_to_gui(0)
#macro guiMouseY device_mouse_y_to_gui(0)


mouseHover = collision_point(guiMouseX, guiMouseY, id, true, false);

if (mouseHover) {
    image_index = 1;
	image_blend = merge_color(image_blend, cHover, 0.1);
}
else {
    image_index = 0;
	image_blend = merge_color(image_blend, cDefault, 0.1);
}