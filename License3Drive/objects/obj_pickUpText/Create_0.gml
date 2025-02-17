textToDisplay = "";
fadeCounter = 0;
fadeTime = time * game_get_speed(gamespeed_fps);
alarm[0] = fadeTime;
lastPos = 0;

function Init(_itemData)
{
    x = _itemData.pickUpLocation.x;
    y = _itemData.pickUpLocation.y;
    lastPos = _itemData.pickUpLocation.y + 30;
    
    textToDisplay = string_concat(_itemData.itemType, " x", _itemData.itemCount);
}