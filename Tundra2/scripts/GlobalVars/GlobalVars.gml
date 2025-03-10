function Vars() constructor {
	pause = false;
    debug = false;
	
	function PauseGame(_id) {
		Raise("Pause", _id);
		pause = true;
	}
	
	function ResumeGame(_id) {
		Raise("Resume", _id);
		pause = false;
	}
    
    function SetDebug(_debug) { debug = _debug; }
    
    highlightColors = [
        c_white,
        c_white,
        c_red,
        c_yellow,
        c_aqua,
        c_black,
    ];
    
    mainColor = make_color_rgb(196, 129, 126);
    mainColorLight = make_color_rgb(193, 176, 176);
}

global.vars = new Vars();