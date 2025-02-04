enum ButtonState {
	Idle,
	Hovered,
	Clicked
}

currentState = ButtonState.Idle;
spritePointer = spr_buttonPointer;

text = "";
mouseHover = 0;

function OnClick() {
	if (onClick != undefined) {
		onClick();
		return;
	}
	
	// other code here
}