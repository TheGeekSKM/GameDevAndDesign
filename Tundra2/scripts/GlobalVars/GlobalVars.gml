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
    
    highlightColors = [
        c_white,
        c_white,
        c_red,
        c_yellow,
        c_aqua,
        c_black,
    ];
}

global.vars = new Vars();