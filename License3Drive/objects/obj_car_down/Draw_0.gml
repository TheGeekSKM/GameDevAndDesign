draw_self();

if (!global.debug) return;
if (checkForCars) 
{
    if (frontCar != noone)
    {
        draw_set_color(make_color_rgb(255, 0, 0));
    }
    else 
    {
        draw_set_color(c_yellow);
    }
    draw_rectangle(x + (sprite_width / 2), y + (sprite_width / 2), nextX, nextY, true);
}