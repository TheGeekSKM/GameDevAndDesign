///

if (!vis) return;

var up = global.vars.InputManager.IsPressed(playerIndex, ActionType.Up);
var down = global.vars.InputManager.IsPressed(playerIndex, ActionType.Down);
var left = global.vars.InputManager.IsPressed(playerIndex, ActionType.Left);
var right = global.vars.InputManager.IsPressed(playerIndex, ActionType.Right);

var select = global.vars.InputManager.IsPressed(playerIndex, ActionType.Action1);
var select2 = global.vars.InputManager.IsReleased(playerIndex, ActionType.Action1);

movement = leftRight ? right - left : down - up;

if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(buttons))
    UpdateButton();
}

if (select)
{
    OnButtonClick();
}

if (select2)
{
    OnButtonClickEnd();
}