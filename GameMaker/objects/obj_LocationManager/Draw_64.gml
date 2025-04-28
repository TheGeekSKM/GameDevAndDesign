if (CurrentMenu == undefined) return;
scribble($"[c_gold](GESoftware v1.3) -> {GetCurrentPath()}")
    .align(fa_left, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1, 1, 0)
    .draw(x, y);