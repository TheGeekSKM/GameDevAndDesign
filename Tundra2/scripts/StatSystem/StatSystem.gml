function StatSystem(_str, _dex, _con) constructor {
    strength = _str;
    dexterity = _dex;
    constitution = _con;
    
    // Health and Stamina
    function GetMaxHealth() { return 50 + (self.constitution * 5) + (self.strength * 2); }
    function GetMaxStamina() { return 100 + (self.constitution * 5) + (self.dexterity * 2); }
    
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
        var base_speed = 2 + (self.dexterity * 0.15) - (self.strength * 0.05);
        return max(0.5, base_speed - self.GetEncumberancePenalty(currentWeight));
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
    function GetArmorResistance() 
    { 
        return (self.constitution * 1.5) + (self.strength * 0.5);
        // CON is the main factor, STR adds some physical resistance 
    }
    function GetDamageReduction(armorValue) 
    { 
        return armorValue * (self.GetArmorResistance() / 100);
        // Armor absorbs more damage based on CON and STR 
    }
    
    // Crit Hits
    function GetCritChance() 
    { 
        return min(50, 5 + (self.dexterity * 2));
        // DEX gives crit chance, capped at 50% 
    }
    function GetCritDamage() 
    { 
        return 1.5 + (self.strength * 0.1);
        // STR increases the crit multiplier (default 1.5x)
    }
    
    // Survival
    function GetTempResistance() { return (self.constitution * 2) + (self.strength * 1); }
    function GetHungerRate() { return max(0.5, 2 - (self.constitution * 0.1) + (self.strength * 0.05)); } 
}
    