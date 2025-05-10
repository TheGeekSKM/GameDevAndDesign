self[$ "textToDisplay"] ??= "";
self[$ "textColor"] ??= c_white;
textAlpha = 1;

fadeCounter = 0;
fadeTime = 3 * game_get_speed(gamespeed_fps);
alarm[0] = fadeTime;

guiCoords = RoomToGUICoords(x, y);
lastPos = guiCoords.y - 50;