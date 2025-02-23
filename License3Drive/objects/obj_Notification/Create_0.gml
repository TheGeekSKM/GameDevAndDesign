textToDisplay = "";
time = 1;

Subscribe("NotificationIn", function(_string) {
    textToDisplay = _string;
    time = 0.15 * string_length(_string);
    alarm[0] = (time) * game_get_speed(gamespeed_fps);
})


