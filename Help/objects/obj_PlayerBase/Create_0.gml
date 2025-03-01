
playerIndex = array_length(global.vars.playerList);
array_push(global.vars.playerList, id);

forward = undefined;
backward = undefined;
leftWard = undefined;
rightWard = undefined;

interact = undefined;

spd = 4;
dir = 0;
moveX = 0;
moveY = 0;

doOnce = false;

collisionObjects = [obj_PlayerBase, obj_wall];

function SetControlScheme(_f, _b, _l, _r, _i)
{
    forward = _f;
    backward = _b;
    leftWard = _l;
    rightWard = _r;
    interact  = _i;
}

image_speed = 0;
image_index = 1;