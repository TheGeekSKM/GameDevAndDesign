function Target(_owner)  : Component("target")  constructor  {
    owner = _owner;
    x = owner.x;
    y = owner.y;
    radius = 46;

    function Step(_speedMultiplier = 1)
    {
        // Initialize movement variables
        var moveAngle = 0;
        var moveDist = 0;
        
        // Get input
        var up = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Up);
        var down = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Down);
        var left = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Left);
        var right = global.vars.InputManager.IsDown(owner.PlayerIndex, ActionType.Right);
        
        // Adjust angle (left/right changes direction)
        moveAngle = (left - right) * _speedMultiplier * 4;
        
        // Adjust distance (up/down moves target in/out)
        moveDist = (up - down) * _speedMultiplier * 2;
        
        // Get current angle and distance
        var angle = point_direction(owner.x, owner.y, x, y);
        var dist = point_distance(owner.x, owner.y, x, y);
        
        // Apply angle rotation
        angle += moveAngle;
        
        // Apply distance change, clamping to prevent going too close or too far
        var minRadius = 10; // Set a minimum distance from the player
        var maxRadius = radius; // Maximum distance from the player
        dist = clamp(dist + moveDist, minRadius, maxRadius);
        
        // Calculate new position based on angle and distance
        x = owner.x + lengthdir_x(dist, angle);
        y = owner.y + lengthdir_y(dist, angle);
    }

    function GetPos()
    {
        return new Vector2(x, y);
    }
}