textToDisplay = "";
fadeCounter = 0;
fadeTime = 3 * game_get_speed(gamespeed_fps);
alarm[0] = fadeTime;
lastPos = 0;
textAlpha = 1;
textColor = c_white;

function Init(_text, _txtColor = c_white)
{
    lastPos = y - 30;
    textColor = _txtColor
    textToDisplay = string_concat(_text);
}