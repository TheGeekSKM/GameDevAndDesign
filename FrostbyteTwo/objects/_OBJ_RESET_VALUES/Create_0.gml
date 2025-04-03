RestartEventSystem();
global.vars = new Vars();
global.ShadowFont = font_add_sprite(spr_ShadowFont, vk_space, false, 0);
global.NormalFont = font_add_sprite(spr_NormalFont, vk_space, false, 0);
global.OutlineFont = font_add_sprite(spr_OutlineFont, vk_space, false, 0);
scribble_font_bake_outline_and_shadow("spr_ShadowFont", "spr_ShadowFontEffects", 0, 0, SCRIBBLE_OUTLINE.EIGHT_DIR_THICK, 0, false);