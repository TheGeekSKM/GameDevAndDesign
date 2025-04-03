event_inherited();
textToDisplay = "";
time = 2 * game_get_speed(gamespeed_fps);

depth = -100;

echo($"Bungus: {x}, {y}")

if (instance_exists(global.NotificationManager))
{
    global.NotificationManager.SetRef(id);
}

scribbleText = undefined;
width = 0;
height = 0;
xScale = 1;
yScale = 1;

dataSet = false;


function OnMouseLeftClick()
{
    echo("BUNGUS")
    if (dataSet) {
        Raise("NotificationClose", id);
        dataSet = false;
    }
}


function SetData(_data) 
{
    echo(_data)
    textToDisplay = _data;
    time = 0.15 * string_length(textToDisplay) * game_get_speed(gamespeed_fps);
    alarm[0] = time;
    

    scribbleText = scribble(textToDisplay)
        .align(fa_center, fa_middle)
        .starting_format("spr_OutlineFont", c_white)
        .transform(1, 1, image_angle)
        .wrap(400)

    width = scribbleText.get_width();
    height = scribbleText.get_height();
    xScale = (width + 24) / sprite_width;
    yScale = (height + 16) / sprite_height;

    dataSet = true;
}