if (mouseHover and currentState == ButtonState.Hovered)
{
	currentState = ButtonState.Clicked;
	OnClick();
}