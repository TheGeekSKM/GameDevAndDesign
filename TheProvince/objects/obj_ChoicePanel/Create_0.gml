event_inherited();
choiceData = undefined;
dragging = false;
topLeftX = x - (sprite_width / 2)
topLeftY = y - (sprite_height / 2);

mouseInAccept = false;
mouseInReject = false;

chosen = false;
choseAccept = false;
choseReject = false;

mouseOffsetX = 0;
mouseOffsetY = 0;

spawned = true;

disableChoices = false;

function OnMouseLeftClick()
{
    if (disableChoices) {
        dragging = true;
        Raise("DraggingDocument", id);
        mouseOffsetX = x - guiMouseX;
        mouseOffsetY = y - guiMouseY;
        return;
    }
    if (mouseInAccept)
    {
        chosen = true;
        choseAccept = true;
        choseReject = false;
        mouseInReject = false;
        mouseInAccept = false;
        return;
    }
    
    if (mouseInReject)
    {
        chosen = true;
        choseReject = true;
        mouseInReject = false;
        mouseInAccept = false;
        choseAccept = false;
        return;
    }
    
    dragging = true;
    Raise("DraggingDocument", id);
    mouseOffsetX = x - guiMouseX;
    mouseOffsetY = y - guiMouseY;
}

function OnMouseLeftClickRelease()
{
    dragging = false;
}