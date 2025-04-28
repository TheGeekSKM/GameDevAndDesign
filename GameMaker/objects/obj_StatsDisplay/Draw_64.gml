if (!variable_global_exists("GameData") || !global.GameData.Designed) return;

scribble($"[c_gold]({global.GameData.MaxNumOfDays - global.GameData.CurrentDay} days left)")
    .align(fa_right, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1, 1, 0)
    .draw(x, y);