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