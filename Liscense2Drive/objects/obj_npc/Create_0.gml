randomize();
image_blend = make_color_rgb(irandom_range(0, 255), irandom_range(0, 255), irandom_range(0, 255));
image_speed = 0;

image_angle = random(360);

enum NPCState 
{
    Idle,
    WantToWalk,
    Walking
}

if (random(100) > 50)
{
    currentState = NPCState.Idle;
}
else 
{
    currentState = NPCState.WantToWalk;
}
targetPos = new Vector2(x, y);

spd = 1;

_playerWithinRange = false;

bounds = collision_rectangle(
        x - (sprite_width / 2), y - (sprite_height / 2), 
        x + (sprite_width / 2), y + (sprite_height / 2),
        obj_bounds, false, false 
        );

walkCounter = 0;
walkRange = new Vector2(0.2, 30);
currentStandTime = irandom_range(walkRange.x, walkRange.y);
stopRange = 5;

walkTime = 10;
walkingCounter = 0;


SetPlayerWithinRange = function(_bool)
{
    _playerWithinRange = _bool;
}

RotateToPlayer = function()
{
    var dir = point_direction(x, y, obj_player.x, obj_player.y);
    dir = ClampAngle90(dir);
    image_angle = dir;
}

///@pure
function ClampAngle90(_angle)
{
    return round(_angle / 90) * 90;
}

