if (!vis) return;
var playerIndex = obj_PCManager.playerInRange.PlayerIndex;

var menu = global.vars.InputManager.IsPressed(playerIndex, ActionType.Menu);
if (menu)
{
    Raise("PCViewClose", playerIndex);
}