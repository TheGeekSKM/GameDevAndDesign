function Vars() constructor {
	pause = false;
	
	function PauseGame(_id) {
		Raise("Pause", _id);
		pause = true;
	}
	
	function ResumeGame(_id) {
		Raise("Resume", _id);
		pause = false;
	}

	Cameras = [];
	Players = [];
    PlayerStats = [undefined, undefined];
	PlayerColors = [make_color_rgb(70, 190, 94), make_color_rgb(70, 156, 190)];

	InputManager = new InputSystem();
}

global.vars = new Vars();

enum ButtonState
{
    Idle,
    Hovered,
    Clicked
}