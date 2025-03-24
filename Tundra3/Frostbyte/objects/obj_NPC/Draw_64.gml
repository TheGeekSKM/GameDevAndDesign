if (instance_exists(playerInRange))
{
    var guiPos = new Vector2(x, y);
         
    guiPos = RoomToGUICoordsView(x, y - (sprite_height / 2) - 10, playerInRange.PlayerIndex);
     
    scribble(string_concat("[c_player", playerInRange.PlayerIndex, "]", Name, "[/c]\n", InteractText))
        .align(fa_center, fa_middle)
        .starting_format("Font", c_white)
        .transform(1, 1, 0)
        .sdf_outline(c_black, 2)
        .draw(guiPos.x, guiPos.y);
    
    
}

