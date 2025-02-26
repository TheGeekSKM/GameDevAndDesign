var movement = container == ContainerType.UpDown ? 
    input_check_pressed("down") - input_check_pressed("up") : 
    input_check_pressed("right") - input_check_pressed("left");

if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(buttons));
    UpdateHover();
}

var selectStart = 0;
var selectEnd = 0;

switch (screenType)
{
    case ScreenType.Center:
        selectStart = keyboard_check_pressed(vk_space);
        selectEnd = keyboard_check_released(vk_space);
        break;
    case ScreenType.Right:
        selectStart = keyboard_check_pressed(vk_numpad0);
        selectEnd = keyboard_check_released(vk_numpad0);
        break;
    case ScreenType.Left:
        selectStart = keyboard_check_pressed(vk_lshift);
        selectEnd = keyboard_check_released(vk_lshift);
        break;        
}

if (selectStart != 0) ClickStart();
if (selectEnd != 0) ClickEnd();    