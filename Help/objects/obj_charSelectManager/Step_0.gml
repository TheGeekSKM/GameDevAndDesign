if (obj_Player1Select.ready and obj_Player2Select.ready and !doOnce)
{
    Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    doOnce = true;
}