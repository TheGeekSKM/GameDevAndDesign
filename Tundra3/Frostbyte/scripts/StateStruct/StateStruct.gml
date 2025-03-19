function StateStruct(_name) constructor 
{
    name = _name;
    enter = function () {};
    step = function () {};
    draw = function () {};
    drawGUI = function () {};
    leave = function () {};

    function SetEnter(_enter)
    {
        enter = _enter;
        return self;
    }

    function SetStep(_step)
    {
        step = _step;
        return self;
    }

    function SetDraw(_draw)
    {
        draw = _draw;
        return self;
    }

    function SetDrawGUI(_drawGUI)
    {
        drawGUI = _drawGUI;
        return self;
    }

    function SetLeave(_leave)
    {
        leave = _leave;
        return self;
    }
}