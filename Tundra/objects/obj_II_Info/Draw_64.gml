var namePos = new Vector2(x + 23, y + 18);
var descPos = new Vector2(x + 18, y + 40);


var name = scribble(interactableName)
    .align(fa_left, fa_middle)
    .starting_format("VCR_OSD_Mono", c_white)
    .transform(1, 1, image_angle)
    .wrap(256)
    .blend(c_white, image_alpha)    
    .sdf_outline(c_black, 2)


var bbox = name.get_bbox(namePos.x, namePos.y);



var desc = scribble(interactableDesc)
    .align(fa_left, fa_top)
    .starting_format("VCR_OSD_Mono", c_black)
    .wrap(bbox.width + 18)
    .blend(c_black, image_alpha)
    .transform(1, 1, image_angle)


var bbox2 = desc.get_bbox(descPos.x, descPos.y);

draw_sprite_stretched_ext(sprite_index, image_index, x, y, bbox.width + 46, bbox2.height + 58, c_white, image_alpha);

name.draw(namePos.x, namePos.y);
desc.draw(descPos.x, descPos.y)