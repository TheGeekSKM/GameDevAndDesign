draw_self();
var text = Name;

if (currentState != ButtonState.Idle)
{
    text = $"[wave]{Name}[/]";
}

scribble(text)
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", textColor)
    .transform(1.2, 1.2, image_angle)
    .sdf_outline(c_black, 3)
    .draw(x, y);