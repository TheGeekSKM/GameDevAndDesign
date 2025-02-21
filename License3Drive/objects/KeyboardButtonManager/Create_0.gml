buttons = [];
selectedIndex = 0;
oldIndex = 0;

checkForInput = false;

function AddToManager(_button) { array_push(buttons, _button); }

function IncrementIndex(num)
{
    selectedIndex = mod_wrap(selectedIndex + num, array_length(buttons));
    UpdateButtons();
}

function UpdateButtons()
{
    for (var i = 0; i < array_length(buttons); i++) 
    {
        if (i == selectedIndex) { buttons[i].OnHoverStart(); } 
        else { buttons[i].OnIdle(); }    
    }
}

alarm[0] = 2;
alarm[1] = 10;