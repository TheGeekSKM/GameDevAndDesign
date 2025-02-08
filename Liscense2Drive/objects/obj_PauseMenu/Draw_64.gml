// Inherit the parent event
event_inherited();

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_black);

//switch(selectedIndex)
//{
    //case 0:
        //draw_set_font(Born_DropShadow);
        //draw_text_transformed(x, y - 50, string_concat("> ", options[0], " <"), 2, 2, image_angle);
        //
        //draw_set_font(Born);
        //draw_text(x, y + 50, options[1]);
        //
        //break;
    //case 1:
        //draw_set_font(Born);
        //draw_text(x, y, options[0]);
        //
        //draw_set_font(Born_DropShadow);
        //draw_text_transformed(x, y + 50, string_concat("> ", options[1], " <"), 2, 2, image_angle);
        //
        //break;
        //
//}

var font = draw_get_font();
var lineHeight = string_height("A") + 5;
var length = array_length(options);
var totalHeight = length * lineHeight;
var startY = y - (totalHeight / 2) + (lineHeight / 2);

for (var i = 0; i < array_length(options); i++) 
{
    var textX = x;
    var textY = (i * lineHeight) + startY;
    
    if (selectedIndex == i)
    {
        draw_text_transformed(textX, textY, string_concat("> ", options[i], " <"), 2, 2, image_angle);
    }
    else 
    {
        draw_text_transformed(textX, textY, options[i], 1, 1, image_angle);
    }
     
}


draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);


