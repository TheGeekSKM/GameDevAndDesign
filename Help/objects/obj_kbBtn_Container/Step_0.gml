var movement = 0;

if (self.containerType == ContainerType.UpDown) movement = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
else movement = keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"));    

if ((selectIndex + movement) != oldIndex)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(allBtns));
    oldIndex = selectIndex;
    UpdateHover();
}

if (keyboard_check_pressed(vk_lshift)) ClickStart(); 
if (keyboard_check_released(vk_lshift)) ClickEnd(); 