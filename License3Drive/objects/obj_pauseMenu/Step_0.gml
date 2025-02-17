if (!vis) return;

var movement = input_check_pressed("down") - input_check_pressed("up");
selectedIndex = mod_wrap(selectedIndex + movement, array_length(buttons));

if (input_check_pressed("accept"))
{
    DoAction();
}