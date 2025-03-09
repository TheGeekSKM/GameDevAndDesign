// Inherit the parent event
event_inherited();

currentState = ButtonState.Idle;

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
    Interact();
}

function Interact() {
    
}
