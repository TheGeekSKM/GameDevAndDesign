scribble($"Choose [slant]\"{global.GameData.Name}'s\"[/] Genre:")
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .draw(x, y);

scribble($"Current Genre: {global.GameData.GenreName}")
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(0.75, 0.75)
    .draw(x, y + 15);