// Inherit the parent event
event_inherited();
///

Subscribe("CraftingOpen", function() {
    OpenMenu();
    global.vars.PauseGame(id);
    UpdateCraftingButtons();
});

previousButtonHoverColor = make_color_rgb(215, 255, 204);
previousButtonClickColor = make_color_rgb(149, 255, 119);

nextButtonHoverColor = make_color_rgb(206, 245, 255);
nextButtonClickColor = make_color_rgb(119, 227, 255);

previousButton = instance_create_depth(topLeft.x + 113, topLeft.y + 26, depth - 1, obj_BASE_Button)
previousButton.SetText("< Previous")
previousButton.SetColors(previousButtonHoverColor, previousButtonClickColor)
previousButton.SetSize(207, 33)
previousButton.AddCallback(function() {
    DecrementPageIndex();
}) // add the callback to the next button

pageIndex = 0;
numberOfPages = ceil(GetNumberOfCrafting() / 3) - 1; // 3 quests per page

mouseOverRecipe1 = false;
mouseOverRecipe2 = false;
mouseOverRecipe3 = false;

nextButton = instance_create_depth(topLeft.x + 10, topLeft.y + 193, depth - 1, obj_BASE_Button)
nextButton.SetText("Next >")
nextButton.SetColors(nextButtonHoverColor, nextButtonClickColor)
nextButton.SetSize(207, 33)
nextButton.AddCallback(function() {
    IncrementPageIndex();
}) // add the callback to the next button


function IncrementPageIndex() {
    pageIndex += 1;
    if (pageIndex > numberOfPages) {
        pageIndex = 0;
    }
    UpdateCraftingButtons();
}

function DecrementPageIndex() {
    pageIndex -= 1;
    if (pageIndex < 0) {
        pageIndex = numberOfPages;
    }
    UpdateCraftingButtons();
}

function UpdateCraftingButtons()
{
    numberOfPages = ceil(GetNumberOfCrafting() / 3) - 1; // 3 quests per page
    
    recipeDisplay1Index = pageIndex * 3;
    recipeDisplay2Index = pageIndex * 3 + 1;
    recipeDisplay3Index = pageIndex * 3 + 2;

    if (recipeDisplay1Index >= GetNumberOfCrafting()) {
        recipeDisplay1Index = -1;
    }
    if (recipeDisplay2Index >= GetNumberOfCrafting()) {
        recipeDisplay2Index = -1;
    }
    if (recipeDisplay3Index >= GetNumberOfCrafting()) {
        recipeDisplay3Index = -1;
    }

    if (pageIndex == 0) {
        previousButton.SetColors(c_gray, c_gray);
        previousButton.SetText("X");
    } else {
        previousButton.SetColors(previousButtonHoverColor, previousButtonClickColor);
        previousButton.SetText("< Previous");
    }

    if (pageIndex == numberOfPages) {
        nextButton.SetColors(c_gray, c_gray);
        nextButton.SetText("X");
    } else {
        nextButton.SetColors(nextButtonHoverColor, nextButtonClickColor);
        nextButton.SetText("Next >");
    }
}

function OnMouseLeftClick()
{
    if (mouseOverRecipe1)
    {
        if (recipeDisplay1Index != -1)
            Raise("CraftingClicked", recipeDisplay1Index);
    }
    else if (mouseOverRecipe2)
    {
        if (recipeDisplay2Index != -1)
            Raise("CraftingClicked", recipeDisplay2Index);
    }
    else if (mouseOverRecipe3)
    {
        if (recipeDisplay3Index != -1)
            Raise("CraftingClicked", recipeDisplay3Index);
    }
    else
    {
        dragging = true;
        windowMouseOffset.x = guiMouseX - x;
        windowMouseOffset.y = guiMouseY - y;
    }
}

clickedRecipe = undefined;

craftButton = instance_create_depth(topLeft.x + 234, topLeft.y + 179, depth - 1, obj_BASE_Button)
craftButton.SetText("Craft")
craftButton.SetColors(make_color_rgb(149, 181, 144), make_color_rgb(86, 181, 72))
craftButton.SetSize(201, 44)
craftButton.SetPosition(topLeft.x + 234, topLeft.y + 179)
craftButton.SetDepth(depth - 1)
craftButton.AddCallback(function() {
    if (clickedRecipe != undefined) {
        clickedRecipe.Craft(global.vars.Player);
    }
}) // add the callback to the next button

Subscribe("CraftingClicked", function(_index) {
    if (_index < 0 || _index >= GetNumberOfCrafting()) {
        return; // Invalid index, do nothing
    }
    clickedRecipe = global.vars.DiscoveredRecipes[_index];
})




UpdateCraftingButtons();

closeButtonCallback = function() {
    global.vars.ResumeGame(global.vars.Player);
}