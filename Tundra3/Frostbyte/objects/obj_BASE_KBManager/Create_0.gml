buttons = [];
selectIndex = 0;
playerIndex = 0;
leftRight = false;
maxNumOfButtons = 10;

vis = false;

function SetData(_playerIndex, _leftRight)
{
    playerIndex = _playerIndex;
    leftRight = _leftRight;
}

function AddButtonToList(kbBTNID)
{
    if (!array_contains(buttons, kbBTNID))
    {
        array_push(buttons, kbBTNID);
    }
}

function UpdateButton()
{
    for (var i = 0; i < array_length(buttons); i++)
    {
        if (i == selectIndex) {
            buttons[i].fsm.change("hovered");
        }
        else buttons[i].fsm.change("idle");
    }
    

}

function OnButtonClick()
{
    if (buttons[selectIndex].fsm.state_is("hovered"))
    {
        buttons[selectIndex].fsm.change("clicked");
    }
}

function OnButtonClickEnd()
{
    if (buttons[selectIndex].fsm.state_is("clicked"))
    {
        buttons[selectIndex].fsm.change("hovered");
        buttons[selectIndex].OnClickEnd();
    }
}

alarm[0] = 5;

depth = Depth;