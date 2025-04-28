draw_self();

if (___.currentHealth <= 0) return;

draw_sprite_ext(spr_pointer_entity, 0, x, y, 1, 1, ___.angle, make_color_rgb(93, 193, 0), 1);