draw_self();

if (obj_Mouse.currentInteractable == id && global.GameData.GenreName != Name) 
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_yellow, 1);
    
    scribble(Name)
        .align(fa_center, fa_top)
        .starting_format("VCR_OSD_Mono", c_yellow)
        .transform(0.75, 0.75, image_angle)
        .wrap(((sprite_width) - 4) * 1.3333)
        .draw(x, y - (sprite_height / 2) + 3);
    
}
else if (global.GameData.GenreName == Name)
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_aqua, 1);
        
        scribble($"[wave]{Name}[/]")
            .align(fa_center, fa_top)
            .starting_format("VCR_OSD_Mono", c_aqua)
            .transform(0.75, 0.75, image_angle)
            .wrap(((sprite_width) - 4) * 1.3333)
            .draw(x, y - (sprite_height / 2) + 3);
}
else {
    scribble(Name)
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(0.75, 0.75, image_angle)
        .wrap(((sprite_width) - 4) * 1.3333)
        .draw(x, y - (sprite_height / 2) + 8);
}

var personalSatisText = PersonalSatisfactionMod >= 1.125 ? $"Personal Satisfaction: [c_lime]{PersonalSatisfactionMod}[/]" : $"Personal Satisfaction: [c_red]{PersonalSatisfactionMod}[/]";
var interestText = InterestStat > 3 ? $"Public Interest: [c_lime]{InterestStat}[/]" : $"Public Interest: [c_red]{InterestStat}[/]"; 

scribble($"{personalSatisText}\n{interestText}")
        .align(fa_center, fa_bottom)
        .starting_format("VCR_OSD_Mono", c_white)
        .transform(0.5, 0.5, image_angle)
        .wrap(((sprite_width) - 4) * 2)
        .draw(x, y + (sprite_height / 2) - 2);