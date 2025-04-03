function BulletItem(_name, _hitMultiple, _lifeTime, _damage, _damageType, _weight, _hitFunctions, _sprite) : Item(_name, -1, 0, _weight, ItemType.Bullet, [], true, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system
    damage = _damage;
    damageType = _damageType;
    hitFunctions = _hitFunctions;
    lifeTime = _lifeTime * game_get_speed(gamespeed_fps);
    hitMultiple = _hitMultiple;

    ///@param {Vector2} _position - The position where the bullet hit
    function Use(_position)
    {
        for (var i = 0; i < array_length(hitFunctions); i++) {
            hitFunctions[i](_position);
        }
    }

    function Equip() {
        equipped = true;
    }

    function Unequip() {
        equipped = false;
    }

    function GetCopy()
    {
        var copy = new BulletItem(name, hitMultiple, lifeTime, damage, damageType, weight, hitFunctions, sprite);
        return copy;
    }

    function InventoryUse()
    {
        if (equipped) {
            owner.inventory.Unequip(self);
        }
        else {
            owner.inventory.Equip(self);
        }
    }

    function GetDescription() {
        var desc = $"Item: {name}\n";
        desc = string_concat(desc, $"Bullet Damage: {damage}\n");
        desc = string_concat(desc, $"Damage Type: {damageType}\n");
        desc = string_concat(desc, $"Life Time: {lifeTime}\n");
        return desc;
    }

}