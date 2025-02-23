// Inherit the parent event
event_inherited();

if (vis)
{
    var gear = instance_nearest(obj_player.x, obj_player.y, obj_gear);
    
    if (instance_exists(gear)) {
        var angle = point_direction(obj_player.x, obj_player.y, gear.x, gear.y);
        var alpha = 1;
        var dist = point_distance(obj_player.x, obj_player.y, gear.x, gear.y)
        if ( dist < 150) alpha = (dist - 15) / 150; 
        
        draw_sprite_ext(spr_arrow2, 0, obj_player.x, obj_player.y, 1, 1, angle, c_white, alpha);
    }
}
