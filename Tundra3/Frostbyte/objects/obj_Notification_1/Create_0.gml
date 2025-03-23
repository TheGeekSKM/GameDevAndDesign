textToDisplay = "";
time = 2 * game_get_speed(gamespeed_fps);

depth = -100;

scribbleText = undefined;
width = 0;
height = 0;
xScale = 1;
yScale = 1;

index = 0;

dataSet = false;


function SetData(_data) 
{
    textToDisplay = _data[0];
    time = 0.15 * string_length(textToDisplay) * game_get_speed(gamespeed_fps);
    alarm[0] = time;
    
    index = _data[1];

    scribbleText = scribble(textToDisplay)
        .align(fa_center, fa_middle)
        .starting_format("Font", c_black)
        .transform(1, 1, image_angle)
        .wrap(500)

    width = scribbleText.get_width();
    height = scribbleText.get_height();
    xScale = (width + 10) / sprite_width;
    yScale = (height + 10) / sprite_height;

    dataSet = true;
}