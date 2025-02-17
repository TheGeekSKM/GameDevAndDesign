vis = false;
buttons = [];
selectedIndex = 0;

Subscribe("CrashReciever Recieved", function() {
    array_push(buttons, new EquippableItemData("Crash Detector", ItemState.Unequipped));
})

Subscribe("Compass Recieved", function() {
    array_push(buttons, new EquippableItemData("Compass", ItemState.Unequipped));        
})

function DrawGUI()
{
    var _x = x + (sprite_width / 2);
    var _y = y + 150;
    
    scribble(string_concat("Documents: ", obj_player.paperAmount))
        .align(fa_center, fa_middle)
        .starting_format("VCR_OS_Mono", c_white)
        .transform(1, 1, image_angle)        
        .draw(x + (sprite_width / 2), y + 75);
    
    scribble(string_concat("Car Parts: ", obj_player.carPartsAmount))
        .align(fa_center, fa_middle)
        .starting_format("VCR_OS_Mono", c_white)
        .transform(1, 1, image_angle)      
        .draw(x + (sprite_width / 2), y + 100);
    
    for (var i = 0; i < array_length(buttons); i++) {
        if (i == selectedIndex)
        {
            scribble(string_concat("> ", buttons[i].name, ItemStateToString(buttons[i].state), " <"))
                .align(fa_center, fa_middle)
                .transform(1.5, 1.5, image_angle)
                .starting_format("VCR_OS_Mono_Effects", c_yellow)
                .sdf_shadow(c_black, 0.7, 0, 0, 0.2)
                .draw(_x, _y + (30 * i));        
        }
        else {
            scribble(string_concat(buttons[i].name, ItemStateToString(buttons[i].state)))
                .align(fa_center, fa_middle)
                .transform(1, 1, image_angle)
                .starting_format("VCR_OS_Mono", c_white)
                .draw(_x, _y + (30 * i));            
        }
    }
}