if (!surface_exists(light_surface))
{
    light_surface = surface_create(room_width, room_height);
}
surface_set_target(light_surface);
draw_clear_alpha(c_black, 1.0); // Clear surface with full darkness



// Apply the night-time darkness effect **on the light surface itself**
draw_set_alpha(alphaValue);
draw_set_color(nightColor);
draw_rectangle(0, 0, room_width, room_height, false);


surface_reset_target();