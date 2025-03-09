if (!layer_exists(global.vars.sequencesLayerName)) layer_create(1, global.vars.sequencesLayerName);
    
interactableInfoLayer = layer_sequence_create(global.vars.sequencesLayerName, obj_camera.x - 50, obj_camera.y, seq_INGAME_InteractableInfo);
layer_sequence_pause(interactableInfoLayer);

currentlyHoveredObject = noone;

Subscribe("DisplayInteractableInfo", function(_arr) {
    currentlyHoveredObject = _arr[2];
    layer_sequence_headdir(interactableInfoLayer, seqdir_right);
    layer_sequence_play(interactableInfoLayer);    
})

Subscribe("MouseLeave", function(_id) {
    if (_id == currentlyHoveredObject)
    {
        layer_sequence_headdir(interactableInfoLayer, seqdir_left);
        layer_sequence_play(interactableInfoLayer);
        currentlyHoveredObject = noone;
    }
})
