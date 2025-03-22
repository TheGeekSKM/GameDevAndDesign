var action = global.vars.InputManager.IsPressed(playerIndex, ActionType.Action1);
if (action) ready = !ready;

if (ready) return;
var up = global.vars.InputManager.IsPressed(playerIndex, ActionType.Up);
var down = global.vars.InputManager.IsPressed(playerIndex, ActionType.Down);

var movement = up - down;
if (movement != 0)
{
    selectIndex = ModWrap(selectIndex - movement, 3);
    Raise("SelectPlayer1", selectIndex);
}

var left = global.vars.InputManager.IsPressed(playerIndex, ActionType.Left);
var right = global.vars.InputManager.IsPressed(playerIndex, ActionType.Right);
var addition = right - left;

if (addition != 0)
{
    switch (selectIndex)
    {
        case 0: // Strength
            if (addition > 0 && totalPoints > 0 && str < 10)  // Increase
            {
                str += addition;
                totalPoints -= addition;
            }
            else if (addition < 0 && str > 2)  // Decrease
            {
                str += addition;
                totalPoints -= addition;
            }
            break;

        case 1: // Dexterity
            if (addition > 0 && totalPoints > 0 && dex < 10)
            {
                dex += addition;
                totalPoints -= addition;
            }
            else if (addition < 0 && dex > 2)
            {
                dex += addition;
                totalPoints -= addition;
            }
            break;

        case 2: // Constitution
            if (addition > 0 && totalPoints > 0 && con < 10)
            {
                con += addition;
                totalPoints -= addition;
            }
            else if (addition < 0 && con > 2)
            {
                con += addition;
                totalPoints -= addition;
            }
            break;
    }
}

// Clamping (Just to be extra safe)
str = clamp(str, 2, 10);
dex = clamp(dex, 2, 10);
con = clamp(con, 2, 10);
totalPoints = max(totalPoints, 0);