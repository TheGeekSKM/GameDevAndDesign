currentState = ButtonState.Idle;

upSprite = sprButtonUp;
downSprite = sprButtonDown;

alarm[0] = 4;

function OnClick() { 
    Transition(rmCredits, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}