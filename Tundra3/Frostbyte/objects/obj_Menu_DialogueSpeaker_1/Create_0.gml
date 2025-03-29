// Inherit the parent event
event_inherited();
SetPlayerIndex(1);

currentDialogueLine = undefined;
currentIndex = 0;

Subscribe($"Player{playerIndex}Dialogue", function(dialogueLine) {
    currentDialogueLine = dialogueLine;
    currentIndex = irandom_range(0, 2);
});

function DrawGUI()
{
    if (currentDialogueLine == undefined) return;

    draw_sprite_ext(spr_NPCSpeaker, currentIndex, topLeft.x + 14, topLeft.y + 16, 1, 1, image_angle, currentDialogueLine.speakerData.speakerColor, 1);
}