// Inherit the parent event
event_inherited();

function OnMouseLeftClickRelease()
{
    global.GameData.GenreName = Name;
    global.GameData.Interest = InterestStat;
    global.GameData.PersonalSatisfactionModifier = PersonalSatisfactionMod;
}

PersonalSatisfactionMod = random_range(0.5, 1.75);
InterestStat = irandom_range(0, 4);