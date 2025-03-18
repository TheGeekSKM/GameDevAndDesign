enum DamageType {
    PHYSICAL = 0,
    FIRE = 1,
    COLD = 2,
    POISON = 3,
    HOLY = 4,
    DARK = 5,
    HEALING = 6, // Special case: can damage undead
    HUNGER
}

/// @desc This is the struct that holds the stats for the HealthSystem
/// @param {StatSystem} _stats the stats for the entity
/// @param {Inventory} _inventory the inventory for the entity
/// @param {Bool} _isUndead whether the entity is undead or not
/// @param {Id} _owner the id of the entity
function HealthSystem(_stats, _inventory, _isUndead, _owner) constructor {
    owner = _owner;
    stats = _stats;
    inventory = _inventory;
    maxHealth = _stats.GetMaxHealth();
    currentHealth = maxHealth;
    isUndead = _isUndead;
    multipliers = [1, 1.2, 0.8, 1, 1, 1, -1, 1];
    
    timedMultipliers = [];

    function AddMultiplier(damageType, value)
    {
        multipliers[damageType] *= value;
    }
    
    function SetMultiplierForTime(_damageType, _value, _time)
    {
        array_push(timedMultipliers, {
            damageType: _damageType,
            value: _value,
            time: _time * game_get_speed(gamespeed_fps)  
        });
        AddMultiplier(_damageType, _value);
    }
    
    function TakeDamage(amount, damageType)
    {
        if (self.isUndead and damageType = DamageType.HEALING)
        {
            echo($"HEALTHSYSTEM -> Healing burns the undead.", true);
            damageType = DamageType.HOLY;
        }

        var armor = inventory.GetEquippedArmor();
        if (armor != undefined)
        {
            amount = max(0, 
                amount - stats.GetDamageReduction(
                    armor.GetArmorValue()
                )
            );
        }
        
        var multiplier = self.GetDamageMultipler(damageType);
        self.currentHealth = max(0, self.currentHealth - (amount * multiplier));
        
        if (self.currentHealth <= 0) self.Die();
    }
    
    function Heal(amount)
    {
        if (self.isUndead) self.TakeDamage(amount, DamageType.HEALING);
        else self.currentHealth = min(self.maxHealth, self.currentHealth + amount);
    }
    
    function GetDamageMultipler(damageType)
    {
        if (damageType == DamageType.HOLY and self.isUndead) return 2;
        if (damageType == DamageType.DARK and self.isUndead) return 0.5;
        return multipliers[damageType];
    }
    
    ///@pure
    function IsDead()
    {
        return self.currentHealth <= 0;
    }
    
    function Die()
    {
        instance_destroy(owner);
    }

    function Step()
    {
        maxHealth = stats.GetMaxHealth();
        
        for (var i = array_length(timedMultipliers) - 1; i >= 0; i--)
        {
            timedMultipliers[i].time -= 1;
            if (timedMultipliers[i].time <= 0)
            {
                AddMultiplier(timedMultipliers[i].damageType, (1 / timedMultipliers[i].value));
                array_delete(timedMultipliers, i, 1);
            }
        }
    }
}

