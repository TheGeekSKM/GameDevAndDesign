///@pure
GenerateRandomPoint = function()
{
    var _x = irandom_range(x, x + sprite_width);
    var _y = irandom_range(y, y + sprite_height);
    
    return new Vector2(_x, _y);
}