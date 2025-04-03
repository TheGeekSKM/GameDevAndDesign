enum IntVisType
{
    Room,
    GUI
}
// Inherit the parent event
event_inherited();
currentState = ButtonState.Idle;

mouseEnterCallbacks = [];

function AddMouseEnterCallback(callback) 
{
    array_push(mouseEnterCallbacks, callback);
}

function OnMouseEnter() {
    currentState = ButtonState.Hover;
    for (var i = 0; i < array_length(mouseEnterCallbacks); i++) {
        var callback = mouseEnterCallbacks[i];
        if (callback != undefined) {
            callback();
        }
    }
    
    echo($"{Name}")
    return Type;
}
function OnMouseExit() {
    currentState = ButtonState.Idle;
}
function OnMouseLeftClick() {}
function OnMouseLeftHeld() {}
function OnMouseLeftClickRelease() {}
function OnMouseRightClick() {}
function OnMouseRightHeld() {}
function OnMouseRightClickRelease() {}

