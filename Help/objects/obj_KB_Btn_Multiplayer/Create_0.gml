currentState = ButtonState.Idle;

upSprite = sprButtonUp;
downSprite = sprButtonDown;

alarm[0] = 2;

function OnClick() { 
    Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}