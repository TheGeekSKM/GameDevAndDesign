if (!enabled) return;


var _x = 0;
var _y = 0;


if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
    _y = -1;
}

if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
    _y = 1;
}

if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
    _x = -1;
}

if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
    _x = 1;
    echo($"_x = {_x}");
}

if (_x != 0 || _y != 0) {
    Move(_x, _y);
    echo($"Move({_x}, {_y})");
}