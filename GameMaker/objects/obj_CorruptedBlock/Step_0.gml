var pad = 1;

playerTouching = collision_rectangle(
                bbox_left  - pad,
                bbox_top   - pad,
                bbox_right + pad,
                bbox_bottom+ pad,
                obj_PlatformingPlayer,
                false,  
                true
); 

if (instance_exists(playerTouching) && playerTouching.image_index == 1 && isCorrupted) 
{
    repairProgress += 1;  // increment progress each frame holding button
    if (repairProgress >= repairThreshold) 
    {
        isCorrupted = false;
        Raise("ClearCorruptedSlide", id);
        if (y > 170) sprite_index = spr_platformGreen67;
        else sprite_index = spr_platformBlue66;
    }
}
