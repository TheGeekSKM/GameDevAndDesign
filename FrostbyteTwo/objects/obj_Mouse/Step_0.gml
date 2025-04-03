x = device_mouse_x_to_gui(0);
y = device_mouse_y_to_gui(0);



if (currentInteractable != oldInteractable and instance_exists(currentInteractable))
{
    currentInteractable.OnMouseEnter();
    currentMouseState = currentInteractable.Type;
}

oldInteractable = currentInteractable;


if (mouse_check_button_pressed(mb_left) and instance_exists(currentInteractable)) 
{
    currentInteractable.OnMouseLeftClick();
}

if (mouse_check_button(mb_left) and instance_exists(currentInteractable))
{
    currentInteractable.OnMouseLeftHeld();
}

if (mouse_check_button_released(mb_left))
{
     if (instance_exists(currentInteractable)) currentInteractable.OnMouseLeftClickRelease();
}

if (mouse_check_button_pressed(mb_right) and instance_exists(currentInteractable))
{
    currentInteractable.OnMouseRightClick();
}

if (mouse_check_button(mb_right) and instance_exists(currentInteractable))
{
    currentInteractable.OnMouseRightHeld();
}

if (mouse_check_button_released(mb_right))
{
    if (instance_exists(currentInteractable)) currentInteractable.OnMouseRightClickRelease();
}

if (instance_exists(currentInteractable))
{
    if (currentInteractable.IntType == IntVisType.GUI and !place_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), currentInteractable)) ResetCurrentInteractable();
    else if (currentInteractable.IntType == IntVisType.Room and !place_meeting(mouse_x, mouse_y, currentInteractable)) ResetCurrentInteractable();
}

//var str = "";
//for (var i = 0; i < ds_list_size(interactableList); i++) {
    //str = string_concat(str, interactableList[| i], ", ")
//}
//echo($"List of Interactables: {str} and CurrentInteractable: {currentInteractable}");

if (!instance_exists(currentInteractable)) currentMouseState = InteractableType.Normal;

image_index = currentMouseState;