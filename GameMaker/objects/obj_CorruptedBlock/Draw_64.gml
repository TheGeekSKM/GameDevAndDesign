if (repairProgress > 0)
{
    var guiCoords = RoomToGUICoords(x + (sprite_width / 2), y + (sprite_height / 2));
    scribble($"Repair Progress: {repairProgress}")
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .sdf_outline(c_black, 2)
        .transform(1.2, 1.2, 0)
        .draw(guiCoords.x, guiCoords.y);
}