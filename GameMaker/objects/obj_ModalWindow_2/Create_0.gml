// Inherit the parent event
event_inherited();

depth = -500

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

SetTitle("INSTRUCTIONS")
SetText(@"Use the [c_gold]functions[/] you have made and [c_player]kill as many Bugs as possible.[/] 
You can use the [c_gold]Number Keys[/] at the top of your keyboard, or [c_gold]Numpad Keys[/], or even [c_gold]click[/] on the Function Slots. 
You'll be able to see how much Allocated Memory you have. 

[c_red]REMEMBER: Never let your memory reach 0![/]

Good Luck.")