percentile = 1;
player = instance_find(obj_Player, 0);

Subscribe("Damage", function(_arr) {
    if (_arr[0].owner == player) {
        percentile = _arr[0].currentHealth / _arr[0].maxHealth;
        //echo($"Max Health: {_arr[0].maxHealth}, and Current Health: {_arr[0].currentHealth}")
    }
});

col = make_color_rgb(0, 255, 0)

hoverCounter = 0;
hovered = false;