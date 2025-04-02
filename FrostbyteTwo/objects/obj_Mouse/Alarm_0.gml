ds_list_clear(interactableList);
var count = instance_position_list(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), obj_GUI_interactable, interactableList, false);
if (count != 0) { 
    currentInteractable = FindLowestDepthElement();
}
    
ds_list_clear(interactableList);
// now check room elements
if (currentInteractable == noone) {
    
    instance_position_list(mouse_x, mouse_y, obj_ROOM_interactable, interactableList, false);
    var inst = FindLowestDepthElement();
    if (inst != noone) {
        currentInteractable = inst;
    }
}

alarm[0] = irandom_range(1, 2);