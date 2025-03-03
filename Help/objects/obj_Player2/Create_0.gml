// Inherit the parent event
event_inherited();


SetControlScheme(vk_up, vk_down, vk_left, vk_right, vk_rcontrol, vk_numpad0);
attributes = global.vars.attributesTwo;
spd = attributes.Dexterity;
playerHealth = attributes.Constitution * 15;

attackRange = 50;
attackCooldown = 0;
attackSpeed = max(10, 60 - (attributes.Dexterity * 4));
attackDamage = attributes.Strength * 2;

attributes.AddAttrChangeCallback(function(_statType, _statAmount) {
    switch(_statType)
    {
        case AttributeType.Strength:
            var text = instance_create_depth(x, y, 0, obj_pickUpText);
            text.Init(string_concat("Strength Modified by ", _statAmount));
            attackDamage = attributes.Strength * 2;
            break;
        case AttributeType.Dexterity:
            var text1 = instance_create_depth(x, y, 0, obj_pickUpText);
            text1.Init(string_concat("Dexterity Modified by ", _statAmount));
            spd = attributes.Dexterity;
            attackSpeed = max(10, 60 - (attributes.Dexterity * 4));
            break;
        case AttributeType.Constitution:
            var text2 = instance_create_depth(x, y, 0, obj_pickUpText);
            text2.Init(string_concat("Constitution Modified by ", _statAmount));            
            playerHealth = attributes.Constitution * 10;
            break;
    }    
})