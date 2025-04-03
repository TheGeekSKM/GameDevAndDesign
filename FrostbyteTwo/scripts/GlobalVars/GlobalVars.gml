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
    
    mainColorLight = c_lime;
    mainColor = c_green;

	PlayerStats = undefined;
}

global.vars = new Vars();