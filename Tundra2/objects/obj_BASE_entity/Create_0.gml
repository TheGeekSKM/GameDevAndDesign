// Inherit the parent event
event_inherited();

// Stats System
stats = new StatSystem(irandom_range(3, 7), irandom_range(3, 7), irandom_range(3, 7));
currentWeight = 0;
alarm[0] = irandom_range(1, 3);

// Interactable Info
discovered = false;

infoName = "";
infoDescription = "";
function SetInfo(_name, _desc)
{
    infoName = _name;
    infoDescription = _desc;
}

// Helper Functions
function UpdateStats()
{
    maxHealth = stats.GetMaxHealth();
    carryWeight = stats.GetMaxCarryWeight();
    armorResistance = stats.GetArmorResistance();
    critChance = stats.GetCritChance();
    critDamage = stats.GetCritDamage();
    moveSpeed = stats.GetMoveSpeed(currentWeight);
    alarm[0] = irandom_range(1, 3);
}

image_speed = 0;
image_index = 1;