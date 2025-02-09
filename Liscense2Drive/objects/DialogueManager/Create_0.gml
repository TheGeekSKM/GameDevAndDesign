SpawnDialogue = function(_speakerSprite, _speakerName, _speakingText)
{
    with (obj_DialogueSpeaker)
    {
        SetDraw(_speakerSprite);
    }
    
    with (obj_DialogueText)
    {
        SetText(_speakerName, _speakingText);
    }
    
    UIManager.ShowUI(MenuState.DialogueMenu);
}