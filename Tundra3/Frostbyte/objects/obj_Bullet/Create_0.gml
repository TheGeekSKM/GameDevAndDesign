bulletItem = undefined;
targets = [];
damage = 0;
damageType = DamageType.PHYSICAL;
shooter = noone;
hitObjectList = ds_list_create();
hitMultiple = false;

function SetBulletData(_bulletItem, _speed, _targets, _direction)
{
    bulletItem = _bulletItem;
    targets = _targets;
    direction = _direction;
    image_angle = _direction;
    speed = _speed;
    damage = _bulletItem.damage;
    damageType = _bulletItem.damageType;
    shooter = _bulletItem.owner;
    alarm[0] = _bulletItem.lifeTime;
    hitMultiple = _bulletItem.hitMultiple;
}