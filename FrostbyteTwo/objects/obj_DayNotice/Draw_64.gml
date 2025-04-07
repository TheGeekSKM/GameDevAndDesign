scribble($"Day #{obj_TimeManager.daysSurvived}")
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(2, 2, image_angle)
    .sdf_outline(c_black, 2)
    .draw(x, y - 10);

var extraText = $"(Survive for 3 days total...)"
if (obj_TimeManager.daysSurvived == 1)
{
    extraText = $"Hold [c_yellow]Left Click[/] to [wave]Move[/]\nHold [c_yellow]Right Click[/] to [wave]Attack[/]"
}

scribble(extraText)
    .align(fa_center, fa_top)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(0.75, 0.75, image_angle)
    .sdf_outline(c_black, 2)
    .draw(x, y + 7);