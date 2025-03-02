function Inventory() constructor 
{
    self.items = [];
    self.maxWeight = 100;
    self.currentWeight = 0;
    self.owner = other.id;
    
    function SetData(_maxWeight)
    {
        self.maxWeight = _maxWeight;
        
        return self;
    }
    
    function ContainsItem(_item)
    {
        for (var i = 0; i < array_length(self.items); i++)
        {
            if (self.items[i].CompareTo(_item))
            {
                return i;
            }
        }
        return -1;
    }
    
    function AddItem(_item, _itemCount)
    {
        var weight = _item.weight * _itemCount;
        if (weight > self.maxWeight)
        {
            return;
        }
        
        var index = ContainsItem(_item);
        if (index != -1) // item is in inventory already
        {
            self.items[index].AddCount(1);
        }
        else // item isn't in inventory
        {
            array_push(self.items, 
                new InventorySlot(_item, _itemCount));
        }
        
        self.currentWeight += weight;
        
        for (var i = 0; i < _itemCount; i++)
        {
            self.items[index].item.OnPickUp();
        }
    }
    
    function DropItem(_item, _itemCount)
    {
        var index = ContainsItem(_item);
        if (index == -1) 
        {
            return;
        }
        
        var weight = _item.weight * _itemCount;
        
        for (var i = 0; i < _itemCount; i++)
        {
             self.items[index].item.OnDrop();
        }
        
        var tempItem = instance_create_layer(self.owner.x, self.owner.y, "Items", obj_base_collectible);
        tempItem.Initialize(self.items[index].item, _itemCount);
        
        
        self.items[index].AddCount(-1 * _itemCount);        
        if (self.items[index].itemCount <= 0) // get rid of inventory slot if itemCount <= 0
        {
            array_delete(self.items, index, 1);
        }
        
        self.currentWeight -= weight;
        if (self.currentWeight < 0) self.currentWeight = 0;
    }
}

function InventorySlot(_item, _itemCount) constructor 
{
    self.item = _item;
    self.itemCount = _itemCount;
    
    function AddCount(_num) 
    {
        self.itemCount += _num;
    }
}

function Item() constructor 
{
    self.name = "";
    self.description = "";
    self.weight = 1;
    self.sprite = noone;
    
    function SetName(_name)
    {
        self.name = _name;
        return self;
    }
    function SetDescription(_desc)
    {
        self.description = _desc;
        return self;
    }
    function SetWeight(_w)
    {
        self.weight = _w;
        return self;
    }
    function SetSprite(_spr)
    {
        self.sprite = _spr;
        return self;
    }
    
    function CompareTo(_otherItem) 
    {
        return (_otherItem.name == self.name) 
            and (_otherItem.description == self.description)
            and (_otherItem.weight == self.weight)
            and (_otherItem.sprite == self.sprite); 
    }
    
    function OnPickUp() {}
    function OnDrop() {}
}