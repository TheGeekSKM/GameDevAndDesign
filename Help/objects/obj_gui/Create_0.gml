enum MenuState
{
    NoMenu,
    Pause,
    Quest,
    Inventory,
    Dialogue
}

layerName = "GUISequence";

if (!layer_exists(layerName)) layer_create(-9999, layerName);
    
player1State = MenuState.NoMenu;
player2State = MenuState.NoMenu;

p1_keybind = layer_sequence_create(layerName, 0, 0, seq_BASE_interaction1);
p2_keybind = layer_sequence_create(layerName, 400, 0, seq_BASE_interaction2);