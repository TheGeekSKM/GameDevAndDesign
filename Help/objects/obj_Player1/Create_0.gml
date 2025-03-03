// Inherit the parent event
event_inherited();


SetControlScheme(ord("W"), ord("S"), ord("A"), ord("D"), ord("E"), vk_lshift);
attributes = global.vars.attributesOne;
spd = attributes.Dexterity;
playerHealth = attributes.Constitution * 15;

attackRange = 50;
attackCooldown = 0;
attackSpeed = max(10, 60 - (attributes.Dexterity * 4));
attackDamage = attributes.Strength * 2;