// Inherit the parent event
event_inherited();
isCorrupted = true;
repairProgress = 0;
repairThreshold = 100;
playerTouching = noone;

Raise("AddCorruptedSlide", id);
