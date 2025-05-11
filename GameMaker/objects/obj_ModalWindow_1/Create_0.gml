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
SetText(@"1. You have [c_gold]3 Function Slots[/]. Navigate through them to open them up. [c_gold]Function Slot #1[/] is open currently for you.
2. Use the [c_player]Documentation[/] to write any code you'd like in the Function Slot.
3. Use [c_gold][wave]Ctrl + Shift + C[/] to Compile your code. Any errors in your code will be displayed during compilations.
4. Use [c_gold][wave]Ctrl + Shift + E[/] once you are satisfied with all of your functions.

Your goal is to [c_player]Shoot Bugs before you run out of Allocated Memory.[/] Good Luck.

[slant][c_grey]Note: The GameScript Documentation page should have opened in your browser[/]

[size, 2][c_player][slant]Press [c_gold][wave]Ctrl + O[/wave][c_player] to open Code Snippets that you can Copy/Paste")
