// Inherit the parent event
event_inherited();
var displayText = "";
var font = "";
var textPos = new Vector2(x, y);


switch (currentState)
{
    case ButtonState.Idle:
        displayText = text;
        font = "CustomFont";
        textPos.Set(x, y);
        sprite_index = upSprite;
        image_blend = c_white;
        break;
    
    case ButtonState.Hover:
        image_blend = hoverColor;
        displayText = string_concat("> ", text, " <")
        font = "CustomFont_Effects";
        textPos.Set(x, y + 4);
        sprite_index = downSprite;
        break;    
    
    case ButtonState.Click:
        image_blend = clickColor;
        displayText = string_concat("> ", text, " <")
        font = "CustomFont_Effects";
        textPos.Set(x, y + 4);    
        break;    
}

scribble(displayText)
    .align(fa_center, fa_middle)
    .starting_format(font, c_black)
    .draw(textPos.x, textPos.y);