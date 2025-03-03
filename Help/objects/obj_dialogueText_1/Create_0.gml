// Inherit the parent event
event_inherited();
vis = false;
text = "";
speakerName = ""

function SetText(_dialogueData)
{
    text = _dialogueData.text;
    image_blend = global.vars.playerColors[_dialogueData.playerID.playerIndex];
    speakerName = _dialogueData.speaker.interactableName;
}