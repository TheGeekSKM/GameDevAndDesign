// Inherit the parent event
event_inherited();

currentDialogueLine = undefined;
currentDialogueScene = undefined;
currentScribble = undefined;


function StartDialogue(_dialogueScene)
{
    if (_dialogueScene.finished) return;
    currentDialogueScene = _dialogueScene;
    currentDialogueLine = currentDialogueScene.GetNextDialogue();
    CalculateScribble();
    Raise($"DialogueDisplay", currentDialogueLine);
}

function CalculateScribble()
{
     currentScribble = scribble($"{currentDialogueLine.speakerData.speakerName}: {currentDialogueLine.line}")
        .align(fa_center, fa_middle)
        .starting_format("VCR_OSD_Mono", c_black)
        .transform(0.75, 0.75, image_angle);
}


nextButtonWidth = 120;
nextButtonHeight = 40;

nextButtonHoverColor = make_color_rgb(255, 229, 206)
nextButtonClickColor = make_color_rgb(255, 170, 94)

nextLineButton = instance_create_depth(x, y + (sprite_width / 2) + (nextButtonHeight / 2), depth, obj_BASE_Button);
nextLineButton.SetText("Continue >");
nextLineButton.SetColors(nextButtonHoverColor, nextButtonClickColor);
nextLineButton.SetSize(nextButtonWidth + 50, nextButtonHeight);
nextLineButton.SetPosition(x, y + (sprite_height / 2) + (nextButtonHeight / 2));
nextLineButton.SetDepth(depth - 1);
nextLineButton.AddCallback(function() {
    if (currentDialogueScene == undefined) return;
    
    currentDialogueLine = currentDialogueScene.GetNextDialogue();
    if (currentDialogueLine == undefined)
    {
        Raise($"DialogueEnd", currentDialogueScene);
        return;
    }
    
    CalculateScribble();
    Raise($"DialogueDisplay", currentDialogueLine);
});
