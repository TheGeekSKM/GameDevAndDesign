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
    armorValue = _armorValue;

    function GetArmorValue()
    {
        return armorValue;
    }
}

/// @desc This is the struct that holds the stats for the Inventory
/// @param {Struct} _stats these are the stats for the entity
/// @param {Id} _owner this is the id of the entity
function Inventory(_stats, _owner) constructor {
    allItems = [];
    stats = _stats;
    
    equippedWeapon = undefined;
    equippedArmor = undefined;
    equippedBullet = undefined;
    
    currentWeight = 0;
    maxWeight = stats.GetMaxCarryWeight();

    owner = _owner;

    ///@desc Checks to see if item already exists in inventory
    ///@param {Struct} _item - The item to check for
    ///@return real - The index of the item in the inventory, or -1 if it doesn't exist
    function ContainsItem(_item)
    {
        for (var i = 0; i < array_length(allItems); i += 1) 
        {
            if (allItems[i].item.Equals(_item)) return i;
        }
        return -1;
    }

    ///@desc Adds an item to the inventory
    ///@param {Struct} _item - The item to add
    ///@param {real} _count - The quantity of the item to add
    ///@return bool - True if the item was added, false if it couldn't be added
    function AddItem(_item, _count)
    {
        var index = ContainsItem(_item);
        if (index == -1) 
        {
            var slot = new InventorySlot(_item, _count);
            array_push(allItems, slot);
        }
        else 
        {
            allItems[index].quantity += _count;
        }
        currentWeight += _item.weight * _count;

        for (var i = 0; i < _count; i += 1) {
            _item.PickUp(owner);
        }
        return true;
    }

    ///@desc Uses an item from the inventory
    ///@param {Struct} _item - The item to use
    ///@param {real} _count - The quantity of the item to use
    ///@return bool - True if the item was used, false if it couldn't be used
    function UseItem(_item, _count)
    {
        var index = ContainsItem(_item);
        if (index == -1) return false;

        var totalStaminaCost = _item.staminaCost * _count;
        if (owner.stamina.currentStamina < totalStaminaCost) return false;

        var slot = allItems[index];
        if (slot.quantity < _count) return false;
        
        var brokenItem = false;
        for (var i = 0; i < _count; i += 1) {
            brokenItem = !slot.item.Use();
        }

        if (brokenItem) RemoveItem(index, _count);
        return true;
    }

    ///@desc Drops an item from the inventory
    ///@param {Struct} _item - The item to drop
    ///@param {real} _count - The quantity of the item to drop
    ///@return bool - True if the item was dropped, false if it couldn't be dropped
    function DropItem(_item, _count)
    {
        var index = ContainsItem(_item);
        if (index == -1) return false;

        var slot = allItems[index];
        if (slot.quantity < _count) return false;
        
        for (var i = 0; i < _count; i += 1) {
            slot.item.Drop();
        }

        RemoveItem(index, _count);
        return true;
    }

    ///@desc Removes an item from the inventory
    ///@param {real} _itemIndex - The index of the slot which contains the item to remove
    ///@param {real} _count - The quantity of the item to remove from the slot
    ///@return bool - True if the slot was deleted, false if the slot was updated
    function RemoveItem(_itemIndex, _count)
    {
        var slot = allItems[_itemIndex];
        if (slot.quantity < _count) {array_delete(allItems, _itemIndex, 1); return true; }

        slot.quantity -= _count;
        if (slot.quantity == 0) {array_delete(allItems, _itemIndex, 1); return true;}
        currentWeight -= slot.item.weight * _count;
        return false;
    }
    
    function GetCurrentWeight()
    {
        return currentWeight;
    }

    function GetEquippedWeapon()
    {
        return equippedWeapon;
    }
    
    function GetEquippedArmor()
    {
        return equippedArmor;
    }

    function Step()
    {
        maxWeight = stats.GetMaxCarryWeight();
    }
}

function InventorySlot(_item, _quantity) constructor {
    item = _item;
    quantity = _quantity;
}