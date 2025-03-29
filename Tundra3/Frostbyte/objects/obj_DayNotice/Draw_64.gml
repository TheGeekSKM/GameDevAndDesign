scribble($"Day #{obj_TimeManager.daysSurvived}")
    .align(fa_center, fa_middle)
    .starting_format("Font", c_white)
    .transform(2, 2, image_angle)
    .sdf_outline(c_black, 2)
    .draw(x, y - 10);

scribble($"(Survive for 3 days total...)")
    .align(fa_center, fa_middle)
    .starting_format("Font", c_white)
    .transform(0.75, 0.75, image_angle)
    .sdf_outline(c_black, 2)
    .draw(x, y + 7);