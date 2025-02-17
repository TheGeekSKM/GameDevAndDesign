///@pure
function GetRandomPoint()
{
    return new Vector2((irandom_range(x, x + sprite_width)), (irandom_range(y, y + sprite_height)));
}