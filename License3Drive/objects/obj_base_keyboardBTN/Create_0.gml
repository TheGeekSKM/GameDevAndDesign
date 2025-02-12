// Register itself with the Manager
currentButtonState = ButtonState.Idle;

function SetState(_state) { currentButtonState = _state; }

function OnHoverStart() { SetState(ButtonState.Hovered); }

function OnIdle() { SetState(ButtonState.Idle); }

function OnClickStart() { SetState(ButtonState.Clicked); }

function OnClickEnd() { 
    if (onClick != undefined) onClick(); 
    event_user(0);
    SetState(ButtonState.Hovered);    
}

with(KeyboardButtonManager) { AddToManager(other.id); }