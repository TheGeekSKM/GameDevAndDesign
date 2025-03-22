topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));
playerIndex = 0;

function SetPlayerIndex(_index)
{
    image_blend = global.vars.PlayerColors[_index];
    playerIndex = _index;
}

function DrawGUI() {}
function Step() {}