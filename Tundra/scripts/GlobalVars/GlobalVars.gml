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
}

global.vars = new Vars();
global.mainColor = make_color_rgb(196, 129, 126);

enum ButtonState
{
    Idle,
    Hovered,
    Clicked    
}