if (keyboardButtonManger == noone)
{
    keyboardButtonManger = instance_place(x, y, obj_BASE_KBManager);
    if (instance_exists(keyboardButtonManger)) keyboardButtonManger.AddButtonToList(id);
}