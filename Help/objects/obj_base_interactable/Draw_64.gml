if (playerInRange)
{
    var guiPos = RoomToGUICoordsView(x, y + ((sprite_height / 2) + 5), playerInRange.playerIndex);
    scribble(textToDisplay).align(fa_center, fa_middle).starting_format("CustomFont", c_white).draw(guiPos.x, guiPos.y);
    
}