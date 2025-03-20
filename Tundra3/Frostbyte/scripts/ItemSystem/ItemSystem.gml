enum ItemType
{
    Consumable,
    Weapon,
    Bullet,
    Armor
}

enum WeaponType
{
    Melee,
    Ranged
}

function StatusEffects(_statType, _value, _time) constructor {
    statType = _statType;
    value = _value;
    time = _time * game_get_speed(gamespeed_fps);
}


function Item(_name, _durability, _staminaCost, _weight, _type, _effects, _equippable) constructor 
{
    name = _name;
    type = _type;
    effects = _effects;
    equippable = _equippable;
    owner = noone;
    durability = _durability;
    weight = _weight;
    staminaCost = _staminaCost;

    // override this function in child classes
    function Use() {}
    function PickUp(_owner) {
        owner = _owner;
    }
    function Drop() {
        owner = noone;
    }
    function Equip() {} 
    function Unequip() {}
    
    ///@desc Returns a string with the item's name and effects
    ///@return string
    function GetDescription() {
        var desc = $"Item: {name}\n";
        for (var i = 0; i < array_length(effects); i++) {
            desc = string_concat(desc, $"Effect #{i + 1}: {effects[i].value} {effects[i].statType}\n");
        }
        return desc;
    }

    function GetItemRotationAffector()
    {
        var minWeight = 1, maxWeight = 5;
        var minValue = 0.4, maxValue = 1;
        return maxValue - ((weight - minWeight) / (maxWeight - minWeight)) * (maxValue - minValue);
    }

    function GetItemType()
    {
        return type;
    }

    function Equals(_item)
    {
        if (_item == undefined) return false;
        var sameName = name == _item.name;
        var sameType = type == _item.type;
        var sameEffects = array_length(effects) == array_length(_item.effects);
        return sameName and sameType and sameEffects;
    }
}

function ConsumableItem(_name, _durability, _staminaCost, _weight, _consumeEffects) : Item(_name, _durability, _staminaCost, _weight, ItemType.Consumable, _consumeEffects, false) constructor {
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

function WeaponItem(_name, _weaponType, _durability, _staminaCost, _weight, _attackEffects) : Item(_name, _durability, _staminaCost, _weight, ItemType.Weapon, _attackEffects, true) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
    weaponType = _weaponType;

    function GetWeaponType()
    {
        return weaponType;
    }
}

function MeleeWeaponItem(_name, _durability, _staminaCost, _weight, _attackEffects) : WeaponItem(_name, WeaponType.Melee, _durability, _staminaCost, _weight, _attackEffects) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
}

function RangedWeaponItem(_name, _durability, _staminaCost, _weight, _attackEffects) : WeaponItem(_name,, WeaponType.Ranged, _durability, _staminaCost, _weight, _attackEffects) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
}

function BulletItem(_name, _durability, _staminaCost, _weight, _attackEffects) : Item(_name, _durability, _staminaCost, _weight, ItemType.Bullet, _attackEffects, true) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system
}

function ArmorItem(_name, _armorValue, _durability, _staminaCost, _weight, _defenseEffects) : Item(_name, _durability, _staminaCost, _weight, ItemType.Armor, _defenseEffects, true) constructor {
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

        if (durability <= 0) {
            owner.inventory.DeleteItem(self, 1);
            delete self;
            return 0;
        }

        return armorValue;
    }
}

