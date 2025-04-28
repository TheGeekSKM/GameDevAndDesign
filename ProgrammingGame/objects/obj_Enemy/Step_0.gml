___.canMove = global.CanMove;

if (___.currentHealth <= 0) image_index = 1;
else image_index = 0;
    
___.angle = point_direction(x, y, obj_Player.x, obj_Player.y);

if (!___.canMove) return;

if (point_distance(x, y, obj_Player.x, obj_Player.y) < 128)
{
    canShoot = true;
}
else {
    canShoot = false;
}

if (canShoot)
{
    _counter++;
    
    if (_counter >= (1.25 * 60))
    {
        _counter = 0;
        
        var _angle = ___.angle + random_range(-2, 2);
        var _bullet = instance_create_depth(x, y, depth - 1, obj_Bullet);
        _bullet.Init(
            2 + irandom_range(-1, 1), 
            function(_hitObject) { _hitObject.TakeDamage(irandom_range(3, 5)); },
            _angle, [obj_Player]
        );
        
    }
}