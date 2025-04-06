function ItemReciever(_itemSlots) constructor 
{
    desiredItems = _itemSlots;
    successCallbacks = [];
    unsatisfiedCallbacks = [];
    unsuccessCallbacks = [];
    currentlyRecievedItems = [];
    
    function DropItem(_item, _count)
    {
        for (var i = 0; i < array_length(desiredItems); i++) 
        {
            if (desiredItems[i].item[$ "name"] == _item[$ "name"])
            {
                if (_count > desiredItems[i].quantity)
                {
                    // Overflow, just fully satisfy this slot
                    currentlyRecievedItems[i] = new InventorySlot(_item, desiredItems[i].quantity);
                    _count -= desiredItems[i].quantity;
                    desiredItems[i].quantity = 0;
                }
                else 
                {
                    // Partial or exact fill
                    currentlyRecievedItems[i] = new InventorySlot(_item, _count);
                    desiredItems[i].quantity -= _count;
                    _count = 0;
                }

                // Check if ALL slots are fulfilled
                var allFulfilled = true;
                for (var j = 0; j < array_length(desiredItems); j++) 
                {
                    if (desiredItems[j].quantity > 0) 
                    {
                        allFulfilled = false;
                        break;
                    }
                }

                if (allFulfilled)
                {
                    Success(_item, _count);
                }
                else
                {
                    // If the slot is now fulfilled or partially filled
                    Unsatisfied(_item, _count);
                }

                return true;
            }
        }

        Unsuccess(_item);
        return false;
    }

    function Success(_item, _count)
    {
        for (var i = 0; i < array_length(successCallbacks); i++) {
            successCallbacks[i](_item, _count);
        }
    }

    function Unsatisfied(_item, _count)
    {
        for (var i = 0; i < array_length(unsatisfiedCallbacks); i++) {
            unsatisfiedCallbacks[i](_item, _count);
        }
    }

    function Unsuccess(_item)
    {
        for (var i = 0; i < array_length(unsuccessCallbacks); i++) {
            unsuccessCallbacks[i](_item);
        }
    }
    function AddSuccessCallback(_callback)
    {
        array_push(successCallbacks, _callback);
        return self;
    }

    function AddUnsatisfiedCallback(_callback)
    {
        array_push(unsatisfiedCallbacks, _callback);
        return self;
    }

    function AddUnsuccessCallback(_callback)
    {
        array_push(unsuccessCallbacks, _callback);
        return self;
    }

    function ModifyDesiredItems(_item, _quantity)
    {
        for (var i = 0; i < array_length(desiredItems); i++) {
            if (desiredItems[i].item[$ "name"] == _item[$ "name"]) {
                desiredItems[i].quantity = _quantity;
                return self;
            }
        }

        array_push(desiredItems, new InventorySlot(_item, _quantity));
        return self;
    }
}