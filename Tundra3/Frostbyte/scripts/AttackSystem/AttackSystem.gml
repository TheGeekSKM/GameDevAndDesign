function AttackSystem(_stats, _inventory, _owner, _enemyObject = noone) constructor {
    inventory = _inventory;
    stats = _stats;
    owner = _owner;
    enemyObject = _enemyObject;

    attackTimer = 0;
    attackCooldown = 0.5;

    function GetAttackCooldownPercentage() {
        return attackTimer / attackCooldown;
    }

    closestEnemy = noone;

    function Attack() {
        if (inventory.GetEquippedWeapon() == undefined) return;

        var weapon = inventory.GetEquippedWeapon();
        var damage = weapon.GetDamage();
        switch (weapon.GetWeaponType())
        {
            case WeaponType.Melee:
                damage += stats.GetMeleeDamage();
                show_debug_message($"Spawn a melee attack object with damage: {damage}");
                break;
            case WeaponType.Ranged:
                damage += stats.GetRangedDamage();
                show_debug_message($"Spawn a ranged attack object with damage: {damage} and aim it towards {closestEnemy}");
                break;
        }
    }

    function Step()
    {
        if (enemyObject == noone) return;
        closestEnemy = instance_nearest(owner.x, owner.y, enemyObject);
        if (closestEnemy == undefined) return;

        var weapon = inventory.GetEquippedWeapon();
        if (weapon != undefined)
        {
            switch (weapon.GetWeaponType())
            {
                case WeaponType.Melee:
                    attackCooldown = game_get_speed(gamespeed_fps) / stats.GetMeleeAttackSpeed();
                    break;
                case WeaponType.Ranged:
                    attackCooldown = game_get_speed(gamespeed_fps) / stats.GetRangedAttackSpeed();
                    break;
            }
        }

        attackTimer++;
        if (attackTimer >= attackCooldown)
        {
            attackTimer = 0;
            Attack();
        }
    }
}