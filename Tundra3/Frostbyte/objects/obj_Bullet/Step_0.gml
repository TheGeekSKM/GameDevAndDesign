if (bulletItem == undefined) {
    show_message("Bullet item not set for {id}");
    instance_destroy();
    return;
}

if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
image_angle = direction;


if (!ds_exists(hitObjectList, ds_type_list)) {return;} 
ds_list_clear(hitObjectList);
var hitCount = instance_place_list(x, y, targets, hitObjectList, false);

if (hitCount > 0) {
    for (var i = 0; i < hitCount; i++) 
    {
        var hitObject = hitObjectList[| i];
        if (hitObject != shooter) 
        {
            var isCrit = random(100) < bulletItem.owner.stats.GetCritChance();
            var dmg = isCrit ? bulletItem.owner.stats.GetCritDamageMultiplier() * damage : damage;

            hitObject.entityHealth.TakeDamage(dmg, damageType, bulletItem.owner, isCrit);
            bulletItem.Use(new Vector2(x, y))
            if (!hitMultiple) 
            {
                instance_destroy();
                return;
            }
        }
    }
}