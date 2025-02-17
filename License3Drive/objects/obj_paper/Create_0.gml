// Inherit the parent event
event_inherited();

itemType = ItemType.Paper;

drawnPapers = [];

for (var i = 0; i < itemCount; i++) {
    var xPos = x + irandom_range(-5, 5);
    var yPos = y + irandom_range(-5, 5);
    var angle = irandom(360);
    array_push(drawnPapers, [xPos, yPos, angle]);
}