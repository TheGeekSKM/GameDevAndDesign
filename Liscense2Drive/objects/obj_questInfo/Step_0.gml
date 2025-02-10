var ind = obj_questList.selectedIndex;
var quest = global.QuestLibrary[ind];


if (quest.questState == QuestState.Idle) return;
    
function ShowQuestState(_questState)
{
    var returnString = "";
    switch (_questState)
    {
        case QuestState.Idle:
            returnString = "Not Yet Started";
            break;
        case QuestState.Started:
            returnString = "Started";
            break;
        case QuestState.Completed:
            returnString = "Completed";
            break;                
    }
    
    return returnString;
}

textToDisplay = string_concat(
    "Quest State: ", ShowQuestState(quest.questState), "\n",
    "Quest Assigned By: ", quest.questAssigner, "\n",
    "Description: ", "\n",
    quest.questDescription,
)