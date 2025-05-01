maxWidth = 32 * 5;
maxHeight = 20;

healthBarMinX = x + 2;
healthBarMaxX = x + maxWidth - 2;

healthBarMinY = y + 2;
healthBarMaxY = y + maxHeight - 2;

healthBarWidth = healthBarMaxX - healthBarMinX;
currentFillPercent = 1;
currentBarWidth = healthBarWidth * currentFillPercent;
currentBarXScale = currentBarWidth / sprite_get_width(spr_pound);
xScale = currentBarXScale;

obj_Player.___.onDamageCallback = function(_data) {
    currentFillPercent = _data.Percentage;
    currentBarWidth = healthBarWidth * currentFillPercent;
    if (currentFillPercent <= 0) {
        currentFillPercent = 0;
    }

    currentBarXScale = currentBarWidth / sprite_get_width(spr_pound);

}

obj_Player.___.onDeathCallback = function() {
    currentFillPercent = 0;
    currentBarWidth = healthBarWidth * currentFillPercent;
    currentBarXScale = currentBarWidth / sprite_get_width(spr_pound);
}