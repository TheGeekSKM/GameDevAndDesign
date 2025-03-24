enum DamageType {
    PHYSICAL = 0,
    FIRE = 1,
    COLD = 2,
    POISON = 3,
    HOLY = 4,
    DARK = 5,
    HEALING = 6, // Special case: can damage undead
    HUNGER = 7,
    TEMP = 8
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
    followHealth = 0;
    isUndead = _isUndead;
    multipliers = [1, 1.2, 0.8, 1, 1, 1, -1, 1, 1];

    recentAttacker = noone;
    
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
    
    function TakeDamage(amount, damageType, _attackerID, crit = false)
    {
        recentAttacker = _attackerID;
        if (self.isUndead and damageType = DamageType.HEALING)
        {
            echo($"HEALTHSYSTEM -> Healing burns the undead.", true);
            damageType = DamageType.HOLY;
        }

        var armor = inventory.GetEquippedArmor();
        if (armor != undefined and damageType != DamageType.HUNGER)
        {
            amount = max(0, 
                amount - stats.GetDamageReduction(
                    armor.GetArmorValue()
                )
            );
        }
        
        var multiplier = self.GetDamageMultipler(damageType);
        self.currentHealth = max(0, self.currentHealth - (amount * multiplier));

        if (damageType != DamageType.HUNGER and damageType != DamageType.TEMP)
        {
            if (amount > 0)
            {
                var textPopUp = instance_create_layer(owner.x, owner.y, "GUI", obj_PopUpText);
                if (crit)
                {
                    textPopUp.Init(amount, c_red);
                }
                else
                {
                    textPopUp.Init(amount, c_white);
                }
            }
        }
        
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

    function IsBadlyDamaged()
    {
        return self.currentHealth <= self.maxHealth / 4;
    }
    
    ///@pure
    function IsDead()
    {
        return self.currentHealth <= 0;
    }
    
    function Die()
    {
        inventory.DropAllItems();
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

        if (!instance_exists(recentAttacker))
        {
            recentAttacker = noone;
        }
        
        followHealth = lerp(followHealth, currentHealth, 0.1);
        followHealth = clamp(followHealth, 0, maxHealth);
    }

    function Draw(_width ,_height, _x, _y, _healthColor, _followColor)
    {
        var healthBarWidth = _width;
        var healthBarHeight = _height;
        var healthBarX = _x;
        var healthBarY =_y;
        
        draw_healthbar(healthBarX, healthBarY, healthBarX + healthBarWidth, healthBarY + healthBarHeight, (followHealth / maxHealth) * 100, _followColor, _followColor, _followColor, 0, false, false);
        draw_healthbar(healthBarX, healthBarY, healthBarX + healthBarWidth, healthBarY + healthBarHeight, (currentHealth / maxHealth) * 100, _healthColor, _healthColor, _healthColor, 0, false, false);
    }
}

