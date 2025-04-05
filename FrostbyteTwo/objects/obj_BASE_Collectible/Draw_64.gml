if (currentState == ButtonState.Hover and PlayerIsWithinRange())
{
    
    var guiPos = new Vector2(x, y);
        
    guiPos = RoomToGUICoords(x, y - (sprite_height / 2) - 10);
    
    scribble($"{Name}\n{InteractText}")
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .sdf_outline(c_black, 2)
        .transform(0.5, 0.5, 0)
        .draw(guiPos.x, guiPos.y);
}