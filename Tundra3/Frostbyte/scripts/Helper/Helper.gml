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