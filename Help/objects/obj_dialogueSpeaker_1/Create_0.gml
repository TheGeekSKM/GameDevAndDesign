// Inherit the parent event
event_inherited();
vis = false;
speaker = noone;

function SetSpeaker(_dialogueData)
{
    speaker = _dialogueData.speaker;
    image_blend = global.vars.playerColors[_dialogueData.playerID.playerIndex];
}
