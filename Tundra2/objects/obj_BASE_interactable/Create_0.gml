enum IntVisType
{
    Room,
    GUI
}
// Inherit the parent event
event_inherited();
currentState = ButtonState.Idle;

function OnMouseEnter() {
    currentState = ButtonState.Hover;
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

