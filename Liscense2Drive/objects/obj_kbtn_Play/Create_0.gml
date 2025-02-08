// Inherit the parent event
event_inherited();


OnClickEnd = function()
{
    with (KeyboardButtonManager)
    {
        __keyBoardButtons = ds_list_create();
    }
    Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}
