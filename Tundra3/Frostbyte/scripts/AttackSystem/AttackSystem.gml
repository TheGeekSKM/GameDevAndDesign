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
            show_debug_message("No weapon equipped");
            return;
        }

        var weapon = inventory.GetEquippedWeapon();
        var damage = weapon.GetDamage();
        switch (weapon.GetWeaponType())
        {
            case WeaponType.Melee:
                damage += stats.GetMeleeDamage();
                show_debug_message($"Spawn a melee attack object with damage: {damage} at point {_attackPoint}");
                break;
            case WeaponType.Ranged:
                damage += stats.GetRangedDamage();
                show_debug_message($"Spawn a ranged attack object with damage: {damage} at {_attackPoint} and aim it towards {self.attackDirection}");
                break;
        }
    }

    function Step(_attackPoint, _attackDirection)
    {

        var weapon = inventory.GetEquippedWeapon();
        if (weapon != undefined)
        {
            switch (weapon.GetWeaponType())
            {
                case WeaponType.Melee:
                    attackCooldown = game_get_speed(gamespeed_fps) / (stats.GetMeleeAttackSpeed() + (weapon.GetItemRotationAffector() * 2));
                    break;
                case WeaponType.Ranged:
                    attackCooldown = game_get_speed(gamespeed_fps) / (stats.GetRangedAttackSpeed() + (weapon.GetItemRotationAffector() * 2));
                    break;
            }
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