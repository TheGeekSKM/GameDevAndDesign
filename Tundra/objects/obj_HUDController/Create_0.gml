layerName = "Sequences";
if (!layer_exists(layerName)) layer_create(1, layerName);
    
healthBarCreate = layer_sequence_create(layerName, obj_camera.x, obj_camera.x, seq_HUD_HealthBar_Damage);
alarm[0] = layer_sequence_get_length(healthBarCreate);

healthBarDamage = layer_sequence_create(layerName, obj_camera.x - 1000, obj_camera.x, seq_HUD_HealthBar_Create);
layer_sequence_pause(healthBarDamage);

player = instance_find(obj_Player, 0);

Subscribe("Damage", function(_arr) {
    if (_arr[0].owner == player)
    {
        layer_sequence_headpos(healthBarDamage, 1);
        layer_sequence_play(healthBarDamage);
    }    
})

