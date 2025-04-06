// Inherit the parent event
event_inherited();

//

if (currentState == ButtonState.Hover)
{
    if (point_in_rectangle(guiMouseX, guiMouseY, topLeft.x + 17, topLeft.y + 69, topLeft.x + 217, topLeft.y + 133))
    {
        mouseOverQuest1 = true;
    }
    else
    {
        mouseOverQuest1 = false;
    }

    if (point_in_rectangle(guiMouseX, guiMouseY, topLeft.x + 17, topLeft.y + 133, topLeft.x + 217, topLeft.y + 197))
    {
        mouseOverQuest2 = true;
    }
    else
    {
        mouseOverQuest2 = false;
    }

    if (point_in_rectangle(guiMouseX, guiMouseY, topLeft.x + 17, topLeft.y + 197, topLeft.x + 217, topLeft.y + 261))
    {
        mouseOverQuest3 = true;
    }
    else
    {
        mouseOverQuest3 = false;
    }
}


previousButton.x = x;
previousButton.y = topLeft.y + 52; // move it below the top left corner of the panel

nextButton.x = x;
nextButton.y = topLeft.y + 277; // move it below the previous button