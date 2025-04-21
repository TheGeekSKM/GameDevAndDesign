// Inherit the parent event
event_inherited();

function OnMouseLeftClickRelease()
{
    layer_set_visible("Page1", false);
    layer_set_visible("Page2", true);
    
    
    var jsonString = json_stringify(global.GameData, true);
    SafeWriteJson(working_directory + "GameData.json", jsonString)
    
    game_end();
    
}