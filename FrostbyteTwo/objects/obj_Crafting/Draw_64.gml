draw_self();


scribble(Name)
    .align(fa_center, fa_middle)
    .starting_format("spr_ShadowFont", c_white)
    .transform(1, 1, image_angle)
    .wrap(sprite_width - 36)
    .draw(topLeft.x + 334, y - (sprite_height / 2) + 18)



var recipeDisplayTopLeft = new Vector2(topLeft.x + 10, topLeft.y + 43); // Adjusted position for recipe display
if (recipeDisplay1Index > -1) 
{
    draw_sprite(spr_craftingBackground, 0, recipeDisplayTopLeft.x, recipeDisplayTopLeft.y);
    var recipe = GetCraftingByIndex(recipeDisplay1Index);
    var outPutItemSprite = recipe.outputItems[0].item.sprite;

    scribble($"{recipe.name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(recipeDisplayTopLeft.x + 65, recipeDisplayTopLeft.y + 25);

    if (mouseOverRecipe1) {
        draw_sprite(spr_craftingOverlayHover, 0, recipeDisplayTopLeft.x, recipeDisplayTopLeft.y);
        draw_sprite(spr_craftingMenu1HoverOverlay, 0, topLeft.x, topLeft.y);
    } else {
        draw_sprite(spr_craftingOverlayNormal, 0, recipeDisplayTopLeft.x, recipeDisplayTopLeft.y);
    }
    
        draw_sprite(outPutItemSprite, 0, recipeDisplayTopLeft.x + 42 + 8, recipeDisplayTopLeft.y + 15 + 8);


} 
else 
{
    if (mouseOverRecipe1)
    {
        draw_sprite(spr_craftingBackgroundEmptyHover, 0, recipeDisplayTopLeft.x, recipeDisplayTopLeft.y);    
                draw_sprite(spr_craftingMenu1HoverOverlay, 0, topLeft.x, topLeft.y);
    }
    else
    {
        draw_sprite(spr_craftingBackgroundEmpty, 0, recipeDisplayTopLeft.x, recipeDisplayTopLeft.y);   
    }
}

var recipeDisplay2TopLeft = new Vector2(topLeft.x + 10, topLeft.y + 93); // Adjusted position for recipe display
if (recipeDisplay2Index > -1) 
{
    draw_sprite(spr_craftingBackground, 0, recipeDisplay2TopLeft.x, recipeDisplay2TopLeft.y);
    var recipe = GetCraftingByIndex(recipeDisplay2Index);
    var outPutItemSprite = recipe.outputItems[0].item.sprite;

    scribble($"{recipe.name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(recipeDisplay2TopLeft.x + 65, recipeDisplay2TopLeft.y + 25);

    if (mouseOverRecipe2) {
        draw_sprite(spr_craftingOverlayHover, 0, recipeDisplay2TopLeft.x, recipeDisplay2TopLeft.y);
        draw_sprite(spr_craftingMenu2HoverOverlay, 0, topLeft.x, topLeft.y);
    } else {
        draw_sprite(spr_craftingOverlayNormal, 0, recipeDisplay2TopLeft.x, recipeDisplay2TopLeft.y);
    }
    
        draw_sprite(outPutItemSprite, 0, recipeDisplay2TopLeft.x + 42 + 8, recipeDisplay2TopLeft.y + 15 + 8);


} 
else 
{
    if (mouseOverRecipe2)
    {
        draw_sprite(spr_craftingBackgroundEmptyHover, 0, recipeDisplay2TopLeft.x, recipeDisplay2TopLeft.y);    
                draw_sprite(spr_craftingMenu2HoverOverlay, 0, topLeft.x, topLeft.y);
    }
    else
    {
        draw_sprite(spr_craftingBackgroundEmpty, 0, recipeDisplay2TopLeft.x, recipeDisplay2TopLeft.y);   
    }
}

var recipeDisplay3TopLeft = new Vector2(topLeft.x + 10, topLeft.y + 143); // Adjusted position for recipe display
if (recipeDisplay3Index > -1) 
{
    draw_sprite(spr_craftingBackground, 0, recipeDisplay3TopLeft.x, recipeDisplay3TopLeft.y);
    var recipe = GetCraftingByIndex(recipeDisplay3Index);
    var outPutItemSprite = recipe.outputItems[0].item.sprite;

    scribble($"{recipe.name}")
        .align(fa_left, fa_center)
        .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
        .transform(0.75, 0.75, image_angle)
        .draw(recipeDisplay3TopLeft.x + 65, recipeDisplay3TopLeft.y + 25);

    if (mouseOverRecipe3) {
        draw_sprite(spr_craftingOverlayHover, 0, recipeDisplay3TopLeft.x, recipeDisplay3TopLeft.y);
        draw_sprite(spr_craftingMenu3HoverOverlay, 0, topLeft.x, topLeft.y);
    } else {
        draw_sprite(spr_craftingOverlayNormal, 0, recipeDisplay3TopLeft.x, recipeDisplay3TopLeft.y);
    }
    
    draw_sprite(outPutItemSprite, 0, recipeDisplay3TopLeft.x + 42 + 8, recipeDisplay3TopLeft.y + 15 + 8);


} 
else 
{
    if (mouseOverRecipe3)
    {
        draw_sprite(spr_craftingBackgroundEmptyHover, 0, recipeDisplay3TopLeft.x, recipeDisplay3TopLeft.y);    
                draw_sprite(spr_craftingMenu3HoverOverlay, 0, topLeft.x, topLeft.y);
    }
    else
    {
        draw_sprite(spr_craftingBackgroundEmpty, 0, recipeDisplay3TopLeft.x, recipeDisplay3TopLeft.y);   
    }
}


if (clickedRecipe == undefined) return;
scribble(clickedRecipe.ToString())
    .align(fa_left, fa_top)
    .starting_format("VCR_OSD_Mono", make_color_rgb(255, 170, 94))
    .transform(0.75, 0.75, image_angle)
    .sdf_outline(c_black, 2)
    .wrap(201 * 1.333)
    .draw(topLeft.x + 238, topLeft.y + 34);

draw_sprite(spr_craftingMenuOverlay, 0, topLeft.x, topLeft.y); // Draw the overlay on top of the crafting menu