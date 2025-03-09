// check GUI elements first
ds_list_clear(interactableList);
var count = instance_position_list(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), obj_GUI_interactable, interactableList, false);
if (count != 0) { currentInteractable = FindLowestDepthElement(); }
    
// now check room elements
if (currentInteractable == noone) {
    
    ds_list_clear(interactableList);
    var count2 = instance_position_list(mouse_x, mouse_y, obj_ROOM_interactable, interactableList, false);
    if (count2 != 0) { currentInteractable = FindLowestDepthElement(); }
}

if (currentInteractable != oldInteractable and currentInteractable != noone)
{
    currentMouseState = currentInteractable.OnMouseEnter();
}

oldInteractable = currentInteractable;


if (mouse_check_button_pressed(mb_left) and currentInteractable != noone) 
{
    currentInteractable.OnMouseLeftClick();
}

if (mouse_check_button(mb_left) and currentInteractable != noone)
{
    currentInteractable.OnMouseLeftHeld();
}

if (mouse_check_button_released(mb_left) and currentInteractable != noone)
{
    currentInteractable.OnMouseLeftClickRelease();
}

if (mouse_check_button_pressed(mb_right) and currentInteractable != noone)
{
    currentInteractable.OnMouseRightClick();
}

if (mouse_check_button(mb_right) and currentInteractable != noone)
{
    currentInteractable.OnMouseRightHeld();
}

if (mouse_check_button_released(mb_right) and currentInteractable != noone)
{
    currentInteractable.OnMouseRightClickRelease();
}

if (currentInteractable != noone)
{
    if (!place_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), currentInteractable)) ResetCurrentInteractable();
    else if (!place_meeting(mouse_x, mouse_y, currentInteractable)) ResetCurrentInteractable();
}