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
    
    CommandLibrary = {};
}

global.vars = new Vars();

enum PlayerState { Normal, Dashing, Attacking }
