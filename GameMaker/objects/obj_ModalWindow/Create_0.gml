// Inherit the parent event
event_inherited();

dragging = false;
xOffset = 0;
yOffset = 0;

topLeftX = 0;
topLeftY = 0;

topRightX = 0;
topRightY = 0;

text = "";
function SetText(_text)
{
    text = _text;
}

onCloseCallback = undefined;
function SetOnCloseCallback(_callback)
{
    onCloseCallback = _callback;
}

title = Name;
function SetTitle(_name) 
{
    title = _name;
}

mouseOverClose = false;
registerEnter = false;
alarm[0] = 30;


function OnMouseLeftClick() {
    
    
    if (point_in_rectangle(guiMouseX, guiMouseY, topLeftX + 1, topLeftY + 1, topLeftX + 1 + (sprite_width - 32), topLeftY + 31))
    {
        dragging = true;
        xOffset = guiMouseX - x;
        yOffset = guiMouseY - y;
        return;
    }
}

function OnMouseLeftClickRelease()
{
    dragging = false;
    
    if (point_in_rectangle(guiMouseX, guiMouseY, topRightX - 31, topRightY + 1, topRightX - 1, topRightY + 31))
    {
        if (onCloseCallback != undefined) onCloseCallback();
        instance_destroy(); 
    }
}