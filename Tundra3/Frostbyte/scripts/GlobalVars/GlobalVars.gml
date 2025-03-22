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
	CameraShake = [
		{ duration: 0, intensity: 0 },
		{ duration: 0, intensity: 0 }
	]

	Players = [];
    PlayerStats = [undefined, undefined];
	PlayerColors = [make_color_rgb(70, 190, 94), make_color_rgb(70, 156, 190)];

	InputManager = new InputSystem();

	QuestList = {};

	CPU = new ConsumableItem("CPU", 1, 2, [new StatusEffects(StatType.Constitution, 2, 10)], spr_CPU);
	GPU = new ConsumableItem("GPU", 1, 2, [new StatusEffects(StatType.Strength, 2, 10)], spr_GPU);
	RAM = new ConsumableItem("RAM", 1, 2, [new StatusEffects(StatType.Dexterity, 2, 10)], spr_RAM);
}

global.vars = new Vars();

enum ButtonState
{
    Idle,
    Hovered,
    Clicked
}

function CameraShake(_camIndex, _strength, _duration)
{
	if (_camIndex >= 0 and _camIndex < array_length(global.vars.Cameras))
	{
		global.vars.CameraShake[_camIndex].intensity = _strength;
		global.vars.CameraShake[_camIndex].duration = _duration * game_get_speed(gamespeed_fps);
	}
}

