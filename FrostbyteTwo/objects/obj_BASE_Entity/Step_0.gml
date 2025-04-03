// Inherit the parent event
event_inherited();

stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

if (canAttack) attack.Step();
