// Inherit the parent event
event_inherited();

// draw all the questDisplays here
var questDisplayTopLeft = new Vector2(topLeft.x + 17, topLeft.y + 69);
if (questDisplay1Index > -1) {

    draw_sprite(spr_questDisplayBottom, 0, questDisplayTopLeft.x, questDisplayTopLeft.y);
    var quest = GetQuestByIndex(questDisplay1Index);
    
    var imageScale = 56 / sprite_get_width(spr_NPCSpeaker);
    draw_sprite_ext(spr_NPCSpeaker, questSpeaker1, questDisplayTopLeft.x + 32, questDisplayTopLeft.y + 32, imageScale, imageScale, image_angle, quest.giver.color, 1);

    draw_sprite(spr_questDisplayOverlay, 0, questDisplayTopLeft.x, questDisplayTopLeft.y);
    
    scribble($"{quest.name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplayTopLeft.x + 71, questDisplayTopLeft.y + 14);

    scribble($"{quest.giver.Name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplayTopLeft.x + 71, questDisplayTopLeft.y + 31);

    scribble($"{QuestStateToString(quest.state)}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 236, 214))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplayTopLeft.x + 71, questDisplayTopLeft.y + 48);
}
else
{
    draw_sprite(spr_questDisplayEmpty, 0, questDisplayTopLeft.x, questDisplayTopLeft.y);
}

var questDisplay2TopLeft = new Vector2(topLeft.x + 17, topLeft.y + 133);
if (questDisplay2Index > -1) {

    draw_sprite(spr_questDisplayBottom, 0, questDisplay2TopLeft.x, questDisplay2TopLeft.y);
    var quest2 = GetQuestByIndex(questDisplay2Index);
    
    var image2Scale = 56 / sprite_get_width(spr_NPCSpeaker);
    draw_sprite_ext(spr_NPCSpeaker, questSpeaker2, questDisplay2TopLeft.x + 32, questDisplay2TopLeft.y + 32, image2Scale, image2Scale, image_angle, quest2.giver.color, 1);

    draw_sprite(spr_questDisplayOverlay, 0, questDisplay2TopLeft.x, questDisplay2TopLeft.y);
    
    scribble($"{quest2.name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplay2TopLeft.x + 71, questDisplay2TopLeft.y + 14);

    scribble($"{quest2.giver.Name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplay2TopLeft.x + 71, questDisplay2TopLeft.y + 31);

    scribble($"{QuestStateToString(quest2.state)}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 236, 214))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplay2TopLeft.x + 71, questDisplay2TopLeft.y + 48);
}
else
{
    draw_sprite(spr_questDisplayEmpty, 0, questDisplay2TopLeft.x, questDisplay2TopLeft.y);
}

var questDisplay3TopLeft = new Vector2(topLeft.x + 17, topLeft.y + 197);
if (questDisplay3Index > -1) {

    draw_sprite(spr_questDisplayBottom, 0, questDisplay3TopLeft.x, questDisplay3TopLeft.y);
    var quest3 = GetQuestByIndex(questDisplay3Index);
    
    var image3Scale = 56 / sprite_get_width(spr_NPCSpeaker);
    draw_sprite_ext(spr_NPCSpeaker, questSpeaker3, questDisplay3TopLeft.x + 32, questDisplay3TopLeft.y + 32, image3Scale, image3Scale, image_angle, quest3.giver.color, 1);

    draw_sprite(spr_questDisplayOverlay, 0, questDisplay3TopLeft.x, questDisplay3TopLeft.y);
    
    scribble($"{quest3.name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplay3TopLeft.x + 71, questDisplay3TopLeft.y + 14);

    scribble($"{quest3.giver.Name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplay3TopLeft.x + 71, questDisplay3TopLeft.y + 31);

    scribble($"{QuestStateToString(quest3.state)}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 236, 214))
        .transform(0.75, 0.75, image_angle)
        .draw(questDisplay3TopLeft.x + 71, questDisplay3TopLeft.y + 48);
}
else
{
    draw_sprite(spr_questDisplayEmpty, 0, questDisplay3TopLeft.x, questDisplay3TopLeft.y);
}


if (mouseOverQuest1)
{
    draw_sprite(spr_questDisplayShadow, 0, questDisplayTopLeft.x - 25, questDisplayTopLeft.y - 25);
}
else if (mouseOverQuest2)
{
    draw_sprite(spr_questDisplayShadow, 0, questDisplay2TopLeft.x - 25, questDisplay2TopLeft.y - 25);
}
else if (mouseOverQuest3)
{
    draw_sprite(spr_questDisplayShadow, 0, questDisplay3TopLeft.x - 25, questDisplay3TopLeft.y - 25);
}


draw_sprite(spr_QuestMenuOverlay, 0, x, y);
