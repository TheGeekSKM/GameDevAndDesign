stats.Step();
entityHealth.Step();
inventory.Step();
stamina.Step();
entityData.Step();
hunger.Step();

if (canAttack) attack.Step();

if (instance_place(x, y, obj_ItemReq_SiliconDeposit)) entityData.slowed = true;
else entityData.slowed = false;
