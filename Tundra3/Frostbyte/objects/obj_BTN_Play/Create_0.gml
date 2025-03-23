// Inherit the parent event
event_inherited();

function OnClickEnd()
{
    Transition(rmAttribute, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide)
}