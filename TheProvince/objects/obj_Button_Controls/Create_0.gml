// Inherit the parent event
event_inherited();

AddButtonClickCallback(function() {
    Transition(rmControls, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
});