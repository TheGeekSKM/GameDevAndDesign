scribble(string_concat("Time: ", global.TimeStruct.time, " seconds"))
    .align(fa_center, fa_middle)
    .transform(2, 2, 0)
    .starting_format("VCR_OS_Mono", c_white)
    .draw(x, y);

scribble(string_concat("Tecnically ", global.TimeStruct.timeNoMenu, " seconds if you count the time you spent in menus..."))
    .align(fa_center, fa_middle)
    .transform(0.75, 0.75, 0)
    .starting_format("VCR_OS_Mono", c_white)
    .draw(x, y + 30);