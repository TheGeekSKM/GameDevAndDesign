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

    draw_sprite_ext(currentDialogueLine.speaker, 0, x, y, 1, 1, image_angle, c_white, 1);
}