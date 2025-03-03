currentState = ButtonState.Idle;

upSprite = sprButtonUp;
downSprite = sprButtonDown;

alarm[0] = 2;

function OnClick() { 
    global.vars.single = false;
    Transition(rmCharSelectMultiple, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}