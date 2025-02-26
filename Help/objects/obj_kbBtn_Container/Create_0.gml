allBtns = [];
selectIndex = 0;
oldIndex = 0;

containerType = ContainerType.UpDown;

function AddToList(_id) { array_push(allBtns, _id); }

function UpdateHover()
{
    for (var i = 0; i < array_length(allBtns); i++)
    {
        if (selectIndex == i) allBtns[i].currentState = ButtonState.Hover; 
        else allBtns[i].currentState = ButtonState.Idle;
    }
}

function ClickStart()
{
    allBtns[selectIndex].currentState = ButtonState.Click;
}

function ClickEnd()
{
    allBtns[selectIndex].currentState = ButtonState.Idle;
    allBtns[selectIndex].OnClick();
}

alarm[0] = 10;