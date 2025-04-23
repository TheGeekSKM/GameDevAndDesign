// Configuration
display_width = sprite_width;
display_height = sprite_height;
padding = 5;
font_used = VCR_OSD_Mono; // Optional: assign a font here
text_color = c_white;

topLeftX = 0;
topLeftY = 0;

// State
message_list = [];
line_heights = [];
scroll_offset = 0;
target_scroll_offset = 0;
scroll_speed = 0.2;

atBottom = false;
atTop = false;

textTransform = 0.6;


function __getTotalLineHeight()
{
    var result = 0;
    for (var i = 0; i < array_length(line_heights); i++)
    {
        result += line_heights[i];
    }
    
    return result;
}

// function ObfuscateText(_msg, _burnout) {
//     var out = "";
    
//     // Start distorting from burnout 5 onward
//     var intensity = clamp((_burnout - 5) / 5, 0, 1); 
//     // 5 burnout = 0% obfuscation, 10 burnout = 100%

//     for (var i = 1; i <= string_length(_msg); i++) {
//         var c = string_char_at(_msg, i);

//         // Obfuscate this character with a chance based on intensity
//         if (random() < intensity) {
//             // Replace with a random printable character
//             // You can swap this range for glitchier output later
//             var randChar = chr(irandom_range(33, 126)); 
//             out += randChar;
//         } else {
//             out += c;
//         }
//     }

//     return out;
// }

function ObfuscateText(_msg, _burnout) {
    var out = "";
    var intensity = clamp((_burnout - 5) / 5, 0, 1);  // 0 at burnout 5, 1 at 10

    var glitchChars = ["@", "#", "*", "~", "&", "?", "!", "%", "+", "="];
    var vowels = "aeiou";
    var flickerColors = ["c_red", "c_lime", "c_yellow", "c_aqua"];

    var word = "";
    var wordBuffer = "";

    for (var i = 1; i <= string_length(_msg); i++) {
        var c = string_char_at(_msg, i);

        if (c == " " || i == string_length(_msg)) {
            if (i == string_length(_msg)) word += c;

            var corrupted = "";
            var maxCorrupt = ceil(string_length(word) / 5);

            for (var j = 1; j <= string_length(word); j++) {
                var wc = string_char_at(word, j);
                var corruptChar = wc;

                if (irandom_range(0, string_length(word)) < maxCorrupt && random(1) < intensity) {
                    // Option 1: replace vowel with random le1tter
                    if (string_pos(wc, vowels) > 0 && random(1) < 0.5) {
                        corruptChar = chr(irandom_range(97, 122));
                    } else {
                        corruptChar = ChooseFromArray(glitchChars);
                    }

                    // Optional color flicker if burnout is very high
                    if (intensity > 0.85 && random(1) < 0.5) {
                        var flicker = ChooseFromArray(flickerColors);
                        echo(flicker)
                        corruptChar = flicker + corruptChar + "[/]";
                    }
                }

                corrupted += corruptChar;
            }

            out += corrupted + (c == " " ? " " : "");
            word = "";
        } else {
            word += c;
        }
    }

    return out;
}

// function AddMessage(_msg, _trimEndline = false) {
//     _msg = string_trim(_msg);

//     // Start obfuscating softly from burnout 5
//     if (global.GameData != undefined && global.GameData.Burnout >= 5) {
//         _msg = ObfuscateText(_msg, global.GameData.Burnout);
//     }

//     array_push(message_list, _msg);
    
//     var scrib = scribble(_msg)
//         .align(fa_left, fa_top)
//         .starting_format("VCR_OSD_Mono")
//         .transform(textTransform, textTransform, 0)
//         .wrap(sprite_width / textTransform);
    
//     var h = scrib.get_height() * textTransform;
//     array_push(line_heights, h);

//     var total = __getTotalLineHeight() + ((array_length(message_list)-1) * padding);
//     target_scroll_offset = max(0, total - display_height);
// }

function AddMessage(_msg, _trimEndline = false) {
    _msg = string_trim(_msg);

    if (variable_global_exists("GameData") && global.GameData.Burnout >= 5) {
        _msg = ObfuscateText(_msg, global.GameData.Burnout);
    }

    array_push(message_list, _msg);
    
    var scrib = scribble(_msg)
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono")
        .transform(textTransform, textTransform, 0)
        .wrap(sprite_width / textTransform);
    
    var h = scrib.get_height() * textTransform;
    array_push(line_heights, h);

    var total = __getTotalLineHeight() + ((array_length(message_list)-1) * padding);
    target_scroll_offset = max(0, total - display_height);
}


function ClearBox()
{
    message_list = [];
    scroll_offset = 0;
    target_scroll_offset = 0;
    scroll_speed = 0.2;
}