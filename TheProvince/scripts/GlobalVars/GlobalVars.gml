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
    
    Colors = {
        c_darkBlue: make_color_rgb(13, 14, 69),
        c_lighterBlue: make_color_rgb(32, 60, 86),
        c_darkPurple: make_color_rgb(84, 78, 104),
        c_lighterPurple: make_color_rgb(141, 105, 122),
        c_orangePalette: make_color_rgb(208, 129, 89),
        c_yellowPallete: make_color_rgb(255, 170, 94),
        c_parchment: make_color_rgb(255, 212, 163),
        c_lightParchment: make_color_rgb(255, 236, 214),
    }
}

global.vars = new Vars();

