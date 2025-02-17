// Inherit the parent event
event_inherited();

if (obj_player.lastCrash.x == 0 and obj_player.lastCrash.y == 0) return;
    
scribble(string_concat("Recent Crash: ", obj_player.lastCrash.x, ", ", obj_player.lastCrash.y))
    .align(fa_center, fa_middle)
    .starting_format("VCR_OS_Mono", c_yellow)
    .draw(x, y);

