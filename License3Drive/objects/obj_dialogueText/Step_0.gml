if (!vis) return;
if (input_check_pressed("accept"))
{
    with (obj_UIManager)
    {
        ShowUI(MenuState.NoMenu);
    }
}