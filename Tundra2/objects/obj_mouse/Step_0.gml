

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

if (currentInteractable != oldInteractable)
{
    currentInteractable.OnMouseEnter();

}

if (currentInteractable != noone)
{
    if (!place_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), currentInteractable)) ResetCurrentInteractable();
    else if (!place_meeting(mouse_x, mouse_y, currentInteractable)) ResetCurrentInteractable();
}

oldInteractable = currentInteractable;
echo(currentInteractable != noone ? "Hovering Over Object" : "Not Hovering Over Object")