sprite_index = MainSprite;
image_speed = 0;
image_index = 1;

mouseOver = false;
discovered = false;
infoName = "DefaultEntity"
infoString = $"This is a default Entity";

function OnClick() {}

entityMovementData = new EntityMovementData()
    .SetDistances(64 + irandom(5), 8 + irandom(5), 1 + irandom(5))
    .SetSpeeds(4 + irandom(1), 2 + irandom(1), 1 + irandom(1));

hoverColor = global.vars.highlightColors[InteractableType];
hoverCounter = 0;