function ItemReciever(_itemSlots) constructor 
{
    desiredItems = _itemSlots;
    successCallbacks = [];
    unsatisfiedCallbacks = [];
    unsuccessCallbacks = [];
    
    function DropItem(_item, _count)
    {
        for (var i = 0; i < array_length(desiredItems); i++) {
            if (desiredItems[i].item[$ "name"] == _item[$ "name"])
            {
                if (_count > desiredItems[i].quantity)
                {
                    Success();
                    return true;
                }
                else 
                {
                    Unsatisfied();
                    return true;
                }
            }
        }
        Unsuccess();
        return false;
    }

    function Success()
    {
        for (var i = 0; i < array_length(successCallbacks); i++) {
            successCallbacks[i]();
        }
    }

    function Unsatisfied()
    {
        for (var i = 0; i < array_length(unsatisfiedCallbacks); i++) {
            unsatisfiedCallbacks[i]();
        }
    }

    function Unsuccess()
    {
        for (var i = 0; i < array_length(unsuccessCallbacks); i++) {
            unsuccessCallbacks[i]();
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