function ConsumableItem(_name, _durability, _staminaCost, _weight, _consumeEffects, _sprite) : Item(_name, _durability, _staminaCost, _weight, ItemType.Consumable, _consumeEffects, false, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system

    function Use()
    {
        var stats = owner.stats;
        for (var i = 0; i < array_length(effects); i++) {
            stats.AddStatForTime(effects[i]);
        }
    }
}