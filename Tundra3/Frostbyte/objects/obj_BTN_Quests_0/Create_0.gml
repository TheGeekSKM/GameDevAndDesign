// Inherit the parent event
event_inherited();

function OnClickEnd()
{
    Raise("QuestOpen", 0);   
}