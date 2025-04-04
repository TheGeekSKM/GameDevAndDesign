textToDisplay = "";
fadeCounter = 0;
fadeTime = 3 * game_get_speed(gamespeed_fps);
alarm[0] = fadeTime;

textAlpha = 1;
textColor = c_white;

function Init(_text, _color = c_white)
{
    textToDisplay = _text;
    textColor = _color;
    lastPos = y - 50;
}