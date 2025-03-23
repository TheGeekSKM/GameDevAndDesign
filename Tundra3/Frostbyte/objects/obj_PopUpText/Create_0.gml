textToDisplay = "";
fadeCounter = 0;
fadeTime = 3 * game_get_speed(gamespeed_fps);
alarm[0] = fadeTime;
lastPos = 0;
textAlpha = 1;
textColor = c_white;

function Init(_text, _color)
{
    textToDisplay = _text;
    textColor = _color;
    textAlpha = 1;
    fadeCounter = 0;
    alarm[0] = fadeTime;
    lastPos = 0;
}