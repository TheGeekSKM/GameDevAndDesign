if (!vis) return;

if (vis)
{
    blackBackgroundAlpha = lerp(blackBackgroundAlpha, 0.75, 0.1);
}
else {
    blackBackgroundAlpha = lerp(blackBackgroundAlpha, 0, 0.1);
}

var movement = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(buttons));
}

var select = keyboard_check_pressed(vk_rcontrol)
if (select)
{
    buttonFunc[selectIndex]();
}