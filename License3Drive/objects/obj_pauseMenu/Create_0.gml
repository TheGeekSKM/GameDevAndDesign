vis = false;

buttons = ["Resume", "Quest Log", "Inventory", "Main Menu", "Exit"];
buttonFuncs = [
    function() {
        Raise("Resume", id);
    }, 
    function() {
        Raise("Quest", id);        
    }, 
    function() {
        Raise("Inventory", id);        
    },
    function() {
        
        game_restart();
        obj_UIManager.ShowUI(MenuState.NoMenu);        
    },
    function() {
        Raise("Exit", id);        
    },
];
selectedIndex = 0;

function DrawGUI()
{
    var _x = x + sprite_width / 2;
    var _y = y + 88;
    
    for (var i = 0; i < array_length(buttons); i++) {
        if (i == selectedIndex)
        {
            scribble(string_concat("> ", buttons[i], " <"))
                .align(fa_center, fa_middle)
                .transform(1.5, 1.5, image_angle)
                .starting_format("VCR_OS_Mono_Effects", c_yellow)
                .sdf_shadow(c_black, 0.7, 0, 0, 0.2)
                .draw(_x, _y + (30 * i));
        }
        else {
            scribble(string_concat(buttons[i]))
                .align(fa_center, fa_middle)
                .transform(1, 1, image_angle)
                .starting_format("VCR_OS_Mono", c_white)
                .draw(_x, _y + (30 * i));
        }
    }
}

function DoAction() { buttonFuncs[selectedIndex](); }
