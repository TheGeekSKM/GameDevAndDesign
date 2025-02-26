buttons = [];
selectIndex = 0;
screenType = ScreenType.Center;
container = ContainerType.UpDown;

function UpdateHover()
{
    for (var i = 0; i < array_length(buttons); i++)
    {
        if (selectIndex == i) buttons[i].currentState = ButtonState.Hover;
        else buttons[i].currentState = ButtonState.Idle;    
    }
}

function ClickStart()
{
    buttons[selectIndex].currentState = ButtonState.Click;
}

function ClickEnd()
{
    if (buttons[selectIndex].currentState == ButtonState.Click) {
        buttons[selectIndex].OnClick();
    }
}