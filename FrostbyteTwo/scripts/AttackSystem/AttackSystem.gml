function AttackSystem(_stats, _inventory, _owner, _enemyObject = noone) constructor {
    inventory = _inventory;
    stats = _stats;
    owner = _owner;
    enemyObject = _enemyObject;

    attackTimer = 0;
    attackCooldown = 0;
    attackDirection = 0;

    function GetAttackCooldownPercentage() {
        return attackTimer / attackCooldown;
    }

    function Attack(_attackPoint) {
        if (inventory.GetEquippedWeapon() == undefined) 
        {
            if (variable_instance_exists(owner, "PlayerIndex"))
                Raise("NotificationOpen", ["You have no weapon equipped in your inventory.", owner.PlayerIndex]);
            return;
        }

        var weapon = inventory.GetEquippedWeapon();
        weapon.Use();
    }

    function Step(_attackPoint, _attackDirection)
    {

        var weapon = inventory.GetEquippedWeapon();
        if (weapon != undefined)
        {
            attackCooldown = inventory.GetWeaponAttackSpeed() * 60;
        }
        
        self.attackDirection = _attackDirection;
        if (attackCooldown <= 0) attackCooldown = 60;
        attackTimer++;
        if (attackTimer >= attackCooldown)
        {
            attackTimer = 0;
            Attack(_attackPoint);
        }
    }
}