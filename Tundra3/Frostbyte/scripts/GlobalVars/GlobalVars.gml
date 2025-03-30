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

	Sword = new MeleeWeaponItem("Copper Sword", c_red, 150, 10, DamageType.PHYSICAL, 10, 5, [], spr_Sword);
	Bow = new RangedWeaponItem("Bow", 150, 10, 10, 5, [], spr_Bow);
	Arrow = new BulletItem("Arrow", false, 10, 2, DamageType.PHYSICAL, 0, [], spr_Arrow_BAD);
	Arrow2 = new BulletItem("Arrow", false, 10, 20, DamageType.PHYSICAL, 0, [], spr_Arrow_GOOD);
	Axe = new MeleeWeaponItem("Copper Axe", c_white, 150, 10, DamageType.PHYSICAL, 10, 5, [], spr_Axe);
	Pickaxe = new MeleeWeaponItem("Copper Pickaxe", c_dkgray, 150, 5, DamageType.PHYSICAL, 10, 5, [], spr_pickaxe);
	Shovel = new MeleeWeaponItem("Copper Shovel", c_dkgray, 150, 5, DamageType.PHYSICAL, 10, 5, [], spr_shovel);

	CopperPiece = new Item("Scrap Copper", 1, 0, 1, ItemType.Default, [], false, spr_copper);
	Silicone = new Item("Silicone Shards", 1, 0, 1, ItemType.Default, [], false, spr_silicon);
	Sticks = new Item("Sticks", 1, 0, 1, ItemType.Default, [], false, spr_sticks);
	Cherry = new ConsumableItem("Cherry", 1, 0, [], spr_Cherry, 15, 3); 
	RawMeat = new ConsumableItem("Raw Meat", 1, 0, [], spr_rawMeat, 5); 
	CookedMeat = new ConsumableItem("Cooked Meat", 1, 0, [], spr_cookedMeat, 35, 10, 1, 5); 
	LeatherArmor = new ArmorItem("LeatherArmor", 7, 150, 7, 10, [], spr_armor);

	AxeRecipe = new Recipe("Copper Axe", [new RecipeItem(CopperPiece, 3), new RecipeItem(Sticks, 2)], [new RecipeItem(Axe, 1)]);
	ShovelRecipe = new Recipe("Copper Shovel", [new RecipeItem(CopperPiece, 1), new RecipeItem(Sticks, 2)], [new RecipeItem(Shovel, 1)]);
	PickaxeRecipe = new Recipe("Copper Pickaxe", [new RecipeItem(CopperPiece, 3), new RecipeItem(Sticks, 2)], [new RecipeItem(Pickaxe, 1)]);
	SwordRecipe = new Recipe("Copper Sword", [new RecipeItem(CopperPiece, 2), new RecipeItem(Sticks, 1)], [new RecipeItem(Sword, 1)]);
	
	CookedMeatRecipe = new Recipe("CookedMeat", [new RecipeItem(RawMeat, 1), new RecipeItem(Sticks, 3)], [new RecipeItem(CookedMeat, 1)]);
	
	CPURecipe = new Recipe("CPU", [new RecipeItem(CopperPiece, irandom_range(1, 3)), new RecipeItem(Silicone, irandom_range(1, 3))], [new RecipeItem(CPU, 1)]);
	GPURecipe = new Recipe("GPU", [new RecipeItem(CopperPiece, irandom_range(1, 3)), new RecipeItem(Silicone, irandom_range(1, 3))], [new RecipeItem(GPU, 1)]);
	RAMRecipe = new Recipe("RAM", [new RecipeItem(CopperPiece, irandom_range(1, 3)), new RecipeItem(Silicone, irandom_range(1, 3))], [new RecipeItem(RAM, 1)]);

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

