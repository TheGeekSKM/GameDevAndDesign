// Inherit the parent event
event_inherited();
SetPlayerIndex(1);

text = undefined;

currentDialogueScene = undefined;

function StartDialogue(_dialogueScene)
{
    if (_dialogueScene.finished) return;
    currentDialogueScene = _dialogueScene;
    text = currentDialogueScene.GetNextDialogue();
    global.vars.Players[playerIndex].controller.OpenMenu();
    Raise($"Player{playerIndex}Dialogue", text);
}

function DrawGUI()
{
    if (text == undefined) return;
    scribble($"{text.speaker}: {text.line}")
        .align(fa_center, fa_middle)
        .starting_format("Font", c_white)
        .transform(0.75, 0.75, image_angle)
        .wrap(346)
        .draw(x, y);
}
function Step()
{
    var action = global.vars.InputManager.IsPressed(playerIndex, ActionType.Action1);
    if (action)
    {
        if (currentDialogueScene == undefined) 
        { 
            return;
        }
        
        text = currentDialogueScene.GetNextDialogue();
        Raise($"Player{playerIndex}Dialogue", text);
        
        if (!currentDialogueScene.CanContinue())
        {
        global.vars.Players[playerIndex].controller.CloseMenu(); 
        }
    }    
}
