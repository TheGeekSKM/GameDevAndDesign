if (currentlyHoveredObject == noone) return;
var pos = RoomToGUICoords(currentlyHoveredObject.x, currentlyHoveredObject.y);

layer_sequence_x(interactableInfoLayer, pos.x + 10);
layer_sequence_y(interactableInfoLayer, pos.y + 10);