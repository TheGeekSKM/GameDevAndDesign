// Inherit the parent event
event_inherited();

Subscribe("DialogueOpen", function(_dialogueScene) {
    OpenMenu();
    obj_DialogueText.StartDialogue(_dialogueScene);
})

Subscribe("DialogueEnd", function(_dialogueScene) {
    CloseMenu();
})