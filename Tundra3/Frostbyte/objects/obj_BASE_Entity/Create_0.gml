isUndead = false;
canAttack = false;

stats = new StatSystem(irandom_range(3, 8), irandom_range(3, 8), irandom_range(3, 8));
inventory = new Inventory(stats, id);
entityHealth = new HealthSystem(stats, inventory, isUndead, id);
stamina = new StaminaSystem(stats, id);
hunger = new HungerSystem(stats, id);
attack = new AttackSystem(stats, inventory, id);

entityData = {
    moveSpeed: stats.GetMoveSpeed(inventory.GetCurrentWeight()),
    
    Step: function() {
        moveSpeed = stats.GetMoveSpeed(inventory.GetCurrentWeight());
    },
}