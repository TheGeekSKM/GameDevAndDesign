// Inherit the parent event
event_inherited();

if (instance_exists(global.Player) and PlayerIsWithinRange())
{
    InteractText = $"Left Click to Interact"
}