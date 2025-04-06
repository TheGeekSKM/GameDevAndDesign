// Inherit the parent event
event_inherited();

quest = undefined;
Subscribe("QuestSelected", function(_index) {
    quest = GetQuestByIndex(_index);
    if (stateMachine.get_current_state() == "hidden")
    {
        OpenMenu();
    }
})

