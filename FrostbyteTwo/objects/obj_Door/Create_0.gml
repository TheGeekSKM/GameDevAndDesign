// Inherit the parent event
event_inherited();

function OnMouseLeftClick() {
    Raise("PickUp", id);   
    //if (instance_exists(global.vars.Player) and PlayerIsWithinRange())
    //{
        
    //}
}

open = false;
function Collect(_id)
{
    open = !open;
}