ds_list_clear(list);
collision_circle_list(x, y, range, obj_BASE_Entity, false, true, list, false);
for (var i = 0; i < ds_list_size(list); i++) {
    var dist = point_distance(x, y, list[| i].x, list[| i].y);
    dist = clamp(dist, 1, 1000000);
    list[| i].temperature.AddWarmth((1000 / dist));
    
    if (list[| i] == global.vars.Player) {
       var popUp = instance_create_layer(list[| i].x, list[| i].y, "GUI", obj_PopUpText)
       popUp.Init($"Added Warmth ({(1000 / dist)})")
    }
}

alarm[0] = game_get_speed(gamespeed_fps) * irandom_range(13, 20);