// Inherit the parent event
event_inherited();

AddButtonClickCallback(function() {
    var bungus = new ChoiceData()
        .SetTitle("Province Info")
        .SetDescription(global.GameManager.GetStats().ToString()) 
    
    var panel = instance_create_layer(irandom_range(300, 500), -900, "Documents", obj_ChoicePanel);
    panel.choiceData = bungus;
    panel.disableChoices = true;
    panel.chosen = true;
    panel.choseAccept = true;
    array_push(global.DocumentSpawner.spawnedDocuments, panel);
});