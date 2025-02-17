if (is_undefined(global.OldTimeStruct) or !global.OldTimeStruct.won) return;
    
scribble(string_concat("Best Time: ", global.OldTimeStruct.time, " seconds"))
    .align(fa_center, fa_middle)
    .transform(1, 1, 0)
    .starting_format("VCR_OS_Mono", c_white)
    .draw(x, y);

scribble(string_concat("(", global.OldTimeStruct.timeNoMenu, " seconds)"))
    .align(fa_center, fa_middle)
    .transform(0.75, 0.75, 0)
    .starting_format("VCR_OS_Mono", c_white)
    .draw(x, y + 15);