// Inherit the parent event
event_inherited();

if (global.QuestLibrary[0].questState == QuestState.Completed and global.QuestLibrary[1].questState == QuestState.Completed)
{
    room_goto(rmWin);
}

