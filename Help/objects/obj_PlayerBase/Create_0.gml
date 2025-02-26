
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

collisionObjects = [obj_PlayerBase];

function SetControlScheme(_f, _b, _l, _r, _i)
{
    forward = _f;
    backward = _b;
    leftWard = _l;
    rightWard = _r;
    interact  = _i;
}

image_speed = 0;
image_index = 0;