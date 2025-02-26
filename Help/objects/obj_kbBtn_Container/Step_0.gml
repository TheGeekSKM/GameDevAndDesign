var movement = 0;

if (containerType == ContainerType.UpDown) movement = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
else movement = keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"));    

if ((selectIndex + movement) != oldIndex)
{
    show_debug_message(string_concat(allBtns[selectIndex].text, " and ", selectIndex));
    selectIndex = ModWrap(selectIndex + movement, array_length(allBtns));
    oldIndex = selectIndex;
    UpdateHover();
}