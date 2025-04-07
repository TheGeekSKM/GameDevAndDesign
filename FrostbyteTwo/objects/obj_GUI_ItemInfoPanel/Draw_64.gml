// Inherit the parent event
event_inherited();

if (currentScribble == undefined) return;
currentScribble.draw(topLeft.x + 18, topLeft.y + 24);