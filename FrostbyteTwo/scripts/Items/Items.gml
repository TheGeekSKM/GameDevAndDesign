function AllItems() constructor 
{
    // ----- Mission Items -----
    CPU = new ConsumableItem("CPU", 1, 2, [new StatusEffects(StatType.Constitution, 2, 10)], spr_CPU);
    GPU = new ConsumableItem("GPU", 1, 2, [new StatusEffects(StatType.Strength, 2, 10)], spr_GPU);
    RAM = new ConsumableItem("RAM", 1, 2, [new StatusEffects(StatType.Dexterity, 2, 10)], spr_RAM);
    
    // ----- Weapons -----
    Sword = new MeleeWeaponItem("Copper Sword", c_red, 150, 10, DamageType.PHYSICAL, 10, 5, [], spr_Sword);
    Bow = new RangedWeaponItem("Bow", 150, 10, 10, 5, [], spr_Bow);
    Arrow = new BulletItem("Arrow", false, 10, 2, DamageType.PHYSICAL, 0, [], spr_Arrow_BAD);
    Arrow2 = new BulletItem("Arrow", false, 10, 20, DamageType.PHYSICAL, 0, [], spr_Arrow_GOOD);
    Axe = new MeleeWeaponItem("Copper Axe", c_white, 150, 10, DamageType.PHYSICAL, 10, 5, [], spr_Axe);
    Pickaxe = new MeleeWeaponItem("Copper Pickaxe", c_dkgray, 150, 5, DamageType.PHYSICAL, 10, 5, [], spr_pickaxe);
    Shovel = new MeleeWeaponItem("Copper Shovel", c_dkgray, 150, 5, DamageType.PHYSICAL, 10, 5, [], spr_shovel);
    CopperPiece = new Item("Scrap Copper", 1, 0, 1, ItemType.Default, [], false, spr_copper);
    Silicone = new Item("Silicone Shards", 1, 0, 1, ItemType.Default, [], false, spr_silicon);
    
    // ----- Base Resources -----
    SandClumps = new ConsumableItem("Sand Clumps", 1, 0, [new StatusEffects(StatType.Constitution, -1, 10)], spr_sandClumps, 5);
    ScrapGold = new ConsumableItem("Scrap Gold", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10)], spr_scrapGold, 5, 0, 5, 0);
    BauxiteOre = new ConsumableItem("Bauxite Ore", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10)], spr_bauxiteOre, 5, 0, 0, 5);
    SteelDebris = new ConsumableItem("Steel Debris", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10), new StatusEffects(StatType.Strength, 1, 10)], spr_steelDebris, 0, -5, 0, 5);
    PlasticChunks = new ConsumableItem("Plastic Chunks", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10)], spr_plasticChunks, 5, 0, 0, 7);
    ThermalGoo = new ConsumableItem("Thermal Goo", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10), new StatusEffects(StatType.Strength, 1, 10)], spr_thermalGoo, 0, -5, 0, 5);
    GraphiteDust = new ConsumableItem("Graphite Dust", 1, 0, [new StatusEffects(StatType.Dexterity, 1, 10), new StatusEffects(StatType.Constitution, -1, 10)], spr_graphiteDust, 0, 0, 5, 0);
    LeadBits = new ConsumableItem("Lead Bits", 1, 0, [new StatusEffects(StatType.Constitution, -3, 10)], spr_leadBits, 10, 0, 5, 0);
    
    // ----- Secondary Resources -----
    GlassPanel = new ConsumableItem("Glass Panel", 1, 0, [new StatusEffects(StatType.Dexterity, -1, 10), new StatusEffects(StatType.Constitution, -1, 10)], spr_glassPanel, 5, -5, 15, -5);
    CopperWire = new ConsumableItem("Copper Wire", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10), new StatusEffects(StatType.Dexterity, 1, 10)], spr_copperWire, 0, 0, 15, 0);
    GoldFlakes = new ConsumableItem("Gold Flakes", 1, 0, [new StatusEffects(StatType.Constitution, -1, 10)], spr_goldFlakes, 0, 0, 10, 5);
    AlluminumAlloy = new ConsumableItem("Alluminum Alloy", 1, 0, [new StatusEffects(StatType.Constitution, -2, 10)], spr_alluminumAlloy, 5, 0, 0, -5);
    SteelScraps = new ConsumableItem("Steel Scraps", 1, 0, [new StatusEffects(StatType.Strength, 3, 10), new StatusEffects(StatType.Constitution, -2, 10)], spr_steelScraps, 0, -5, 0, 0);
    PlasticResin = new ConsumableItem("Plastic Resin", 1, 0, [new StatusEffects(StatType.Constitution, -1, 10)], spr_plasticResin, 5, 0, 0, 10);
    ThermalPaste = new ConsumableItem("Thermal Paste", 1, 0, [new StatusEffects(StatType.Constitution, -1, 10)], spr_thermalPaste, 0, 0, 5, 10);
    GrapheneStrips = new ConsumableItem("Graphene Strips", 1, 0, [new StatusEffects(StatType.Dexterity, -1, 10)], spr_grapheneStrips, 5, 0, 15, -5);
    LeadPlates = new ConsumableItem("Lead Plates", 1, 0, [ new StatusEffects(StatType.Constitution, -1, 10)], spr_leadPlates, 5, 15, 0, 0);
    
    // ----- Weapons 2 -----
    CircuitBlade = new MeleeWeaponItem("Circuit Blade", c_green, 150, irandom_range(12, 18), DamageType.PHYSICAL, 10, 5, [], spr_circuitBlade);
    GoldPlatedKnucles = new MeleeWeaponItem("Gold Plated Knuckles", c_yellow, 150, irandom_range(15, 20), DamageType.PHYSICAL, 10, 5, [], spr_goldPlatedKnuckles);
    AluminumPipe = new MeleeWeaponItem("Aluminum Pipe", c_dkgray, 150, irandom_range(8, 12), DamageType.PHYSICAL, 10, 5, [], spr_aluminumPipe);
    SolderingIron = new MeleeWeaponItem("Soldering Iron", c_red, 150, irandom_range(10, 14), DamageType.PHYSICAL, 10, 5, [], spr_solderingIron);
    GrapheneWhip = new MeleeWeaponItem("Graphene Whip", c_green, 150, irandom_range(18, 25), DamageType.PHYSICAL, 10, 5, [], spr_grapheneWhip);
    
    // ----- Weapons 3 -----
    CRTCannon = new RangedWeaponItem("CRT Cannon", 150, irandom_range(12, 18), 12, 6, [], spr_crtCannon);
    RAMStickThrower = new RangedWeaponItem("RAM Stick Thrower", 150, irandom_range(15, 22), 14, 7, [], spr_ramStickThrower);
    CapacitorSlingshot = new RangedWeaponItem("Capacitor Slingshot", 150, irandom_range(18, 25), 16, 8, [], spr_capacitorSlingshot); 
    
    // ----- Armor -----
    AntiStaticJumpsuit = new ArmorItem("Anti-Static Jumpsuit", irandom_range(6, 12), 160, irandom_range(4, 9), irandom_range(6, 11), [], spr_antiStaticJumpsuit);
    GoldLinedCircuitVest = new ArmorItem("Gold Lined Circuit Vest", irandom_range(12, 18), 170, irandom_range(9, 14), irandom_range(11, 16), [], spr_goldLinedCircuitVest);
    AluminumPlating = new ArmorItem("Aluminum Plating", irandom_range(14, 22), 180, irandom_range(13, 19), irandom_range(14, 20), [], spr_aluminumPlating);
    GrapheneWeaveSuit = new ArmorItem("Graphene Weave Suit", irandom_range(22, 28), 200, irandom_range(18, 26), irandom_range(20, 27), [], spr_grapheneWeaveSuit);
    
    // ----- Recipes -----
    CircuitBladeRecipe = new Recipe("Circuit Blade", [new RecipeItem(CopperWire, 3), new RecipeItem(Silicone, 2)], [new RecipeItem(CircuitBlade, 1)]);
	GoldPlatedKnucklesRecipe = new Recipe("Gold Plated Knuckles", [new RecipeItem(GoldFlakes, 4), new RecipeItem(SteelScraps, 2)], [new RecipeItem(GoldPlatedKnucles, 1)]);
	AluminumPipeRecipe = new Recipe("Aluminum Pipe", [new RecipeItem(AlluminumAlloy, 3), new RecipeItem(SteelScraps, 1)], [new RecipeItem(AluminumPipe, 1)]);
	RAMStickThrowerRecipe = new Recipe("Soldering Iron", [new RecipeItem(CopperWire, 2), new RecipeItem(ThermalPaste, 1)], [new RecipeItem(SolderingIron, 1)]);
	GrapheneWhipRecipe = new Recipe("Graphene Whip", [new RecipeItem(GrapheneStrips, 3), new RecipeItem(PlasticResin, 2)], [new RecipeItem(GrapheneWhip, 1)]);

	CRTCannonRecipe = new Recipe("CRT Cannon", [new RecipeItem(GlassPanel, 2), new RecipeItem(CopperWire, 3)], [new RecipeItem(CRTCannon, 1)]);
	RAMStickThrowerRecipe = new Recipe("RAM Stick Thrower", [new RecipeItem(RAM, 2), new RecipeItem(PlasticResin, 1)], [new RecipeItem(RAMStickThrower, 1)]);
	CapacitorSlingshotRecipe = new Recipe("Capacitor Slingshot", [new RecipeItem(CopperWire, 2), new RecipeItem(ThermalPaste, 2)], [new RecipeItem(CapacitorSlingshot, 1)]);

	AntiStaticJumpsuitRecipe = new Recipe("Anti-Static Jumpsuit", [new RecipeItem(PlasticResin, 3), new RecipeItem(CopperWire, 2)], [new RecipeItem(AntiStaticJumpsuit, 1)]);
	GoldLinedCircuitVestRecipe = new Recipe("Gold Lined Circuit Vest", [new RecipeItem(GoldFlakes, 3), new RecipeItem(Silicone, 2)], [new RecipeItem(GoldLinedCircuitVest, 1)]);
	AluminumPlatingRecipe = new Recipe("Aluminum Plating", [new RecipeItem(AlluminumAlloy, 4), new RecipeItem(SteelScraps, 2)], [new RecipeItem(AluminumPlating, 1)]);
	GrapheneWeaveSuitRecipe = new Recipe("Graphene Weave Suit", [new RecipeItem(GrapheneStrips, 4), new RecipeItem(PlasticResin, 3)], [new RecipeItem(GrapheneWeaveSuit, 1)]);
	
	Sticks = new Item("Sticks", 1, 0, 0, ItemType.Default, [], false, spr_sticks);
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
	
	GlassPanelRecipe = new Recipe("Glass Panel", [new RecipeItem(SandClumps, irandom_range(1, 3)), new RecipeItem(Sticks, irandom_range(1, 3))], [new RecipeItem(GlassPanel, 1)]);
	SiliconRecipe = new Recipe("Silicon", [new RecipeItem(SandClumps, irandom_range(1, 3)), new RecipeItem(Sticks, irandom_range(1, 3))], [new RecipeItem(Silicone, 1)]);
	CopperWireRecipe = new Recipe("Copper Wire", [new RecipeItem(CopperPiece, irandom_range(1, 3)), new RecipeItem(Sticks, irandom_range(1, 3))], [new RecipeItem(CopperWire, 1)]);
	GoldFlakesRecipe = new Recipe("Gold Flakes", [new RecipeItem(ScrapGold, irandom_range(1, 3))], [new RecipeItem(GoldFlakes, 1)]);
	AlluminumAlloyRecipe = new Recipe("Alluminum Alloy", [new RecipeItem(BauxiteOre, irandom_range(1, 3)), new RecipeItem(SteelDebris, irandom_range(1, 3))], [new RecipeItem(AlluminumAlloy, 1)]);
	SteelScrapsRecipe = new Recipe("Steel Scraps", [new RecipeItem(SteelDebris, irandom_range(1, 3))], [new RecipeItem(SteelScraps, 1)]);
	PlasticResinRecipe = new Recipe("Plastic Resin", [new RecipeItem(PlasticChunks, irandom_range(1, 3)), new RecipeItem(ThermalGoo, irandom_range(1, 3))], [new RecipeItem(PlasticResin, 1)]);
	ThermalPasteRecipe = new Recipe("Thermal Paste", [new RecipeItem(ThermalGoo, irandom_range(1, 3)), new RecipeItem(GraphiteDust, irandom_range(1, 3))], [new RecipeItem(ThermalPaste, 1)]);
	LeadPlatesRecipe = new Recipe("Lead Plates", [new RecipeItem(LeadBits, irandom_range(1, 3)), new RecipeItem(CopperPiece, irandom_range(1, 3))], [new RecipeItem(LeadPlates, 1)]);
}



