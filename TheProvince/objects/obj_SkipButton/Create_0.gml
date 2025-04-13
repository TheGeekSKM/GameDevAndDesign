event_inherited();

AddButtonClickCallback(function() {
    if (obj_TextController.typist.get_state() < 1)
    {
        obj_TextController.SkipText();
    }
    else
    {
        Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);   
    }
});