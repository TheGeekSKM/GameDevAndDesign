function ArmorItem(_name, _armorValue, _durability, _staminaCost, _weight, _defenseEffects, _sprite) : Item(_name, _durability, _staminaCost, _weight, ItemType.Armor, _defenseEffects, true, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
    stats = owner.stats;
    stamina = owner.stamina;
    armorValue = _armorValue;

    function Equip()
    {
        for(var i = 0; i < array_length(effects); i++) {
            stats.AddStat(effects[i]);
        }
    }

    function Unequip()
    {
        for(var i = 0; i < array_length(effects); i++) {
            stats.RemoveStat(effects[i]);
        }
    }

    function GetArmorValue()
    {
        durability -= 1;
        stamina.UseStamina(staminaCost);
        if (stamina.GetCurrentStamina() <= 0) {
            return 0;
        }

        if (durability <= 0) {
            owner.inventory.DeleteItem(self, 1);
            return 0;
        }

        return armorValue;
    }

    function GetCopy()
    {
        var copy = new ArmorItem(name, armorValue, durability, staminaCost, weight, effects, sprite);
        return copy;
    }
}