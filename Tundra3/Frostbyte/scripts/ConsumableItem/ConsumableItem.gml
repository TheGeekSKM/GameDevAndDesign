function ConsumableItem(_name, _durability, _weight, _consumeEffects, _sprite, _hungerRemoved = 0, _healthAdded = 0, _staminaAdded = 0, _warmthAdded = 0) : Item(_name, _durability, 0, _weight, ItemType.Consumable, _consumeEffects, false, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system
    hungerRemoved = _hungerRemoved;
    healthAdded = _healthAdded;
    staminaAdded = _staminaAdded;
    warmthAdded = _warmthAdded;
    
    function Use()
    {
        var stats = owner.stats;
        for (var i = 0; i < array_length(effects); i++) {
            stats.AddStatForTime(effects[i]);
        }

        owner.hunger.Eat(hungerRemoved);
        owner.entityHealth.Heal(healthAdded);
        owner.stamina.AddStamina(staminaAdded);
        owner.temperature.AddWarmth(warmthAdded);

        durability--;
        if (durability <= 0) {
            owner.inventory.DeleteItem(self, 1);
        }
    }
}