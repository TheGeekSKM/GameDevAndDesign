enum MenuState
{
    NoMenu,
    Pause,
    Quest,
    Inventory,
    Dialogue,
    Attributes,
    Computer
}

layerName = "GUISequence";

if (!layer_exists(layerName)) layer_create(-9999, layerName);
    
player1State = MenuState.NoMenu;
player2State = MenuState.NoMenu;
drawBlackBackgroundLeft = false;
drawBlackBackgroundRight = false;

p1_keybind = layer_sequence_create(layerName, 0, 0, seq_BASE_interaction1);
p1_dialogue = layer_sequence_create(layerName, 0, 0, seq_LEFT_Dialogue);
p1_inventory = layer_sequence_create(layerName, 0, 0, seq_LEFT_Inventory);
p1_pause = layer_sequence_create(layerName, 0, 0, seq_LEFT_Pause);
p1_quest = layer_sequence_create(layerName, 0, 0, seq_LEFT_Quest);
p1_attributes = layer_sequence_create(layerName, 0, 0, seq_LEFT_Attributes);
p1_computer = layer_sequence_create(layerName, 0, 0, seq_LEFT_Computer);

p2_keybind = layer_sequence_create(layerName, 400, 0, seq_BASE_interaction2);
p2_dialogue = layer_sequence_create(layerName, 400, 0, seq_RIGHT_Dialogue);
p2_inventory = layer_sequence_create(layerName, 400, 0, seq_RIGHT_Inventory);
p2_pause = layer_sequence_create(layerName, 400, 0, seq_RIGHT_Pause);
p2_quest = layer_sequence_create(layerName, 400, 0, seq_RIGHT_Quest);
p2_attributes = layer_sequence_create(layerName, 400, 0, seq_RIGHT_Attributes);
p2_computer = layer_sequence_create(layerName, 400, 0, seq_RIGHT_Computer);

layer_sequence_pause(p1_dialogue);
layer_sequence_pause(p1_inventory);
layer_sequence_pause(p1_pause);
layer_sequence_pause(p1_quest);
layer_sequence_pause(p1_attributes);
layer_sequence_pause(p1_computer);

layer_sequence_pause(p2_dialogue);
layer_sequence_pause(p2_inventory);
layer_sequence_pause(p2_pause);
layer_sequence_pause(p2_quest);
layer_sequence_pause(p2_attributes);
layer_sequence_pause(p2_computer);

Subscribe("PauseOpen", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.Pause);
    else ShowMenuStateRight(MenuState.Pause);
});
Subscribe("DialogueOpen", function(_dialogueData) {
    if (_dialogueData.playerID.playerIndex == 0) 
    {
        with (obj_dialogueText_1) { SetText(_dialogueData); }
        with (obj_dialogueSpeaker_1) { SetSpeaker(_dialogueData); }
        ShowMenuStateLeft(MenuState.Dialogue);
    }
    else 
    {
        with (obj_dialogueText_2) { SetText(_dialogueData); }
        with (obj_dialogueSpeaker_2) { SetSpeaker(_dialogueData); }
        ShowMenuStateRight(MenuState.Dialogue);
    }
});
Subscribe("InventoryOpen", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.Inventory);
    else ShowMenuStateRight(MenuState.Inventory);
});
Subscribe("QuestOpen", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.Quest);
    else ShowMenuStateRight(MenuState.Quest);
});
Subscribe("AttributeOpen", function (_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.Attributes);
    else ShowMenuStateRight(MenuState.Attributes);    
})
Subscribe("ComputerOpen", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.Computer);
    else ShowMenuStateRight(MenuState.Computer);          
})

Subscribe("PauseClose", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.NoMenu);
    else ShowMenuStateRight(MenuState.NoMenu);
});
Subscribe("DialogueClose", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.NoMenu);
    else ShowMenuStateRight(MenuState.NoMenu);
});
Subscribe("InventoryClose", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.NoMenu);
    else ShowMenuStateRight(MenuState.NoMenu);
});
Subscribe("QuestClose", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.NoMenu);
    else ShowMenuStateRight(MenuState.NoMenu);
});
Subscribe("AttributeClose", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.NoMenu);
    else ShowMenuStateRight(MenuState.NoMenu);    
})
Subscribe("ComputerClose", function(_id) {
    if (_id.playerIndex == 0) ShowMenuStateLeft(MenuState.NoMenu);
    else ShowMenuStateRight(MenuState.NoMenu);          
})

function LeftOnExit()
{
    switch (player1State)
    {
        case MenuState.NoMenu:
            layer_sequence_headdir(p1_keybind, seqdir_left);
            layer_sequence_play(p1_keybind);
            break;
        case MenuState.Dialogue:
            layer_sequence_headdir(p1_dialogue, seqdir_left);
            layer_sequence_play(p1_dialogue);
            with (obj_dialogueSpeaker_1) { vis = false; }    
            with (obj_dialogueText_1) { vis = false; }        
            break;
        case MenuState.Inventory:
            layer_sequence_headdir(p1_inventory, seqdir_left);
            layer_sequence_play(p1_inventory);
            with (obj_inventory_1) { vis = false; }          
            break;
        case MenuState.Pause:
            layer_sequence_headdir(p1_pause, seqdir_left);
            layer_sequence_play(p1_pause);
            with (obj_pauseMenu_1) { vis = false; }         
            break;
        case MenuState.Quest:
            layer_sequence_headdir(p1_quest, seqdir_left);
            layer_sequence_play(p1_quest);
            with (obj_questList_1) { vis = false; }
            with (obj_questDesc_1) { vis = false; }           
            break;
        case MenuState.Attributes:
            layer_sequence_headdir(p1_attributes, seqdir_left);
            layer_sequence_play(p1_attributes);
            with (obj_attributes_1) { vis = false; }
            break;
        case MenuState.Computer:
            layer_sequence_headdir(p1_computer, seqdir_left);
            layer_sequence_play(p1_computer);
            with (obj_computerScreen_1) { vis = false; }
            break;        
    }
}
function LeftOnEnter()
{
    switch (player1State)
    {
        case MenuState.NoMenu:
            layer_sequence_headdir(p1_keybind, seqdir_right);
            layer_sequence_play(p1_keybind);
            drawBlackBackgroundLeft = false;
            alarm[0] = 30;
            break;
        case MenuState.Dialogue:
            layer_sequence_headdir(p1_dialogue, seqdir_right);
            layer_sequence_play(p1_dialogue);
            drawBlackBackgroundLeft = true;
            obj_Player1.inputPause = true;    
            with (obj_dialogueSpeaker_1) { vis = true; }
            with (obj_dialogueText_1) { vis = true; }
            break;
        case MenuState.Inventory:
            layer_sequence_headdir(p1_inventory, seqdir_right);
            layer_sequence_play(p1_inventory);
            drawBlackBackgroundLeft = true;
            obj_Player1.inputPause = true;  
            with (obj_inventory_1) { vis = true; }                  
            break;
        case MenuState.Pause:
            layer_sequence_headdir(p1_pause, seqdir_right);
            layer_sequence_play(p1_pause);
            drawBlackBackgroundLeft = true;
            obj_Player1.inputPause = true; 
            with (obj_pauseMenu_1) { vis = true; }               
            break;
        case MenuState.Quest:
            layer_sequence_headdir(p1_quest, seqdir_right);
            layer_sequence_play(p1_quest);
            drawBlackBackgroundLeft = true;
            obj_Player1.inputPause = true;  
            with (obj_questList_1) { vis = true; }
            with (obj_questDesc_1) { vis = true; }              
            break;
        case MenuState.Attributes:
            layer_sequence_headdir(p1_attributes, seqdir_right);
            layer_sequence_play(p1_attributes);
            obj_Player1.inputPause = true;
            with (obj_attributes_1) { vis = true; }         
            break;
        case MenuState.Computer:
            layer_sequence_headdir(p1_computer, seqdir_right);
            layer_sequence_play(p1_computer);
            obj_Player1.inputPause = true;
            with (obj_computerScreen_1) { vis = true; }         
            break;        
    }
}

function RightOnExit()
{
    switch (player2State)
    {
        case MenuState.NoMenu:
            layer_sequence_headdir(p2_keybind, seqdir_left);
            layer_sequence_play(p2_keybind);
            break;
        case MenuState.Dialogue:
            layer_sequence_headdir(p2_dialogue, seqdir_left);
            layer_sequence_play(p2_dialogue);
            with (obj_dialogueSpeaker_2) { vis = false; }    
            with (obj_dialogueText_2) { vis = false; }          
            break;
        case MenuState.Inventory:
            layer_sequence_headdir(p2_inventory, seqdir_left);
            layer_sequence_play(p2_inventory);
            with (obj_inventory_2) { vis = false; }           
            break;
        case MenuState.Pause:
            layer_sequence_headdir(p2_pause, seqdir_left);
            layer_sequence_play(p2_pause);
            with (obj_pauseMenu_2) { vis = false; }          
            break;
        case MenuState.Quest:
            layer_sequence_headdir(p2_quest, seqdir_left);
            layer_sequence_play(p2_quest);
            with (obj_questList_2) { vis = false; }
            with (obj_questDesc_2) { vis = false; }         
            break;
        case MenuState.Attributes:
            layer_sequence_headdir(p2_attributes, seqdir_left);
            layer_sequence_play(p2_attributes);
            with (obj_attributes_2) { vis = false; }
            break;
        case MenuState.Computer:
            layer_sequence_headdir(p2_computer, seqdir_left);
            layer_sequence_play(p2_computer);
            with (obj_computerScreen_2) { vis = false; }
            break;                 
    }
}
function RightOnEnter()
{
    switch (player2State)
    {
        case MenuState.NoMenu:
            layer_sequence_headdir(p2_keybind, seqdir_right);
            layer_sequence_play(p2_keybind);
            drawBlackBackgroundLeft = false;
            alarm[1] = 30;
            break;
        case MenuState.Dialogue:
            layer_sequence_headdir(p2_dialogue, seqdir_right);
            layer_sequence_play(p2_dialogue);
            drawBlackBackgroundLeft = true;
            obj_Player2.inputPause = true;
            with (obj_dialogueSpeaker_2) { vis = true; }
            with (obj_dialogueText_2) { vis = true; }                   
            break;
        case MenuState.Inventory:
            layer_sequence_headdir(p2_inventory, seqdir_right);
            layer_sequence_play(p2_inventory);
            drawBlackBackgroundLeft = true;
            obj_Player2.inputPause = true;
            with (obj_inventory_2) { vis = true; }                 
            break;
        case MenuState.Pause:
            layer_sequence_headdir(p2_pause, seqdir_right);
            layer_sequence_play(p2_pause);
            drawBlackBackgroundLeft = true;
            obj_Player2.inputPause = true;
            with (obj_pauseMenu_2) { vis = true; }                 
            break;
        case MenuState.Quest:
            layer_sequence_headdir(p2_quest, seqdir_right);
            layer_sequence_play(p2_quest);
            drawBlackBackgroundLeft = true;
            obj_Player2.inputPause = true;
            with (obj_questList_2) { vis = true; }
            with (obj_questDesc_2) { vis = true; }                
            break;
        case MenuState.Attributes:
            layer_sequence_headdir(p2_attributes, seqdir_right);
            layer_sequence_play(p2_attributes);
            obj_Player2.inputPause = true;
            with (obj_attributes_2) { vis = true; }         
            break;
        case MenuState.Computer:
            layer_sequence_headdir(p2_computer, seqdir_right);
            layer_sequence_play(p2_computer);
            obj_Player2.inputPause = true;
            with (obj_computerScreen_2) { vis = true; }         
            break;
    }
}

function ShowMenuStateLeft(_state) 
{
    LeftOnExit();
    player1State = _state;
    LeftOnEnter();
}
function ShowMenuStateRight(_state) 
{
    RightOnExit();
    player2State = _state;
    RightOnEnter();
}