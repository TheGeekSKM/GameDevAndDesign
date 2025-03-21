buttons = [];
selectIndex = 0;

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
        if (i == selectIndex) buttons[i].fsm.change("hovered");
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
    }
}