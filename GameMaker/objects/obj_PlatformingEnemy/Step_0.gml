if (!instance_exists(obj_PlatformingPlayer)) return;

___.angle = point_direction(x, y, obj_PlatformingPlayer.x, obj_PlatformingPlayer.y);

if (obj_PlatformingPlayer.image_index == 1) return; 


if (point_distance(x, y, obj_PlatformingPlayer.x, obj_PlatformingPlayer.y) < 128)
{
    canShoot = true;
}
else {
    canShoot = false;
}

if (canShoot)
{
    _counter++;
    
    if (_counter >= (3 * 60))
    {
        _counter = 0;
        
        var _angle = ___.angle + random_range(-2, 2);
        var _bullet = instance_create_depth(x, y, depth - 1, obj_EditingBullet);
        _bullet.Init(
            2 + irandom_range(-1, 1), 
            function(_hitObject) { _hitObject.TakeDamage(irandom_range(3, 5)); },
            _angle, [obj_PlatformingPlayer]
        );
        
    }
}

