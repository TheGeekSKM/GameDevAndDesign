ds_list_clear(list);
collision_circle_list(x, y, 50, obj_BASE_Entity, false, true, list, false);
for (var i = 0; i < ds_list_size(list); i++) {
    var dist = point_distance(x, y, list[| i].x, list[| i].y);
    dist = clamp(dist, 1, 1000000);
    list[| i].temperature.AddWarmth((100 / dist));
    echo((100 / dist))  
}

ds_list_clear(list)
instance_place_list(x, y, obj_BASE_Entity, list, false);
for (var i = 0; i < ds_list_size(list); i++) {
    list[| i].entityHealth.TakeDamage(10 * 0.016, DamageType.FIRE, id);
}