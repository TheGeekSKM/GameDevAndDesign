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
	PlayerDarkerColors = [make_color_rgb(50, 140, 70), make_color_rgb(50, 120, 140)];
	PlayerLighterColors = [make_color_rgb(90, 240, 120), make_color_rgb(90, 200, 240)];

	InputManager = new InputSystem();

	QuestList = {};

	CPU = new ConsumableItem("CPU", 1, 2, [new StatusEffects(StatType.Constitution, 2, 10)], spr_CPU);
	GPU = new ConsumableItem("GPU", 1, 2, [new StatusEffects(StatType.Strength, 2, 10)], spr_GPU);
	RAM = new ConsumableItem("RAM", 1, 2, [new StatusEffects(StatType.Dexterity, 2, 10)], spr_RAM);

	// Sword = new MeleeWeaponItem("Sword", c_red, 150, 10, DamageType.PHYSICAL, 10, 5, [], spr_CPU);
	Bow = new RangedWeaponItem("Bow", 150, 10, 10, 5, [], spr_CPU);
	Arrow = new BulletItem("Arrow", false, 10, 2, DamageType.PHYSICAL, 0, [], spr_CPU);
	Arrow2 = new BulletItem("Arrow", false, 10, 20, DamageType.PHYSICAL, 0, [], spr_CPU);
	Axe = new MeleeWeaponItem("Axe", c_white, 150, 10, DamageType.PHYSICAL, 10, 5, [], spr_CPU);

	CopperPiece = new Item("Copper Piece", 1, 0, 1, ItemType.Default, [], false, spr_CPU);
	Sticks = new Item("Sticks", 1, 0, 1, ItemType.Default, [], false, spr_CPU);
	Cherry = new ConsumableItem("Cherry", 1, 0, [], spr_CPU, 5); 

	AxeRecipe = new Recipe("Axe", [new RecipeItem(CopperPiece, 3), new RecipeItem(Sticks, 2)], [new RecipeItem(Axe, 1)]);

	DiscoveredRecipes = [];
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


enum UIMenuState {
    noUI,
    crafting,
    dialogue,
    inventory,
    pause,
    pcView,
    quest,
    stats
}
function ShowUIState(_playerIndex, _state)
{
}

