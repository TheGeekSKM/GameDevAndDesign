spawnedDocuments = [];
turnHistory = [];
draggingDocument = noone;

global.DocumentSpawner = id;

Subscribe("NewTurn", function(_turn)
{
    var arrayOfChoices = _turn.Choices;
    for (var i = 0; i < array_length(arrayOfChoices); i += 1) {
        var panel = instance_create_layer(irandom_range(300, 500), -900, "Documents", obj_ChoicePanel);
        panel.choiceData = arrayOfChoices[i];
        array_push(spawnedDocuments, panel);
    }
});

Subscribe("DraggingDocument", function(_id) {
    if (instance_exists(draggingDocument))
    {
        draggingDocument.depth = -300;
    }
    
    draggingDocument = _id;
    draggingDocument.depth = -301;
})

Subscribe("EndTurn", function(_id) {
    for (var i = 0; i < array_length(spawnedDocuments); i++) {
        instance_destroy(spawnedDocuments[i]);
    }
    
    spawnedDocuments = [];
})

function AreAllChoicesMade()
{
    var result = true;
    for (var i = 0; i < array_length(spawnedDocuments); i++)
    {
        if (!spawnedDocuments[i].chosen)
        {
            result = false;
            break;
        }
    }
    
    return result;
}