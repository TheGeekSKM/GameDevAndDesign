if (playerInRange != noone)
{
    var guiPos = new Vector2(x, y);
    
    if (!global.vars.single) guiPos = RoomToGUICoordsView(x, y + ((sprite_height / 2) - 25), playerInRange.playerIndex);
    else guiPos = RoomToGUICoords(x, y + ((sprite_height / 2) - 25));
    
    scribble(string_concat("[c_player", playerInRange.playerIndex, "]", interactableName, "[/c]\n", interactText))
        .align(fa_center, fa_middle)
        .starting_format("CustomFont", c_white)
        .transform(1, 1, 0)
        .draw(guiPos.x, guiPos.y);
}