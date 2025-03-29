// Inherit the parent event
event_inherited();
SetPlayerIndex(1);

currentDialogueLine = undefined;

Subscribe($"Player{playerIndex}Dialogue", function(dialogueLine) {
    currentDialogueLine = dialogueLine;
});

function DrawGUI()
{
    if (currentDialogueLine == undefined) return;

    draw_sprite_ext(spr_NPCSpeaker, irandom_range(0, 2), topLeft.x + 14, topLeft.y + 16, 1, 1, image_angle, currentDialogueLine.speakerData.speakerColor, 1);
}