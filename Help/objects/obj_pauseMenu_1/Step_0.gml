if (!vis) return;

if (vis)
{
    blackBackgroundAlpha = lerp(blackBackgroundAlpha, 0.75, 0.1);
}
else {
    blackBackgroundAlpha = lerp(blackBackgroundAlpha, 0, 0.1);
}

var movement = keyboard_check_pressed(ord("S")) - keyboard_check_pressed(ord("W"));
if (movement != 0)
{
    selectIndex = ModWrap(selectIndex + movement, array_length(buttons));
}

var select = keyboard_check_pressed(ord("E"))
if (select)
{
    buttonFunc[selectIndex]();
}