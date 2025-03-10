// Inherit the parent event
event_inherited();

function OnMouseEnter() {
    return Type;
}
function OnMouseExit() {}
function OnMouseLeftClick() {}
function OnMouseLeftHeld() {}
function OnMouseLeftClickRelease() {}
function OnMouseRightClick() {}
function OnMouseRightHeld() {}
function OnMouseRightClickRelease() {}

stats = new StatSystem(irandom_range(3, 7), irandom_range(3, 7), irandom_range(3, 7));
currentWeight = 0;
alarm[0] = irandom_range(1, 3);

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