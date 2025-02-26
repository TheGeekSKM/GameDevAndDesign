currentState = ButtonState.Idle;

upSprite = sprButtonUp;
downSprite = sprButtonDown;

obj_kbBtn_Container.AddToList(other.id);

function OnClick() { 
    Transition(rmCharSelectSingle, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}