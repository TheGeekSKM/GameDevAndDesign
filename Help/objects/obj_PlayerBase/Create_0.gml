
playerIndex = array_length(global.vars.playerList);
array_push(global.vars.playerList, id);

forward = undefined;
backward = undefined;
leftWard = undefined;
rightWard = undefined;

interact = undefined;

dir = 0;
moveX = 0;
moveY = 0;

doOnce = false;

collisionObjects = [obj_wall];
inventory = new Inventory().SetData(20);

attributes = new Attributes().Initialize();
attributes.AddAttrChangeCallback(function(_statType) {
    switch(_statType)
    {
        case AttributeType.Strength:
            break;
        case AttributeType.Dexterity:
            spd = attributes.Dexterity;
            break;
        case AttributeType.Constitution:
            break;
    }    
})

spd = attributes.Dexterity;

function SetControlScheme(_f, _b, _l, _r, _i)
{
    forward = _f;
    backward = _b;
    leftWard = _l;
    rightWard = _r;
    interact  = _i;
}



tempInteractableList = ds_list_create();
interactableList = [];
interactionRange = 20;

sprite_index = spr_human;
image_blend = global.vars.playerColors[playerIndex];
image_speed = 0;
image_index = 1;