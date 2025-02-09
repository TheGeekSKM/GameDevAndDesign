function Vector2(_x, _y) constructor {
    x = _x;
    y = _y;
    
    ///@pure
    SqrMagnitude = function()
    {
        return (x * x) + (y * y);
    }
    
    ///@pure
    IsWithinRange = function(_other, _range) 
    {
        var dx = _other.x - x;
        var dy = _other.y - yl
        return (((dx * dx) + (dy * dy)) <= (_range * _range));
    }
}
