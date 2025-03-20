if (instance_exists(playerInRange))
{
    var guiPos = new Vector2(0, 0);

    guiPos = RoomToGUICoordsView(x, y + ((sprite_height / 2) - 25), playerInRange.PlayerIndex);

    scribble($"[c_player{playerInRange.PlayerIndex}]{interactableName}\n[/c]{interactText}")
        .align(fa_center, fa_middle)
        .starting_format("Font", c_white)
        .transform(1, 1, 0)
        .draw(guiPos.x, guiPos.y);
}