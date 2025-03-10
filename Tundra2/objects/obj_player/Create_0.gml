// Inherit the parent event
event_inherited();

// Stats System
stats = new StatSystem(irandom_range(3, 7), irandom_range(3, 7), irandom_range(3, 7));
currentWeight = 0;

// Interactable Info
discovered = false;

infoName = "";
infoDescription = "";
function SetInfo(_name, _desc)
{
    infoName = _name;
    infoDescription = _desc;
}

image_speed = 0;
image_index = 1;

collidables = [];