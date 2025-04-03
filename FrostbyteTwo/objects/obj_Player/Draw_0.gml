if (obj_Mouse.currentInteractable == id) draw_sprite_ext(sprite_index, 0, x, y, 1.2, 1.2, 0, global.vars.highlightColors[Type], 1);
draw_self();

if (rightClickHold) draw_sprite(spr_target142, 0, mouse_x, mouse_y);