if (currentState == ButtonState.Hover and PlayerIsWithinRange())
{
    
    var guiPos = new Vector2(x, y);
        
    guiPos = RoomToGUICoords(x, y - (sprite_height / 2) - 10);
    
    scribble($"{Name}\n{InteractText}")
        .align(fa_center, fa_middle)
        .starting_format("spr_OutlineFont", c_white)
        .transform(1, 1, 0)
        .draw(guiPos.x, guiPos.y);
}