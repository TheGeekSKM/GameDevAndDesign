if (keyboard_check_pressed(vk_escape))
{
    StopInterpreter();
    Raise("EscPressed", id);
}