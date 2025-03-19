function Target(_owner) constructor {
    owner = _owner;
    x = owner.x;
    y = owner.y;
    radius = 46;

    function Step(_speedMultiplier = 1)
    {
        var moveX = 0;
        var moveY = 0;

        var up = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Up);
        var down = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Down);
        var left = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Left);
        var right = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Right);

        moveX = (right - left) * _speedMultiplier * 4;
        moveY = (down - up) * _speedMultiplier * 4;

        x += moveX;
        y += moveY;

        var dist = point_distance(x, y, owner.x, owner.y);
        if (dist > radius)
        {
            var angle = point_direction(owner.x, owner.y, x, y);
            x = owner.x + lengthdir_x(radius, angle);
            y = owner.y + lengthdir_y(radius, angle);
        }
    }

    function GetPos()
    {
        return new Vector2(x, y);
    }
}