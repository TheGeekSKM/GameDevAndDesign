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
function StatSystem(_str, _dex, _con, _owner) constructor {
    strength = _str;
    dexterity = _dex;
    constitution = _con;
    owner = _owner;

    timedStats = [];
    
    // Health and Stamina
    function GetMaxHealth() { return 50 + (self.constitution * 5) + (self.strength * 2); }
    function GetMaxStamina() { return 100 + (self.constitution * 5) + (self.dexterity * 2); }

    function GetStaminaRegenRate() { return (1 + (self.constitution * 0.1) + (self.dexterity * 0.05)) / 60; }
    
    // Encumberance System
    function GetMaxCarryWeight() { return 20 + (self.strength * 5) + (self.constitution * 2); }
    function GetEncumberancePenalty(currentWeight) { 
        var maxWeight = self.GetMaxCarryWeight();
        
        // Each extra unit over max weight slows speed by 10%
        if (currentWeight > maxWeight) { return (currentWeight - maxWeight) * 0.1; } 
        return 0;
    }
    
    // Movement
    function GetMoveSpeed(currentWeight) 
    { 
        var base_speed = 1 + (self.dexterity * 0.15) - (self.strength * 0.05);
        var decimalSpeed = max(1, base_speed - self.GetEncumberancePenalty(currentWeight));
        return round(decimalSpeed / 2);
        // Speed is reduced if over carry limit
    }
    
    // Melee Combat
    function GetMeleeAttackSpeed() { return 1 + (self.dexterity * 0.1) + (self.strength * 0.05); }
    function GetMeleeDamage() { return 5 + (self.strength * 1.8) + (self.dexterity * 0.5); }
    function GetMeleeKnockback() { return (self.strength * 1.2) - (self.dexterity * 0.3); }
    
    // Ranged Combat
    function GetRangedDamage() {  return 4 + (self.dexterity * 1.5) + (self.strength * 0.3); }
    function GetRangedAttackSpeed() { return 1 + (self.dexterity * 0.15) - (self.strength * 0.05); }
    
    // Armor Resistances
    function GetNaturalResistance() 
    { 
        return (self.constitution * 0.25) + (self.strength * 0.15);
        // CON is the main factor, STR adds some physical resistance 
    }
    function GetDamageReduction(armorValue) 
    { 
        return armorValue + (self.GetNaturalResistance() / 100);
        // Armor absorbs more damage based on CON and STR 
    }
    
    // Crit Hits
    function GetCritChance() 
    { 
        return min(50, 5 + (self.dexterity * 2));
        // DEX gives crit chance, capped at 50% 
    }
    function GetCritDamageMultiplier() 
    { 
        return 1.5 + (self.strength * 0.1);
        // STR increases the crit multiplier (default 1.5x)
    }
    
    // Survival
    function GetMaxTemperature() { return 100 + (self.constitution * 5) + (self.strength * 2); }
    function GetTemperatureRate() { 
        var equippedArmor = owner.inventory.GetEquippedArmor();
        var armorEffect = equippedArmor != undefined ? equippedArmor.armorValue * 0.05 : 0; // Armor reduces the rate by 5% per armor point
        return (max(0.5, 0.2 + (self.constitution * 0.1) - (self.strength * 0.05) - armorEffect)) / game_get_speed(gamespeed_fps); 
    }

    function GetHungerRate() { return 2 * (max(0.5, 1 - (self.constitution * 0.1) + (self.strength * 0.05))) / game_get_speed(gamespeed_fps); } 
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

    function ToString(_index)
    {
        var str = "";
        
        var textColor = $"[c_player{_index}_darker]";

        // str = string_concat(str, "--------------------------------------------------\n");
        str = string_concat(str, $"{textColor}[scale, 1.25]-----STATS:-----[/c]\n");
        str = string_concat(str, $"Strength: [c_player{_index}]{strength}[/c]\n");
        str = string_concat(str, $"Dexterity: [c_player{_index}]{dexterity}[/c]\n");
        str = string_concat(str, $"Constitution: [c_player{_index}]{constitution}[/c]\n\n");

        str = string_concat(str, $"{textColor}[scale, 1.25]-----HEALTH AND STAMINA:-----[/c]\n");
        str = string_concat(str, $"Max Health: [c_player{_index}]{GetMaxHealth()}[/c]\n");
        str = string_concat(str, $"Max Stamina: [c_player{_index}]{GetMaxStamina()}[/c]\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----ENCUMBRANCE:-----[/c]\n");
        str = string_concat(str, $"Max Carry Weight: [c_player{_index}]{GetMaxCarryWeight()}[/c]\n");
        str = string_concat(str, $"Current Move Speed: [c_player{_index}]{GetMoveSpeed(0)}[/c]\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----COMBAT:-----[/c]\n");
        str = string_concat(str, $"Crit Chance: [c_player{_index}]{GetCritChance()}%[/c]\n");
        str = string_concat(str, $"Crit Damage Multiplier: [c_player{_index}]{GetCritDamageMultiplier()}x[/c]\n");
        str = string_concat(str, $"Melee Attack Speed: [c_player{_index}]{GetMeleeAttackSpeed()}[/c]\n");
        str = string_concat(str, $"Melee Damage: [c_player{_index}]{GetMeleeDamage()}[/c]\n");
        str = string_concat(str, $"Ranged Attack Speed: [c_player{_index}]{GetRangedAttackSpeed()}[/c]\n");
        str = string_concat(str, $"Ranged Damage: [c_player{_index}]{GetRangedDamage()}[/c]\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----DEFENSE:-----[/c]\n");
        str = string_concat(str, $"Natural Resistance: [c_player{_index}]{GetNaturalResistance()}[/c]\n\n");
        
        str = string_concat(str, $"{textColor}[scale, 1.25]-----SURVIVAL:-----[/c]\n");
        str = string_concat(str, $"Max Temperature: [c_player{_index}]{GetMaxTemperature()}[/c]\n");
        str = string_concat(str, $"Temperature Rate: [c_player{_index}]{GetTemperatureRate()} per tick[/c]\n");
        str = string_concat(str, $"Max Hunger: [c_player{_index}]{GetMaxHunger()}[/c]\n");
        str = string_concat(str, $"Hunger Rate: [c_player{_index}]{GetHungerRate()} per tick[/c]\n\n");
        // str = string_concat(str, "--------------------------------------------------\n");

        
        return str;
    }


}
