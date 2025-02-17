// Inherit the parent event
event_inherited();

itemType = ItemType.CarParts;

drawnGears = [];
drawnGearsDebug = [];

for (var i = 1; i < itemCount; i++) {
    var xPos = x + irandom_range(-i, i);
    var yPos = y + irandom_range(-i, i);
    var angle = irandom(360);
    
    var x1 = xPos - (sprite_width / 2);
    var x2 = xPos + (sprite_width / 2);
    var y1 = yPos - (sprite_height / 2);
    var y2 = yPos + (sprite_height / 2);
    
    array_push(drawnGears, [xPos, yPos, angle]);
    array_push(drawnGearsDebug, [x1, y1, x2, y2]);
}
