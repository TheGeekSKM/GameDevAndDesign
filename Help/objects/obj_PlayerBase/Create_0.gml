
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
inputPause = false;



collisionObjects = [obj_wall, obj_computer];
inventory = new Inventory().SetData(20);

attributes = new Attributes().Initialize();
attributes.AddAttrChangeCallback(function(_statType, _amount) {
    echo("change");
    switch(_statType)
    {
        case AttributeType.Strength:
            var text = instance_create_depth(x, y, 0, obj_pickUpText);
            text.Init(string_concat("Strength Modified"));
            echo("str")
            attackDamage = attributes.Strength * 2;
            break;
        case AttributeType.Dexterity:
            var text1 = instance_create_depth(x, y, 0, obj_pickUpText);
            text1.Init(string_concat("Dexterity Modified"));
            echo("Dex")        
            spd = attributes.Dexterity;
            attackSpeed = max(10, 60 - (attributes.Dexterity * 4));
            break;
        case AttributeType.Constitution:
            var text2 = instance_create_depth(x, y, 0, obj_pickUpText);
            echo("con")        
            text2.Init(string_concat("Constitution Modified"));            
            playerHealth = attributes.Constitution * 10;
            break;
    }    
})


attackRange = 100;
attackCooldown = 0;
attackSpeed = max(10, 60 - (attributes.Dexterity * 4));
attackDamage = attributes.Strength * 2;

spd = attributes.Dexterity;

function SetControlScheme(_f, _b, _l, _r, _i, _m)
{
    forward = _f;
    backward = _b;
    leftWard = _l;
    rightWard = _r;
    interact  = _i;
    menu = _m;
}



tempInteractableList = ds_list_create();
interactableList = [];
interactionRange = 20;

sprite_index = spr_human;
image_blend = global.vars.playerColors[playerIndex];
image_speed = 0;
image_index = 1;

playerHealth = attributes.Constitution * 10;

function TakeDamage(_dmg)
{
    if (playerHealth - _dmg <= 0)
    {
        Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    }
    else {
        playerHealth -= _dmg;
    }
}