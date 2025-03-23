controller.Draw();

if (canAttack)
{
    draw_sprite_ext(targetSprite, 0, target.x, target.y, 1, 1, 0, global.vars.PlayerColors[PlayerIndex], 1);
}