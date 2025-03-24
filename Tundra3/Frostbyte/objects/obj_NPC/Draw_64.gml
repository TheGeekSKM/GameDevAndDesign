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
    
    if (quest == undefined) return;
    var _quest = GetQuest(quest.name);
    if (_quest.state == QuestState.Inactive)
    {
        draw_sprite_ext(spr_Exclamation, 0, x, y - (sprite_height / 2), 1, 1, 0, global.vars.PlayerColors[playerInRange.PlayerIndex], 1);
    }
}