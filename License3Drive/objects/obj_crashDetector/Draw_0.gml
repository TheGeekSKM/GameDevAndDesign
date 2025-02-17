// Inherit the parent event
event_inherited();

if (vis)
{
    var gear = instance_nearest(obj_player.x, obj_player.y, obj_gear);
    if (instance_exists(gear)) draw_line_color(obj_player.x, obj_player.y, gear.x, gear.y, c_white, c_yellow);
}
