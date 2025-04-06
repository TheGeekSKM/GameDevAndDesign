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
    highlightColors = [
            c_white,
            c_white,
            c_red,
            c_yellow,
            c_aqua,
            c_black,
        ];

	PlayerStats = undefined;
    InputManager = new InputSystem();
    ItemLibrary = new AllItems();

    QuestList = {};
    

    Player = noone;
}

global.vars = new Vars();