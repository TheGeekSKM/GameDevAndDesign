function ConsumableItem(_name, _durability, _weight, _consumeEffects, _sprite, _hungerRemoved = 0, _healthAdded = 0, _staminaAdded = 0, _warmthAdded = 0) : Item(_name, 64, _durability, 0, _weight, ItemType.Consumable, _consumeEffects, false, _sprite) constructor {
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
            var slotIndex = owner.inventory.ContainsItem(self);
            if (slotIndex != -1) owner.inventory.RemoveItem(slotIndex, 1);
        }
    }

    function InventoryUse()
    {
        Use();
    }

    function GetDescription() {
        var desc = $"Item: {name}\n";
        for (var i = 0; i < array_length(effects); i++) {
            desc = string_concat(desc, $"Effect #{i + 1}: {StatTypeToString(effects[i].statType)} ({effects[i].value})\n");
        }
       
        var hunger = "";
        hunger = string_concat(hunger, $"Satiety: {hungerRemoved}\n");
        
        var _health = "";
        _health = string_concat(_health, $"Healing: {healthAdded}\n");

        var stamina = "";
        stamina = string_concat(stamina, $"Stamina: {staminaAdded}\n");

        var warmth = "";
        warmth = string_concat(warmth, $"Warmth: {warmthAdded}\n");

        desc = string_concat(desc, hunger, _health, stamina, warmth);

        return desc;
    }

    function GetCopy()
    {
        var copy = new ConsumableItem(name, durability, weight, effects, sprite, hungerRemoved, healthAdded, staminaAdded, warmthAdded);
        return copy;
    }
}