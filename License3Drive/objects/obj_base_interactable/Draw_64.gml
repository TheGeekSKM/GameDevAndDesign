if (playerInRange)
{
    var guiPos = RoomToGUICoords(x, y + ((sprite_height / 2) + 5));
    scribble(textToDisplay).draw(guiPos.x, guiPos.y).align(fa_center, fa_middle).starting_format(VCR_OS_Mono, c_white);
    
}