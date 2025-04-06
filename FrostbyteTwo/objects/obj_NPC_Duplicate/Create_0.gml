// Inherit the parent event
event_inherited();

AddDialogueToList(undefined);

SetQuest(undefined);

function QuestLogic() 
{
    if (quest == undefined) return;
    var _quest = GetQuest(quest.name);
    
    switch (_quest.state) {
        case QuestState.Inactive:
            _quest.state = QuestState.Active;
            break;
        case QuestState.Active:
            _quest.state = QuestState.Completed;
            break;
        case QuestState.Completed:
            break;
    }
}