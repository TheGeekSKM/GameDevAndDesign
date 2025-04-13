// Inherit the parent event
event_inherited();

AddMouseEnterCallback(function() {
    image_index = 1;    
})

AddMouseExitCallback(function() {
    image_index = 0;    
})

function OnMouseLeftClick()
{
    if (global.DocumentSpawner.AreAllChoicesMade())
    {
        for (var i = 0; i < array_length(global.DocumentSpawner.spawnedDocuments); i++)
        {
            var ref = global.DocumentSpawner.spawnedDocuments[i];
            if (ref.choseAccept)
            {
                ref.choiceData.Accept();
            }
            else if (ref.choseReject)
            {
                ref.choiceData.Reject();
            }
            else 
            {
                show_message($"For {choiceData.Title}, No Choices were chosen, yet AllChoicesAreMade returned true...")
                return;
            }
        }
    }
    
    global.GameManager.FinishedPlayerTurn();
}