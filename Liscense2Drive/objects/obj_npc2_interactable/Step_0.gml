// Inherit the parent event
event_inherited();

if (global.QuestLibrary[0].questState == QuestState.Completed and global.QuestLibrary[1].questState == QuestState.Completed)
{
    Transition(rmWin, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}

