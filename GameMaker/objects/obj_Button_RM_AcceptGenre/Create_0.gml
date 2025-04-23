// Inherit the parent event
enabled = false;
event_inherited();

function OnMouseLeftClickRelease()
{
    layer_set_visible("Page1", false);
    layer_set_visible("Page2", true);
    
    
    var jsonString = json_stringify(global.GameData, true);
    SafeWriteJson(working_directory + "GameData.json", jsonString)
    
    game_end();
    
}

Subscribe("Page2", function() {
    enabled = true;    
})

Subscribe("Page1", function() {
    enabled = false;    
})