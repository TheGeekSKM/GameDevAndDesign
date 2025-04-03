// Inherit the parent event
event_inherited();

currentState = ButtonState.Idle;

callbacks = [];

function AddCallback(callback) 
{
    array_push(callbacks, callback);
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
