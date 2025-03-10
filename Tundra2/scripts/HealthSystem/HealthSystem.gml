enum DamageType {
    PHYSICAL = 0,
    FIRE = 1,
    COLD = 2,
    POISON = 3,
    HOLY = 4,
    DARK = 5,
    HEALING = 6 // Special case: can damage undead
}

function HealthSystem(_maxHealth, _isUndead, _owner) constructor {
    owner = _owner;
    maxHealth = _maxHealth;
    currentHealth = maxHealth;
    isUndead = _isUndead;
    multiplers = [1, 1.2, 0.8, 1, 1, 1, -1];
    
    function TakeDamage(amount, damageType)
    {
        if (self.isUndead and damageType = DamageType.HEALING)
        {
            echo($"HEALTHSYSTEM -> Healing burns the undead.");
            damageType = DamageType.HOLY;
        }
        
        var multiplier = self.GetDamageMultipler(damageType);
        self.currentHealth = max(0, self.current_health - (amount * multiplier));
        
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
        return multiplers[damageType];
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
}

