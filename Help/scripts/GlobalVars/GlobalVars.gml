function vars() constructor {
	pause = false;
    debug = false;
    single = false;
	
	function PauseGame(_id) {
		Raise("Pause", _id);
		pause = true;
	}
	
	function ResumeGame(_id) {
		Raise("Resume", _id);
		pause = false;
	}
}

global.vars = new vars();

enum ButtonState
{
    Idle,
    Hover,
    Click
}

enum ContainerType
{
    UpDown,
    LeftRight
}

font_enable_effects(CustomFont_Effects, true, {
    outlineEnable : true,
    outlineDistance : 5,
    outlineColor : c_black,
    outlineAlpha : 1,
    
    dropShadowEnable : true,
    dropShadowSoftness : 5,
    dropShadowColour : c_black,
    dropShadowAlpha : 0.5
});