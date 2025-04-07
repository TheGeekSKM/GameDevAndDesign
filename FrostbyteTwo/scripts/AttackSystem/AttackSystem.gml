function AttackSystem(_stats, _inventory, _owner, _enemyObject = noone) : Component("attack") constructor {
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
        var didAttack = weapon.Use();
        
        if (variable_instance_exists(owner, "PlayerIndex") && didAttack)
        {
            var damage = inventory.GetTotalDamage();
            
            var camShakeAmount = round(1 + (damage / 40) * 9);
            with (obj_camera) {
                AddCameraShake(camShakeAmount * 0.75);
            }
        }
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