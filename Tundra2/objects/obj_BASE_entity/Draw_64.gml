if (global.vars.debug)
{
    var str = $"Max Health: {maxHealth}\nCarry Weight: {carryWeight}\nArmor Resistance: {armorResistance}\nCrit Chance: {critChance}\nCrit Damage: {critDamage}\nMove Speed: {moveSpeed}"
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text_ext_transformed_color(x, y - 10, str, 4, 256, 1, 1, 0, c_black, c_black, c_black, c_black, 1);
}