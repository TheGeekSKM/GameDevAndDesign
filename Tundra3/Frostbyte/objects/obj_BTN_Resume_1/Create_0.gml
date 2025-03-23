// Inherit the parent event
event_inherited();

function OnClickEnd()
{
    Raise("PauseClose", 1);     
}