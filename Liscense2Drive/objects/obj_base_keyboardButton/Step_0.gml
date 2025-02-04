

mouseHover = collision_point(guiMouseX, guiMouseY, id, true, false);

if (mouseHover) {
	currentState = ButtonState.Hovered;
}
else {
	currentState = ButtonState.Idle;
}