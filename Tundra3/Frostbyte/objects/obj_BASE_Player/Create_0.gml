isUndead = false;
canAttack = false;
canMove = true;

collisionObjects = [];
doOnce = false;

stats = global.vars.PlayerStats[PlayerIndex];
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

controller = new PlayerController(id);