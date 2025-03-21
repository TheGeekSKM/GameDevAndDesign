function Item(_name, _durability, _staminaCost, _weight, _type, _effects, _equippable, _sprite) constructor 
{
    name = _name;
    type = _type;
    effects = _effects;
    equippable = _equippable;
    owner = noone;
    durability = _durability;
    weight = _weight;
    staminaCost = _staminaCost;
    sprite = _sprite;

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