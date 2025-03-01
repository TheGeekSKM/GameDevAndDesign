currentState = ButtonState.Idle;

upSprite = sprButtonUp;
downSprite = sprButtonDown;
alarm[0] = 1;

function OnClick() {
    global.vars.single = true; 
    Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}