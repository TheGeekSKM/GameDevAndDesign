// check GUI elements first
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
    if (currentInteractable.IntType == IntVisType.GUI and !place_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), currentInteractable)) ResetCurrentInteractable();
    else if (currentInteractable.IntType == IntVisType.Room and !place_meeting(mouse_x, mouse_y, currentInteractable)) ResetCurrentInteractable();
}

//var str = "";
//for (var i = 0; i < ds_list_size(interactableList); i++) {
    //str = string_concat(str, interactableList[| i], ", ")
//}
//echo($"List of Interactables: {str} and CurrentInteractable: {currentInteractable}");