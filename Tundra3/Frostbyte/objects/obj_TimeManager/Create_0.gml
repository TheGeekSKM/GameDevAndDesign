timeOfDay = 0; // 0 = day, 1 = night
dayLength = game_get_speed(gamespeed_fps) * 60 * 5; // 5 minutes
nightColor = make_color_rgb(10, 10, 40);
dir = 1;

alphaValue = 0;

light_surface = surface_create(room_width, room_height);