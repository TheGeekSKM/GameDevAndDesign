if (playerInRange != noone)
{
    var key = global.vars.InputManager.GetKey(playerInRange.PlayerIndex, ActionType.Action1);
    interactText = $"\"{KeybindToString(key)}\" to Read the Recipe";
}