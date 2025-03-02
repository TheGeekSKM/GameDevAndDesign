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
        selectStart = keyboard_check_pressed(vk_rcontrol);
        selectEnd = keyboard_check_released(vk_rcontrol);
        break;
    case ScreenType.Left:
        selectStart = keyboard_check_pressed(ord("E"));
        selectEnd = keyboard_check_released(ord("E"));
        break;        
}

if (selectStart != 0) ClickStart();
if (selectEnd != 0) ClickEnd();    