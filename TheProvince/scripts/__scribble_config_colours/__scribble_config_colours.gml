// Feather disable all
/// Creates a collection of colour names that map to 24-bit BGR colours
/// Use scribble_rgb_to_bgr() to convert from industry standard RGB colour codes to GM's native BGR format
/// 
/// To add or change colours at runtime, use scribble_color_set()
/// 
/// N.B. That this function is executed on boot. You should never execute this function yourself!

function __scribble_config_colours()
{
    static _colours = {
        //Duplicate GM's native colour constants
        c_aqua:    c_aqua,
        c_black:   c_black,
        c_blue:    c_blue,
        c_dkgray:  c_dkgray,
        c_dkgrey:  c_dkgrey,
        c_fuchsia: c_fuchsia,
        c_gray:    c_gray,
        c_green:   c_green,
        c_gray:    c_gray,
        c_grey:    c_grey,
        c_lime:    c_lime,
        c_ltgray:  c_ltgray,
        c_ltgrey:  c_ltgrey,
        c_maroon:  c_maroon,
        c_navy:    c_navy,
        c_olive:   c_olive,
        c_orange:  c_orange,
        c_purple:  c_purple,
        c_red:     c_red,
        c_silver:  c_silver,
        c_teal:    c_teal,
        c_white:   c_white,
        c_yellow:  c_yellow,
        
        c_darkBlue: make_color_rgb(13, 14, 69),
        c_lighterBlue: make_color_rgb(32, 60, 86),
        c_darkPurple: make_color_rgb(84, 78, 104),
        c_lighterPurple: make_color_rgb(141, 105, 122),
        c_orangePalette: make_color_rgb(208, 129, 89),
        c_yellowPalette: make_color_rgb(255, 170, 94),
        c_parchment: make_color_rgb(255, 212, 163),
        c_lightParchment: make_color_rgb(255, 236, 214),

    
        //Here are some example colours
        c_coquelicot: scribble_rgb_to_bgr(0xff3800),
        c_smaragdine: scribble_rgb_to_bgr(0x50c875),
        c_xanadu:     scribble_rgb_to_bgr(0x738678),
        c_amaranth:   scribble_rgb_to_bgr(0xe52b50),
    };
    
    return _colours;
}
