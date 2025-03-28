if (playerInRange != noone)
{
    var key = global.vars.InputManager.GetKey(playerInRange.PlayerIndex, ActionType.Action1);
    interactText = $"\"{KeybindToString(key)}\" to open!";
}

if (open) image_angle = lerp(image_angle, 180, 0.2);
else image_angle = lerp(image_angle, 90, 0.2);    