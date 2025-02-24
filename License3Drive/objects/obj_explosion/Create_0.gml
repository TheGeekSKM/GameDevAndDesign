
scale = random_range(1.5, 2);
image_xscale = 0.01;
image_yscale = 0.01;


growing = true;
scaleCounter = 0;
scaleTime = 2 * game_get_speed(gamespeed_fps);
curve = animcurve_get_channel(ac_explosionCurve, "curve1");



alarm[0] = scaleTime;