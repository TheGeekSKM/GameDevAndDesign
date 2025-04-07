ds_list_clear(list)
instance_place_list(x, y, obj_BASE_Entity, list, false);
for (var i = 0; i < ds_list_size(list); i++) {
    echo(list[| i]);
    list[| i].entityHealth.TakeDamage(10, DamageType.FIRE, id);
}

alarm[1] = game_get_speed(gamespeed_fps) * random_range(0.5, 1);