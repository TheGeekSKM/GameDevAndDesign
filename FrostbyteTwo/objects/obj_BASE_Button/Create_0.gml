// Inherit the parent event
event_inherited();

currentState = ButtonState.Idle;

callbacks = [];

function AddCallback(callback) 
{
    array_push(callbacks, callback);
    return id;
}

function SetText(_text) { Text = _text; return id; }
function SetColors(_hoverColor, _clickColor) 
{ 
    ClickColor = _clickColor; 
    HoverColor = _hoverColor; 
    return id; 
}

function SetSize(_width, _height) 
{ 
    image_xscale = _width / sprite_get_width(sprite_index);
    image_yscale = _height / sprite_get_height(sprite_index);
    return id; 
}

function SetPosition(_x, _y) 
{ 
    x = _x; 
    y = _y; 
    return id; 
}

function SetDepth(_depth) 
{ 
    depth = _depth; 
    return id; 
}

function OnMouseEnter() 
{
    currentState = ButtonState.Hover;
    return Type;
}
function OnMouseExit() 
{
    currentState = ButtonState.Idle;
}
function OnMouseLeftClick() 
{
    currentState = ButtonState.Click;
}
function OnMouseLeftClickRelease() 
{
    currentState = ButtonState.Hover;
    for (var i = 0; i < array_length(callbacks); i += 1) 
    {
        callbacks[i]();
    }
    Interact();
}

function Interact() {
    
}
