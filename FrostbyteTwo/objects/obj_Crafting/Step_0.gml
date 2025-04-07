// Inherit the parent event
event_inherited();
///

previousButton.SetPosition(topLeft.x + 113, topLeft.y + 26); // move it below the top left corner of the panel
nextButton.SetPosition(topLeft.x + 113, topLeft.y + 209); // move it below the previous button
craftButton.SetPosition(topLeft.x + 334, topLeft.y + 201); // move it below the previous button

if (currentState == ButtonState.Hover)
{
    if (point_in_rectangle(guiMouseX, guiMouseY, topLeft.x + 10, topLeft.y + 43, topLeft.x + 10 + 207, topLeft.y + 43 + 50))
    {
        mouseOverRecipe1 = true;
    }
    else
    {
        mouseOverRecipe1 = false;
    }

    if (point_in_rectangle(guiMouseX, guiMouseY, topLeft.x + 10, topLeft.y + 93, topLeft.x + 10 + 207, topLeft.y + 93 + 50))
    {
        mouseOverRecipe2 = true;
    }
    else
    {
        mouseOverRecipe2 = false;
    }

    if (point_in_rectangle(guiMouseX, guiMouseY, topLeft.x + 10, topLeft.y + 143, topLeft.x + 10 + 207, topLeft.y + 143 + 50))
    {
        mouseOverRecipe3 = true;
    }
    else
    {
        mouseOverRecipe3 = false;
    }
}