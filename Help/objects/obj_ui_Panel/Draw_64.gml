draw_self();

for (var i = 0; i < array_length(buttons); i++)
{
    buttons[i].Draw();
}

var textToDisplay = "";
switch (screenType)
{
    case ScreenType.Center:
        textToDisplay = "IJKL to Move, Space to Select";
        break;
    case ScreenType.Right:
        textToDisplay = "ArrowKeys to Move, Numpad0 to Select";
        break;
    case ScreenType.Left:
        textToDisplay = "WASD to Move, Left Shift to Select";
        break;      
}

if (array_length(buttons) > 0)
{
    scribble(textToDisplay)
        .align(fa_center, fa_middle)
        .starting_format("CustomFont", c_white)
        .transform(0.75, 0.75, image_angle)
        .draw(x, y + (sprite_height / 2) - 5);
}