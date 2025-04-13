enum IntVisType
{
    Room,
    GUI
}
// Inherit the parent event
event_inherited();
currentState = ButtonState.Idle;

mouseEnterCallbacks = [];
mouseExitCallbacks = [];

function AddMouseEnterCallback(callback) 
{
    array_push(mouseEnterCallbacks, callback);
}

function AddMouseExitCallback(callback) 
{
    array_push(mouseExitCallbacks, callback);
}

function OnMouseEnter() {
    currentState = ButtonState.Hover;
    for (var i = 0; i < array_length(mouseEnterCallbacks); i++) {
        var callback = mouseEnterCallbacks[i];
        if (callback != undefined) {
            callback();
        }
    }
    
    return Type;
}
function OnMouseExit() {
    currentState = ButtonState.Idle;
    for (var i = 0; i < array_length(mouseExitCallbacks); i++) {
        var callback = mouseExitCallbacks[i];
        if (callback != undefined) {
            callback();
        }
    }
}
function OnMouseLeftClick() {}
function OnMouseLeftHeld() {}
function OnMouseLeftClickRelease() {}
function OnMouseRightClick() {}
function OnMouseRightHeld() {}
function OnMouseRightClickRelease() {}


