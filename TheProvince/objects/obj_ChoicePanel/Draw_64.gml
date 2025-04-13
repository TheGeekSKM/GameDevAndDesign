if (choiceData == undefined) return;

draw_self();

// title
scribble($"{choiceData.Title}")
    .align(fa_center, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1, 1, 0)
    .sdf_outline(c_black, 2)
    .draw((x - (sprite_width / 2)) + 123, (y - (sprite_height / 2)) + 22);


// description
scribble($"{choiceData.Description}")
    .align(fa_left, fa_top)
    .starting_format("VCR_OSD_Mono", global.vars.Colors.c_darkBlue)
    .wrap(197 * 2)
    .transform(0.5, 0.5, 0)
    .draw((x - (sprite_width / 2)) + 26, (y - (sprite_height / 2)) + 39);


if (choseAccept) 
    draw_sprite(spr_acceptButton42, 2, topLeftX + 31, topLeftY + 254);
else if (mouseInAccept and !choseAccept) 
    draw_sprite(spr_acceptButton42, 1, topLeftX + 31, topLeftY + 254);
else 
    draw_sprite(spr_acceptButton42, 0, topLeftX + 31, topLeftY + 254);

if (choseReject) 
    draw_sprite(spr_rejectButton41, 2, topLeftX + 130, topLeftY + 254);
else if (mouseInReject and !choseReject) 
    draw_sprite(spr_rejectButton41, 1, topLeftX + 130, topLeftY + 254);
else 
    draw_sprite(spr_rejectButton41, 0, topLeftX + 130, topLeftY + 254);