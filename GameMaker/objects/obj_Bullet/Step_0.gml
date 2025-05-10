
if (!global.CanMove) return;

var xMove = lengthdir_x(___.moveSpeed, ___.direction);
var yMove = lengthdir_y(___.moveSpeed, ___.direction);

x += xMove;
y += yMove;

if (place_meeting(x, y, ___.targetObjects)) {
    var _hitObject = instance_place(x, y, ___.targetObjects);
    if (_hitObject != noone) {
        if (typeof(___.onHitCallback) == "function") 
        {
            ___.onHitCallback(_hitObject);
        }
        if (___.onHitObjectSummon != noone) 
        {
            instance_create_layer(x, y, layer, ___.onHitObjectSummon);
        }
        instance_destroy();
    }
    
    _hitObject.TakeDamage(irandom_range(3, 5));
}
image_angle = ___.direction;