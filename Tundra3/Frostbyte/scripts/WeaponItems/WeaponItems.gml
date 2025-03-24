function WeaponItem(_name, _weaponType, _durability, _staminaCost, _weight, _equipEffects, _sprite) : Item(_name, _durability, _staminaCost, _weight, ItemType.Weapon, _equipEffects, true, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
    weaponType = _weaponType;

    function GetWeaponType()
    {
        return weaponType;
    }

    function Equip()
    {
        for(var i = 0; i < array_length(effects); i++) {
            owner.stats.AddStat(effects[i]);
        }
        equipped = true;
    }

    function Unequip()
    {
        for(var i = 0; i < array_length(effects); i++) {
            owner.stats.RemoveStat(effects[i]);
        }
        equipped = false;
    }

    function InventoryUse()
    {
        if (equipped) {
            owner.inventory.Unequip(self);
        }
        else {
            owner.inventory.Equip(self);
        }
    }

    function GetDamage()
    {
        return 0;
    }
    
}

function MeleeWeaponItem(_name, _color, _durability, _damage, _damageType, _staminaCost, _weight,  _equipEffects, _sprite) : WeaponItem(_name, WeaponType.Melee, _durability, _staminaCost, _weight, _equipEffects, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
    damage = _damage;
    damageType = _damageType;
    color = _color;

    function Use()
    {
        if (owner.stamina.GetStamina() <= staminaCost) {
            return;
        }
        else
        {
            owner.stamina.UseStamina(staminaCost);
        }

        var meleeSwing = new BulletItem($"{name}'s Swing", true, 0.5, damage, damageType, 0, [], spr_meleeSlash);
        meleeSwing.owner = self.owner;
        
        var meleeSwingObject = instance_create_layer(owner.x, owner.y, "MeleeSwing", obj_Bullet);
        meleeSwingObject.SetBulletData(meleeSwing, 0, owner.targets, owner.image_angle);
        meleeSwingObject.sprite_index = spr_meleeSlash;
        meleeSwingObject.image_blend = color;

        durability -= 1;
        if (durability <= 0) {
            var slotIndex = owner.inventory.ContainsItem(self);
            if (slotIndex != -1) owner.inventory.RemoveItem(slotIndex, 1);
        }
    }

    function GetCopy()
    {
        var copy = new MeleeWeaponItem(name, color, durability, damage, damageType, staminaCost, weight, effects, sprite);
        return copy;
    }

    function GetDamage()
    {
        return damage;
    }

    function GetDescription() {
        var desc = $"Item: {name}\n";
        desc = string_concat(desc, $"Weapon Damage: {damage}\n");
        desc = string_concat(desc, $"Damage Type: {damageType}\n");
        return desc;
    }
}

function RangedWeaponItem(_name, _durability, _speed, _staminaCost, _weight,  _equipEffects, _sprite) : WeaponItem(_name, WeaponType.Ranged, _durability, _staminaCost, _weight, _equipEffects, _sprite) constructor {
    // get ref to owner
    // get ref to stat system
    // apply effects to stat system on equip
    speed = _speed;

    function Use()
    {
        var bullet = owner.inventory.GetEquippedBullet();
        if (bullet == undefined) 
        {
            if (variable_instance_exists(owner, "PlayerIndex"))
                Raise("NotificationOpen", ["You have no ammo equipped in your inventory.", owner.PlayerIndex]);
            return;
        }
        
        if (owner.stamina.GetStamina() <= staminaCost) {
            return;
        }
        else
        {
            owner.stamina.UseStamina(staminaCost);
        }

        var bulletObject = instance_create_layer(owner.x, owner.y, "Bullets", obj_Bullet);
        bulletObject.SetBulletData(bullet, speed, owner.targets, owner.image_angle);
        
        durability -= 1;
        if (durability <= 0) {
            var slotIndex = owner.inventory.ContainsItem(self);
            if (slotIndex != -1) owner.inventory.RemoveItem(slotIndex, 1);
        }
    }

    function GetCopy()
    {
        var copy = new RangedWeaponItem(name, durability, speed, staminaCost, weight, effects, sprite);
        return copy;
    }

    function GetDescription() {
        var desc = $"Item: {name}\n";
        desc = string_concat(desc, $"Projectile Speed: {speed}\n");
        return desc;
    }

}

