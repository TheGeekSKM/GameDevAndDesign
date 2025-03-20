bulletItem = undefined;
targets = [];
damage = 0;
damageType = DamageType.PHYSICAL;
shooter = noone;

function SetBulletData(_bulletItem, _targets, _direction)
{
    bulletItem = _bulletItem;
    targets = _targets;
    direction = _direction;
    speed = _bulletItem.speed;
    damage = _bulletItem.damage;
    damageType = _bulletItem.damageType;
    shooter = _bulletItem.owner;
}