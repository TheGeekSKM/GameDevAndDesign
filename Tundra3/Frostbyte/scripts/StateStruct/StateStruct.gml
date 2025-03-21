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
        self.enter = _enter;
        return self;
    }

    function SetStep(_step)
    {
        self.step = _step;
        return self;
    }

    function SetDraw(_draw)
    {
        self.draw = _draw;
        return self;
    }

    function SetDrawGUI(_drawGUI)
    {
        self.drawGUI = _drawGUI;
        return self;
    }

    function SetLeave(_leave)
    {
        self.leave = _leave;
        return self;
    }
}