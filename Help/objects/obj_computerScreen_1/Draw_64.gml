draw_self();

scribble(string_concat("GPUs Needed: ", obj_computer.gpuRequirements))
    .align(fa_center, fa_middle)
    .transform(1, 1, image_angle)
    .starting_format("CustomFont", c_white)
    .draw(x, y - 50);

scribble(string_concat("CPUs Needed: ", obj_computer.cpuRequirements))
    .align(fa_center, fa_middle)
    .transform(1, 1, image_angle)
    .starting_format("CustomFont", c_white)
    .draw(x, y);

scribble(string_concat("RAM Needed: ", obj_computer.ramRequirements))
    .align(fa_center, fa_middle)
    .transform(1, 1, image_angle)
    .starting_format("CustomFont", c_white)
    .draw(x, y + 50);

draw_sprite(spr_computerMenu_top, 0, x, y);