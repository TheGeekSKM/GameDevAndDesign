// Inherit the parent event
event_inherited();
vis = false;

interactableName = "";
interactableDesc = "";
currentObject = noone;

Subscribe("DisplayInteractableInfo", function(_arr) {
    interactableName = _arr[0];
    interactableDesc = _arr[1];
    currentObject = _arr[2];
    vis = true;
});



