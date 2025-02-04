draw_self();

switch (currentState) {
	case ButtonState.Idle:
		image_blend = merge_color(image_blend, colorIdle, 0.1);
	case ButtonState.Hovered:
		image_blend = merge_color(image_blend, colorHover, 0.1);
		ShowPointers();
	case ButtonState.Clicked:
		image_blend = colorClick;
		ShowPointers(true);
}

drawText(x, y, fa_center, fa_middle, Born, textColor, text);

/// @func shows the pointers
/// @param {Bool} clicked -> if the button has been clicked 
function ShowPointers(clicked = false) {
	var leftSide = x - (sprite_width / 2);
	var rightSide = x + (sprite_width / 2);
	
	var col = c_white;
	if (clicked) col = colorClick;
	
	draw_sprite_ext(spritePointer, 0, leftSide - 5, y, 1, 1, 0, col, 1);
	draw_sprite_ext(spritePointer, 0, rightSide + 5, y, -1, 1, 0, col, 1);
}