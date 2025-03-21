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
        if (_count == 0) 
        {
            echo($"{_item.name} has not count...")
            return false;
        }
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
        currentWeight -= slot.item.weight * _count;

        if (slot.item.Equals(equippedWeapon)) equippedWeapon = undefined;
        else if (slot.item.Equals(equippedArmor)) equippedArmor = undefined;
        else if (slot.item.Equals(equippedBullet)) equippedBullet = undefined;

        return false;
    }

    function DeleteItem(_item, _count)
    {
        var index = ContainsItem(_item);
        if (index == -1) return false;
        RemoveItem(index, _count);
        return true;
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
}

function InventorySlot(_item, _quantity) constructor {
    item = _item;
    quantity = _quantity;
}