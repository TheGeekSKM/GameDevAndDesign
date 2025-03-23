// Inherit the parent event
event_inherited();

function OnInteract()
{
    Raise("CraftingOpen", playerInRange.PlayerIndex);
}
