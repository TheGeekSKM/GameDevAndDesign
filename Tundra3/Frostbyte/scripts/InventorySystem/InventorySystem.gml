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
            if (allItems[i].item[$ "name"] == _item[$ "name"]) return i;
        }
        return -1;
    }

    ///@desc Adds an item to the inventory
    ///@param {Struct} _item - The item to add
    ///@param {real} _count - The quantity of the item to add
    ///@return {Struct} - the item if the item was added, undefined if it couldn't be added
    function AddItem(_item, _count = 1, _showPopUp = true)
    {
        var item = _item.GetCopy();
        if (_count == 0) 
        {
            echo($"{item.name} has not count...")
            return undefined;
        }
        var index = ContainsItem(item);
        if (index == -1) 
        {
            var slot = new InventorySlot(item, _count);
            array_push(allItems, slot);
        }
        else 
        {
            allItems[index].quantity += _count;
        }
        currentWeight += item.weight * _count;

        for (var i = 0; i < _count; i += 1) {
            item.PickUp(self.owner);
        }

        if (variable_instance_exists(owner, "isPlayer") and _showPopUp)
        {
            var popUp = instance_create_layer(owner.x, owner.y, "GUI", obj_PopUpText);
            popUp.Init($"Picked Up {_item.name} x{_count}");
        }
                
        return _item;
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
        
        for (var i = 0; i < _count; i += 1) {
            slot.item.InventoryUse();
        }

        return true;
    }

    function UseItemByIndex(_index, _count, _PlayerIndex = 0)
    {
        if (_index < 0 or _index >= array_length(allItems)) return false;
        var slot = allItems[_index];
        if (slot.quantity < _count) return false;
        
        for (var i = 0; i < _count; i += 1) {
            slot.item.InventoryUse();
        }

        if (slot.quantity == 0) array_delete(allItems, _index, 1);

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
        
        if (variable_instance_exists(owner, "isPlayer"))
        {
            var popUp = instance_create_layer(owner.x, owner.y, "GUI", obj_PopUpText);
            popUp.Init($"Dropped {_item.name} x{_count}");
        }   
        
        if (_item.equipped) Unequip(_item);
        RemoveItem(index, _count);

        var itemCol = instance_create_layer(owner.x, owner.y, "Interactables", obj_BASE_Collectible);
        itemCol.Initialize(_item, _count);

        return true;
    }

    function DropItemByIndex(_index, _count)
    {
        if (_index < 0 or _index >= array_length(allItems)) return false;
        var slot = allItems[_index];
        if (slot.quantity < _count) return false;
        
        for (var i = 0; i < _count; i += 1) {
            slot.item.Drop();
        }

        if (variable_instance_exists(owner, "isPlayer"))
        {
            var popUp = instance_create_layer(owner.x, owner.y, "GUI", obj_PopUpText);
            popUp.Init($"Dropped {slot.item.name} x{_count}");
        }    
        
        if (slot.item.equipped) Unequip(slot.item);
        RemoveItem(_index, _count);

        var itemCol = instance_create_layer(owner.x, owner.y, "Interactables", obj_BASE_Collectible);
        itemCol.Initialize(slot.item, _count);


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
        currentWeight -= slot.item.weight * _count;

        if (slot.item.Equals(equippedWeapon)) equippedWeapon = undefined;
        else if (slot.item.Equals(equippedArmor)) equippedArmor = undefined;
        else if (slot.item.Equals(equippedBullet)) equippedBullet = undefined;

        if (slot.quantity == 0) {
            echo($"Removing {slot.item.name}'s slot from inventory");
            array_delete(allItems, _itemIndex, 1);
        }

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

    function GetEquippedBullet()
    {
        return equippedBullet;
    }

    function Step()
    {
        maxWeight = stats.GetMaxCarryWeight();
        
        for (var i = 0; i < array_length(self.allItems); i++) {
            self.allItems[i].item.owner = owner;
        }
    }

    function ToString()
    {
        var str = $"Owner: {owner}\nWeight: {currentWeight}/{maxWeight}\n";
        for (var i = 0; i < array_length(allItems); i += 1) 
        {
            str = string_concat(str, allItems[i].item.name, " x", string(allItems[i].quantity), "\n");
        }
        return str;
    }

    function GetTotalDamage()
    {
        var totalDamage = 0;
        if (equippedWeapon != undefined and equippedWeapon.GetWeaponType() == WeaponType.Melee) totalDamage += equippedWeapon.damage;
        if (equippedBullet != undefined) totalDamage += equippedBullet.damage;
        return totalDamage;
    }

    function GetWeaponAttackSpeed()
    {
        if (equippedWeapon == undefined) return 0;
        if (equippedWeapon.GetWeaponType() == WeaponType.Melee) return stats.GetMeleeAttackSpeed();
        else return stats.GetRangedAttackSpeed();
    }

    function GetDefense()
    {
        defense = 0;
        if (equippedArmor != undefined) defense += equippedArmor.armorValue;
        defense += stats.GetNaturalResistance();
        return defense;
    }

    function Equip(_item)
    {
        if (_item == undefined) return;
        var index = ContainsItem(_item);
        if (index == -1) return;

        var slot = allItems[index];
        if (slot.item.type == ItemType.Weapon) {Unequip(equippedWeapon); equippedWeapon = slot.item;}
        else if (slot.item.type == ItemType.Armor) {Unequip(equippedArmor); equippedArmor = slot.item;}
        else if (slot.item.type == ItemType.Bullet) {Unequip(equippedBullet); equippedBullet = slot.item;}

        slot.item.Equip();
    }

    function Unequip(_item)
    {
        if (_item == undefined) return;
        var index = ContainsItem(_item);
        if (index == -1) return;

        var slot = allItems[index];
        if (slot.item.type == ItemType.Weapon) equippedWeapon = undefined;
        else if (slot.item.type == ItemType.Armor) equippedArmor = undefined;
        else if (slot.item.type == ItemType.Bullet) equippedBullet = undefined;

        slot.item.Unequip();
    }

    function DropAllItems()
    {
        for (var i = array_length(allItems) - 1; i >= 0; i -= 1) 
        {
            DropItemByIndex(i, allItems[i].quantity);
        }
    }
}

function InventorySlot(_item, _quantity) constructor {
    item = _item;
    quantity = _quantity;
}