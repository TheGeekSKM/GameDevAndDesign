// Inherit the parent event
event_inherited();

stats.Step();
entityHealth.Step();

if (entityHealth.IsDead()) instance_destroy(id);

inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

if (canAttack) attack.Step();
