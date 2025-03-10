currentInteractable = noone;
oldInteractable = currentInteractable;
interactableList = ds_list_create();
currentMouseState = InteractableType.Normal;

///@pure
function FindLowestDepthElement()
{
    var count = ds_list_size(interactableList);
    if (count == 0) return noone;
    
    var dep = 10000;
    var elem = noone;
    for (var i = 0; i < count; i++)
    {
        if (interactableList[| i].depth < dep)
        {
            dep = interactableList[| i].depth;
            elem = interactableList[| i];
        }
    }
    return elem;
}

function ResetCurrentInteractable() {
    currentInteractable.OnMouseExit();
    currentInteractable = noone;
    currentMouseState = InteractableType.Normal;
}
