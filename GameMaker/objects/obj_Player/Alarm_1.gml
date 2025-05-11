var _angle = ___.angle + random_range(-2, 2);
var _bullet = instance_create_depth(x, y, depth - 1, obj_PlayerBullet);
TakeDamage(3, true);
_bullet.Init(
    3 + irandom_range(-1, 1), 
    function(_hitObject) { _hitObject.TakeDamage(irandom_range(3, 5)); },
    _angle, [obj_Enemy]
);

___.numberOfShots -= 1;
if (___.numberOfShots >= 0) alarm[1] = ___.shootSpeed;
else {
    global.PlayerCurrentlyActing = false;
}