enum MenuState
{
    NoMenu,
    QuestMenu,
    DialogueMenu,
    InventoryMenu,
    PauseMenu
}

layerName = "GUISequences"

if (!layer_exists(layerName))
{
    layer_create(-9999, layerName);
}

#macro camX camera_get_view_x(camera_get_active())
#macro camY camera_get_view_y(camera_get_active())

dialogueMenuSequence = layer_sequence_create(layerName, camX, camY, seqDialogueMenu);
inventoryMenuSequence = layer_sequence_create(layerName, camX, camY, seqInventoryMenu);
questMenuSequence = layer_sequence_create(layerName, camX, camY, seqQuestMenu);
pauseMenuSequence = layer_sequence_create(layerName, camX, camY, seqPauseMenu);

layer_sequence_pause(dialogueMenuSequence);
layer_sequence_pause(inventoryMenuSequence);
layer_sequence_pause(questMenuSequence);
layer_sequence_pause(pauseMenuSequence);

currentState = MenuState.NoMenu;
drawBlackBackground = false;

Subscribe("L Pressed", function(_id) {
    if (currentState == MenuState.QuestMenu) ShowUI(MenuState.NoMenu);
    else ShowUI(MenuState.QuestMenu);       
});

Subscribe("I Pressed", function(_id) {
    if (currentState == MenuState.InventoryMenu) ShowUI(MenuState.NoMenu);
    else ShowUI(MenuState.InventoryMenu);    
});

Subscribe("Space Pressed", function(_id) {
    if (currentState == MenuState.DialogueMenu) ShowUI(MenuState.NoMenu);    
})

Subscribe("Esc Pressed", function(_id) {

    _pressedEscape();   
});

_pressedEscape = function()
{
    switch (currentState)
    {
        case MenuState.NoMenu:
            ShowUI(MenuState.PauseMenu);
            break;
        case MenuState.QuestMenu:
            ShowUI(MenuState.NoMenu);
            break;
        case MenuState.DialogueMenu:
            ShowUI(MenuState.NoMenu);
            break;
        case MenuState.InventoryMenu:
            ShowUI(MenuState.NoMenu);
            break;
        case MenuState.PauseMenu:
            ShowUI(MenuState.NoMenu);
            break;
    }
}

_onExit = function()
{
    
    switch (currentState)
    {
        case MenuState.NoMenu:
            break;
        case MenuState.QuestMenu:
            with (obj_questList) { vis = false; }
            layer_sequence_headdir(questMenuSequence, seqdir_left);
            layer_sequence_play(questMenuSequence);
            break;        
        case MenuState.DialogueMenu:
            layer_sequence_headdir(dialogueMenuSequence, seqdir_left);
            layer_sequence_play(dialogueMenuSequence);      
            break;     
        case MenuState.InventoryMenu:
            layer_sequence_headdir(inventoryMenuSequence, seqdir_left);
            layer_sequence_play(inventoryMenuSequence);    
            break;           
        case MenuState.PauseMenu:
            layer_sequence_headdir(pauseMenuSequence, seqdir_left);
            layer_sequence_play(pauseMenuSequence);       
            break;        
    }
}

_onEnter = function()
{
    switch (currentState)
    {
        case MenuState.NoMenu:
            global.pause = false;            
            drawBlackBackground = false;            
            break;
        case MenuState.QuestMenu:
            global.pause = true;
            with (obj_questList) 
            { 
                DrawQuests();
            }        
            drawBlackBackground = true;            
            layer_sequence_headdir(questMenuSequence, seqdir_right);
            layer_sequence_play(questMenuSequence);
            break;        
        case MenuState.DialogueMenu:
            global.pause = true;            
            drawBlackBackground = true;            
            layer_sequence_headdir(dialogueMenuSequence, seqdir_right);
            layer_sequence_play(dialogueMenuSequence);            
            break;     
        case MenuState.InventoryMenu:
            global.pause = true;            
            drawBlackBackground = true;            
            layer_sequence_headdir(inventoryMenuSequence, seqdir_right);
            layer_sequence_play(inventoryMenuSequence);            
            break;           
        case MenuState.PauseMenu:
            global.pause = true;            
            drawBlackBackground = true; 
            with (obj_PauseMenu) 
            {
                vis = true;
                selectedIndex = 0;    
            }                 
            layer_sequence_headdir(pauseMenuSequence, seqdir_right);
            layer_sequence_play(pauseMenuSequence);            
            break;        
    }    
}


ShowUI = function(_newState)
{
    //currentState OnExit
    _onExit();
    
    //currentState = _newState
    currentState = _newState;
    
    //currentState OnEnter
    _onEnter();
}



