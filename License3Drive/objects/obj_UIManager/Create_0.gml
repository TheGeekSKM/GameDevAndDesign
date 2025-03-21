enum MenuState {
    NoMenu,
    Pause,
    Quest,
    Inventory,
    Dialogue
}

layerName = "GUISequence";

currentDialogue = undefined;
pauseMenuSequence = undefined;
questMenuSequence = undefined;
inventoryMenuSequence = undefined;
dialogueMenuSequence = undefined;
crashDetectorSequence = undefined;
compassSequence = undefined;

if (!layer_exists(layerName)) layer_create(-9999, layerName);
    
pauseMenuSequence = layer_sequence_create(layerName, 0, 0, seq_PauseMenu);
questMenuSequence = layer_sequence_create(layerName, 0, 0, seq_Quest);
inventoryMenuSequence = layer_sequence_create(layerName, 0, 0, seq_Inventory);
dialogueMenuSequence = layer_sequence_create(layerName, 0, 0, seq_Dialogue);
crashDetectorSequence = layer_sequence_create(layerName, 0, 0, seq_CrashDetector);
compassSequence = layer_sequence_create(layerName, 0, 0, seq_Compass);
notificationSequence = layer_sequence_create(layerName, 0, 0, seq_InGame_NotificationIn);

layer_sequence_pause(pauseMenuSequence);
layer_sequence_pause(inventoryMenuSequence);
layer_sequence_pause(questMenuSequence);
layer_sequence_pause(dialogueMenuSequence);
layer_sequence_pause(crashDetectorSequence);
layer_sequence_pause(compassSequence);
layer_sequence_pause(notificationSequence);

layer_sequence_headdir(pauseMenuSequence, seqdir_right);
layer_sequence_headpos(pauseMenuSequence, 0);

layer_sequence_headdir(inventoryMenuSequence, seqdir_right);
layer_sequence_headpos(inventoryMenuSequence, 0);

layer_sequence_headdir(questMenuSequence, seqdir_right);
layer_sequence_headpos(questMenuSequence, 0);

layer_sequence_headdir(dialogueMenuSequence, seqdir_right);
layer_sequence_headpos(dialogueMenuSequence, 0);

layer_sequence_headdir(crashDetectorSequence, seqdir_right);
layer_sequence_headpos(crashDetectorSequence, 0);

layer_sequence_headdir(compassSequence, seqdir_right);
layer_sequence_headpos(compassSequence, 0);

layer_sequence_headdir(notificationSequence, seqdir_right);
layer_sequence_headpos(notificationSequence, 0);


currentState = MenuState.NoMenu;
drawBlackBackground = false;

Subscribe("Resume", function(id) {
    ShowUI(MenuState.NoMenu);    
})
Subscribe("MainMenu", function(id) {
    global.pause = false;
    game_restart();
});
Subscribe("Pause", function(id) {
    ShowUI(MenuState.Pause);
});
Subscribe("Quest", function(id) {
    ShowUI(MenuState.Quest);
});
Subscribe("Inventory", function(id) {
    ShowUI(MenuState.Inventory);
});
Subscribe("Dialogue", function(_dialogue) {
    currentDialogue = _dialogue;
    ShowUI(MenuState.Dialogue);
});
Subscribe("Exit", function(id) {
    game_end();
});
Subscribe("K Pressed", function() {
    if (currentState != MenuState.NoMenu) PressedEscape();
})
Subscribe("Menu", function(id) {
    ShowUI(MenuState.Pause);
});

Subscribe("NotificationIn", function(_string) {
    layer_sequence_headdir(notificationSequence, seqdir_right);
    layer_sequence_play(notificationSequence);   
})

Subscribe("NotificationOut", function(_id) {
    layer_sequence_headdir(notificationSequence, seqdir_left);
    layer_sequence_play(notificationSequence);        
})

Subscribe("ItemEquipped", function(_itemName){
    switch(_itemName)
    {
        case "Crash Detector":
            layer_sequence_headdir(compassSequence, seqdir_left);
            layer_sequence_play(compassSequence);                
        
            layer_sequence_headdir(crashDetectorSequence, seqdir_right);
            layer_sequence_play(crashDetectorSequence);
            with (obj_crashDetector) { vis = true; }
            with (obj_compass) { vis = false; }
            break;
        case "Compass":
            layer_sequence_headdir(compassSequence, seqdir_right);
            layer_sequence_play(compassSequence);                
        
            layer_sequence_headdir(crashDetectorSequence, seqdir_left);
            layer_sequence_play(crashDetectorSequence);
            with (obj_crashDetector) { vis = false; }   
            with (obj_compass) { vis = true; }                  
            break;
    }    
})

function PressedEscape()
{
    switch (currentState)
    {
        case MenuState.NoMenu:
            ShowUI(MenuState.Pause);
            break;
        case MenuState.Pause:
            ShowUI(MenuState.NoMenu);
            break;        
        case MenuState.Quest:
            ShowUI(MenuState.NoMenu);       
            break;        
        case MenuState.Inventory:
            ShowUI(MenuState.NoMenu);          
            break;        
        case MenuState.Dialogue:
            ShowUI(MenuState.NoMenu);         
            break;             
    }   
}

function OnEnter()
{
    switch (currentState)
    {
        case MenuState.NoMenu:
            global.pause = false;
            drawBlackBackground = false;
            break;
        case MenuState.Pause:
            global.pause = true;
            drawBlackBackground = true;        
            with (obj_pauseMenu) 
            {
                // menu enter
                vis = true;
            }
            layer_sequence_headdir(pauseMenuSequence, seqdir_right);
            layer_sequence_play(pauseMenuSequence);
            break;        
        case MenuState.Quest:
            global.pause = true;
            drawBlackBackground = true;        
            with (obj_questList) 
            {
                // menu enter
                vis = true;
            }
            layer_sequence_headdir(questMenuSequence, seqdir_right);
            layer_sequence_play(questMenuSequence);          
            break;        
        case MenuState.Inventory:
            global.pause = true;
            drawBlackBackground = true;        
            with (obj_inventory) 
            {
                // menu enter
                vis = true;
            }
            layer_sequence_headdir(inventoryMenuSequence, seqdir_right);
            layer_sequence_play(inventoryMenuSequence);          
            break;        
        case MenuState.Dialogue:
            drawBlackBackground = true;        
            with (obj_dialogueSpeaker) 
            {
                // menu enter
                vis = true;
                speakerColor = other.currentDialogue.color;
            }
            with (obj_dialogueText)
            {
                vis = true;
                speakerText = other.currentDialogue.text;
            }
            layer_sequence_headdir(dialogueMenuSequence, seqdir_right);
            layer_sequence_play(dialogueMenuSequence);          
            break;        
    }    
}

function OnExit()
{
    switch (currentState)
    {
        case MenuState.NoMenu:
            break;
        case MenuState.Pause:
            with (obj_pauseMenu) {vis = false;}
            layer_sequence_headdir(pauseMenuSequence, seqdir_left);
            layer_sequence_play(pauseMenuSequence);
            break;        
        case MenuState.Quest:
            with (obj_questList) {vis = false;}
            layer_sequence_headdir(questMenuSequence, seqdir_left);
            layer_sequence_play(questMenuSequence);           
            break;        
        case MenuState.Inventory:
            with (obj_inventory) {vis = false;}
            layer_sequence_headdir(inventoryMenuSequence, seqdir_left);
            layer_sequence_play(inventoryMenuSequence);           
            break;        
        case MenuState.Dialogue:
            with (obj_dialogueSpeaker) {vis = false;}
            with (obj_dialogueText) {vis = false;}
            layer_sequence_headdir(dialogueMenuSequence, seqdir_left);
            layer_sequence_play(dialogueMenuSequence);            
            break;        
    }
}

ShowUI = function(_newState)
{
    //currentState OnExit
    OnExit();
    
    //currentState = _newState
    currentState = _newState;
    
    //currentState OnEnter
    OnEnter();
}

with (obj_pauseMenu) {vis = false;}
with (obj_questList) {vis = false;}
with (obj_inventory) {vis = false;}
with (obj_dialogueSpeaker) {vis = false;}
with (obj_dialogueText) {vis = false;}