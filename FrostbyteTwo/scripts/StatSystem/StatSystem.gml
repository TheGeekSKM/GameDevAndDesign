enum StatType
{
    Strength,
    Dexterity,
    Constitution
}

/// @function StatSystem(_str, _dex, _con)
/// @param {real} _str - Strength
/// @param {real} _dex - Dexterity
/// @param {real} _con - Constitution
/// @description Create a new StatSystem object with the given stats.
function StatSystem(_str, _dex, _con, _owner)  : Component("stats")  constructor {
    strength = _str;
    dexterity = _dex;
    constitution = _con;
    owner = _owner;

    timedStats = [];
    
    // Health and Stamina
    function GetMaxHealth() { 
        if (!instance_exists(owner)) return 0; 
        return 50 + (self.constitution * 5) + (self.strength * 2); }
    function GetMaxStamina() { 
        if (!instance_exists(owner)) return 0; 
        return 100 + (self.constitution * 5) + (self.dexterity * 2); }

    function GetStaminaRegenRate() { 
        if (!instance_exists(owner)) return 0; 
        return (1 + (self.constitution * 0.1) + (self.dexterity * 0.05)) / 60; }
    
    // Encumberance System
    function GetMaxCarryWeight() { 
        if (!instance_exists(owner)) return 0; 
        return 20 + (self.strength * 5) + (self.constitution * 2); }
    
    function GetEncumberancePenalty(currentWeight) { 
        if (!instance_exists(owner)) return 0; 
        var maxWeight = self.GetMaxCarryWeight();
        
        // Each extra unit over max weight slows speed by 10%
        if (currentWeight > maxWeight) { return (currentWeight - maxWeight) * 0.1; } 
        return 0;
    }
    
    // Movement
    function GetMoveSpeed(currentWeight) 
    { 
        if (!instance_exists(owner)) return 0; 
        var base_speed = 1 + (self.dexterity * 0.15) - (self.strength * 0.05);
        var decimalSpeed = max(1, base_speed - self.GetEncumberancePenalty(currentWeight));
        return round(decimalSpeed / 2);
        // Speed is reduced if over carry limit
    }
    
    // Melee Combat
    function GetMeleeAttackSpeed() { 
        if (!instance_exists(owner)) return 0; 
        return 1 + (self.dexterity * 0.1) + (self.strength * 0.05); }
    function GetMeleeDamage() { 
        if (!instance_exists(owner)) return 0; 
        return 5 + (self.strength * 1.8) + (self.dexterity * 0.5); }
    function GetMeleeKnockback() { 
        if (!instance_exists(owner)) return 0; 
        return (self.strength * 1.2) - (self.dexterity * 0.3); }
    
    // Ranged Combat
    function GetRangedDamage() {  
        if (!instance_exists(owner)) return 0; 
        return 4 + (self.dexterity * 1.5) + (self.strength * 0.3); }
    function GetRangedAttackSpeed() { 
        if (!instance_exists(owner)) return 0; 
        return 1 + (self.dexterity * 0.15) - (self.strength * 0.05); }
    
    // Armor Resistances
    function GetNaturalResistance() 
    { 
        if (!instance_exists(owner)) return 0; 
        return (self.constitution * 0.25) + (self.strength * 0.15);
        // CON is the main factor, STR adds some physical resistance 
    }
    function GetDamageReduction(armorValue) 
    { 
        if (!instance_exists(owner)) return 0; 
        return armorValue + (self.GetNaturalResistance() / 100);
        // Armor absorbs more damage based on CON and STR 
    }
    
    // Crit Hits
    function GetCritChance() 
    { 
        if (!instance_exists(owner)) return 0; 
        return min(50, 5 + (self.dexterity * 2));
        // DEX gives crit chance, capped at 50% 
    }
    function GetCritDamageMultiplier() 
    { 
        if (!instance_exists(owner)) return 0; 
        return 1.5 + (self.strength * 0.1);
        // STR increases the crit multiplier (default 1.5x)
    }
    
    // Survival
    function GetMaxTemperature()  { 
        if (!instance_exists(owner)) return 0; 
        return 100 + (self.constitution * 5) + (self.strength * 2); }
    function GetTemperatureRate() {
        if (!instance_exists(owner)) return 0; 
        var equippedArmor = owner.inventory.GetEquippedArmor();
        var armorEffect = equippedArmor != undefined ? equippedArmor.armorValue * 0.05 : 0; // Armor reduces the rate by 5% per armor point
        return (max(0.5, 0.2 + (self.constitution * 0.1) - (self.strength * 0.05) - armorEffect)) / game_get_speed(gamespeed_fps); 
    }

    function GetHungerRate() { 
        if (!instance_exists(owner)) return 0; 
        return (max(0.5, 1 - (self.constitution * 0.1) + (self.strength * 0.05))) / game_get_speed(gamespeed_fps); } 
    function GetMaxHunger() { return 100 + (self.constitution * 5) + (self.strength * 2); }

    function AddStat(_statusEffect)
    {
        switch (_statusEffect.statType)
        {
            case StatType.Strength: strength += _statusEffect.value; break;
            case StatType.Dexterity: dexterity += _statusEffect.value; break;
            case StatType.Constitution: constitution += _statusEffect.value; break;
        }
    }

    function RemoveStat(_statusEffect)
    {
        switch (_statusEffect.statType)
        {
            case StatType.Strength: strength -= _statusEffect.value; break;
            case StatType.Dexterity: dexterity -= _statusEffect.value; break;
            case StatType.Constitution: constitution -= _statusEffect.value; break;
        }
    }

    function AddStatForTime(_statusEffect)
    {
        array_push(timedStats, _statusEffect);
        AddStat(_statusEffect);
    }

    function Step()
    {
        if (!instance_exists(owner)) return; 
        //loop backwards to allow for removal
        for (var i = array_length(timedStats) - 1; i >= 0; i--)
        {
            timedStats[i].duration -= 1;
            if (timedStats[i].duration == 0)
            {
                RemoveStat(timedStats[i]);
                array_delete(timedStats, i, 1);
            }
        }
    }

    function ToString()
    {
        var str = "";
        
        var textColor = $"[c_black]";

        // str = string_concat(str, "--------------------------------------------------\n");
        str = string_concat(str, $"{textColor}[scale, 1.25]-----STATS:-----\n[/c]");
        str = string_concat(str, $"Strength: {strength}\n");
        str = string_concat(str, $"Dexterity: {dexterity}\n");
        str = string_concat(str, $"Constitution: {constitution}\n\n");

        str = string_concat(str, $"{textColor}[scale, 1.25]-----HEALTH AND STAMINA:-----\n[/c]");
        str = string_concat(str, $"Max Health: {GetMaxHealth()}\n");
        str = string_concat(str, $"Max Stamina: {GetMaxStamina()}\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----ENCUMBRANCE:-----\n[/c]");
        str = string_concat(str, $"Max Carry Weight: {GetMaxCarryWeight()}\n");
        str = string_concat(str, $"Current Move Speed: {GetMoveSpeed(0)}\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----COMBAT:-----\n[/c]");
        str = string_concat(str, $"Crit Chance: {GetCritChance()}%\n");
        str = string_concat(str, $"Crit Damage Multiplier: {GetCritDamageMultiplier()}x\n");
        str = string_concat(str, $"Melee Attack Speed: {GetMeleeAttackSpeed()}\n");
        str = string_concat(str, $"Melee Damage: {GetMeleeDamage()}\n");
        str = string_concat(str, $"Ranged Attack Speed: {GetRangedAttackSpeed()}\n");
        str = string_concat(str, $"Ranged Damage: {GetRangedDamage()}\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----DEFENSE:-----\n[/c]");
        str = string_concat(str, $"Natural Resistance: {GetNaturalResistance()}\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----SURVIVAL:-----\n[/c]");
        str = string_concat(str, $"Max Temperature: {GetMaxTemperature()}\n");
        str = string_concat(str, $"Temperature Rate: {GetTemperatureRate()} per tick\n");
        str = string_concat(str, $"Max Hunger: {GetMaxHunger()}\n");
        str = string_concat(str, $"Hunger Rate: {GetHungerRate()} per tick\n\n");
        // str = string_concat(str, "--------------------------------------------------\n");

        
        return str;
    }


}
