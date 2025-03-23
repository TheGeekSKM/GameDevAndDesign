for (var i = 0; i < array_length(global.vars.CameraShake); i += 1) {
    if (global.vars.CameraShake[i].duration > 0) {
        global.vars.CameraShake[i].duration -= 1;
        var cam = global.vars.Cameras[i];
        var shakeX = random_range(-global.vars.CameraShake[i].intensity, global.vars.CameraShake[i].intensity);
        var shakeY = random_range(-global.vars.CameraShake[i].intensity, global.vars.CameraShake[i].intensity);
        
        var targetX = camera_get_view_x(cam) + shakeX;
        var targetY = camera_get_view_y(cam) + shakeY;

        camera_set_view_pos(cam, targetX, targetY);
    }
}