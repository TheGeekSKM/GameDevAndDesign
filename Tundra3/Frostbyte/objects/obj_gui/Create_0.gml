p1State = UIMenuState.noUI;
p2State = UIMenuState.noUI;


Subscribe("NotificationOpen", function(_data) {
    if (_data[1] == 0) 
    {
        with(obj_Notification_0) {SetData(_data);}
        layer_sequence_headdir(p1_notification, seqdir_right);
        layer_sequence_play(p1_notification);
    }
    else if (_data[1] == 1) 
    {
        with(obj_Notification_1) {SetData(_data);}
        layer_sequence_headdir(p2_notification, seqdir_right);
        layer_sequence_play(p2_notification);
    }
});

Subscribe("NotificationClose", function(_id) {
    if (_id == 0) 
    {
        layer_sequence_headdir(p1_notification, seqdir_left);
        layer_sequence_play(p1_notification);
    }
    else if (_id == 1) 
    {
        layer_sequence_headdir(p2_notification, seqdir_left);
        layer_sequence_play(p2_notification);
    }
});


Subscribe("PauseOpen", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.pause);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.pause);
});

Subscribe("DialogueOpen", function(_data) {
    if (_data[0] == 0) 
    {
        ShowMenuStateLeft(UIMenuState.dialogue);
        with(obj_Menu_DialogueText_0) {StartDialogue(_data[1]);}
    }
    else if (_data[0] == 1) 
    {
        ShowMenuStateRight(UIMenuState.dialogue);
        with(obj_Menu_DialogueText_1) {StartDialogue(_data[1]);}
    }
});

Subscribe("InventoryOpen", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.inventory);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.inventory);
});

Subscribe("CraftingOpen", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.crafting);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.crafting);
});

Subscribe("PCViewOpen", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.pcView);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.pcView);
});

Subscribe("QuestOpen", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.quest);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.quest);
});

Subscribe("StatsOpen", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.stats);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.stats);
});

Subscribe("Resume", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("PauseClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("DialogueClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("InventoryClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("CraftingClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("PCViewClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("QuestClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("StatsClose", function(_id) {
    if (_id == 0) ShowMenuStateLeft(UIMenuState.noUI);
    else if (_id == 1) ShowMenuStateRight(UIMenuState.noUI);
});

Subscribe("DayDisplayOpen", function(_id) {
    layer_sequence_headdir(daySequence, seqdir_right);
    layer_sequence_play(daySequence);    
});

Subscribe("DayDisplayClose", function(_id) {
    layer_sequence_headdir(daySequence, seqdir_left);
    layer_sequence_play(daySequence);    
});


layerName = "GUI";
if (!layer_exists(layerName)) {
    layer_create(-999, layerName);
}

layerNotificationName = "Notification";
if (!layer_exists(layerNotificationName)) {
    layer_create(-9999, layerNotificationName);
}

daySequence = layer_sequence_create(layerNotificationName, 0, 0, SEQ_DayNotice);
layer_sequence_pause(daySequence);

p1_game = layer_sequence_create(layerName, 0, 0, SEQ_Game_0);
p1_notification = layer_sequence_create(layerNotificationName, 0, 0, SEQ_Notification_0);
layer_sequence_pause(p1_notification);
p1_crafting = layer_sequence_create(layerName, 0, 0, SEQ_Crafting_0);
layer_sequence_pause(p1_crafting);
p1_dialogue = layer_sequence_create(layerName, 0, 0, SEQ_Dialogue_0);
layer_sequence_pause(p1_dialogue);
p1_inventory = layer_sequence_create(layerName, 0, 0, SEQ_Inventory_0);
layer_sequence_pause(p1_inventory);
p1_pause = layer_sequence_create(layerName, 0, 0, SEQ_BASE_Pause_0);
layer_sequence_pause(p1_pause);
p1_pcView = layer_sequence_create(layerName, 0, 0, SEQ_PCView_0);
layer_sequence_pause(p1_pcView);
p1_quest = layer_sequence_create(layerName, 0, 0, SEQ_Quest_0);
layer_sequence_pause(p1_quest);
p1_playerStats = layer_sequence_create(layerName, 0, 0, SEQ_Stats_0);
layer_sequence_pause(p1_playerStats);

p2_game = layer_sequence_create(layerName, 400, 0, SEQ_Game_1);
p2_notification = layer_sequence_create(layerNotificationName, 400, 0, SEQ_Notification_1);
layer_sequence_pause(p2_notification);
p2_crafting = layer_sequence_create(layerName, 400, 0, SEQ_Crafting_1)
layer_sequence_pause(p2_crafting);
p2_dialogue = layer_sequence_create(layerName, 400, 0, SEQ_Dialogue_1);
layer_sequence_pause(p2_dialogue);
p2_inventory = layer_sequence_create(layerName, 400, 0, SEQ_Inventory_1);
layer_sequence_pause(p2_inventory);
p2_pause = layer_sequence_create(layerName, 400, 0, SEQ_BASE_Pause_1);
layer_sequence_pause(p2_pause);
p2_pcView = layer_sequence_create(layerName, 400, 0, SEQ_PCView_1);
layer_sequence_pause(p2_pcView);
p2_quest = layer_sequence_create(layerName, 400, 0, SEQ_Quest_1);
layer_sequence_pause(p2_quest);
p2_playerStats = layer_sequence_create(layerName, 400, 0, SEQ_Stats_1);
layer_sequence_pause(p2_playerStats);

function ShowMenuStateLeft(_state) {
    LeftOnExit();
    p1State = _state;
    LeftOnEnter();
}

function ShowMenuStateRight(_state) {
    RightOnExit();
    p2State = _state;
    RightOnEnter();
}

function LeftOnExit()
{
    switch (p1State)
    {
        case UIMenuState.noUI:
            obj_Player1.Pause(true);
            layer_sequence_headdir(p1_game, seqdir_left);
            layer_sequence_play(p1_game);
            break;
        case UIMenuState.crafting:
            layer_sequence_headdir(p1_crafting, seqdir_left);
            layer_sequence_play(p1_crafting);
            with(obj_Menu_Crafting_0) {vis = false;}
            break;
        case UIMenuState.dialogue:
            layer_sequence_headdir(p1_dialogue, seqdir_left);
            layer_sequence_play(p1_dialogue);
            with (obj_Menu_DialogueText_0) {vis = false;}
            with (obj_Menu_DialogueSpeaker_0) {vis = false;}
            break;
        case UIMenuState.inventory:
            layer_sequence_headdir(p1_inventory, seqdir_left);
            layer_sequence_play(p1_inventory);
            with(obj_InventoryList_0) {vis = false;}
            with(obj_InventoryEquipped_0) {vis = false;}
            break;
        case UIMenuState.pause:
            layer_sequence_headdir(p1_pause, seqdir_left);
            layer_sequence_play(p1_pause);
            with(obj_KBManager_Pause_0) {vis = false;}
            break;
        case UIMenuState.pcView:
            layer_sequence_headdir(p1_pcView, seqdir_left);
            layer_sequence_play(p1_pcView);
            with(obj_PCView) {vis = false;}
            break;
        case UIMenuState.quest:
            layer_sequence_headdir(p1_quest, seqdir_left);
            layer_sequence_play(p1_quest);
            with(obj_Menu_QuestList_0) {vis = false;}
            with(obj_Menu_QuestInfo_0) {vis = false;}
            break;
        case UIMenuState.stats:
            layer_sequence_headdir(p1_playerStats, seqdir_left);
            layer_sequence_play(p1_playerStats);
            with(obj_Menu_PlayerStats_0) {vis = false;}
            break;    
    }
}

function LeftOnEnter()
{
    switch (p1State)
    {
        case UIMenuState.noUI:
            alarm[0] = 10;
            layer_sequence_headdir(p1_game, seqdir_right);
            layer_sequence_play(p1_game);
            break;
        case UIMenuState.crafting:
            layer_sequence_headdir(p1_crafting, seqdir_right);
            layer_sequence_play(p1_crafting);
            with(obj_Menu_Crafting_0) {vis = true;}
            break;
        case UIMenuState.dialogue:
            layer_sequence_headdir(p1_dialogue, seqdir_right);
            layer_sequence_play(p1_dialogue);
            with (obj_Menu_DialogueText_0) {vis = true;}
            with (obj_Menu_DialogueSpeaker_0) {vis = true;}
            break;
        case UIMenuState.inventory:
            layer_sequence_headdir(p1_inventory, seqdir_right);
            layer_sequence_play(p1_inventory);
            with(obj_InventoryList_0) {vis = true;}
            with(obj_InventoryEquipped_0) {vis = true;}
            break;
        case UIMenuState.pause:
            layer_sequence_headdir(p1_pause, seqdir_right);
            layer_sequence_play(p1_pause);
            with(obj_KBManager_Pause_0) {vis = true;}
            break;
        case UIMenuState.pcView:
            layer_sequence_headdir(p1_pcView, seqdir_right);
            layer_sequence_play(p1_pcView);
            with(obj_PCView) {vis = true;}
            break;
        case UIMenuState.quest:
            layer_sequence_headdir(p1_quest, seqdir_right);
            layer_sequence_play(p1_quest);
            with(obj_Menu_QuestList_0) {vis = true;}
            with(obj_Menu_QuestInfo_0) {vis = true;}
            break;
        case UIMenuState.stats:
            layer_sequence_headdir(p1_playerStats, seqdir_right);
            layer_sequence_play(p1_playerStats);
            with(obj_Menu_PlayerStats_0) {vis = true;}
            break;    
    }
}

function RightOnExit()
{
    switch (p2State)
    {
        case UIMenuState.noUI:
            obj_Player2.Pause(true);  
            layer_sequence_headdir(p2_game, seqdir_left);
            layer_sequence_play(p2_game);          
            break;
        case UIMenuState.crafting:
            layer_sequence_headdir(p2_crafting, seqdir_left);
            layer_sequence_play(p2_crafting);
            with (obj_Menu_Crafting_1) {vis = false;}
            break;
        case UIMenuState.dialogue:
            layer_sequence_headdir(p2_dialogue, seqdir_left);
            layer_sequence_play(p2_dialogue);
            with (obj_Menu_DialogueText_1) {vis = false;}
            with (obj_Menu_DialogueSpeaker_1) {vis = false;}
            break;
        case UIMenuState.inventory:
            layer_sequence_headdir(p2_inventory, seqdir_left);
            layer_sequence_play(p2_inventory);
            with(obj_InventoryList_1) {vis = false;}
            with(obj_InventoryEquipped_1) {vis = false;}
            break;
        case UIMenuState.pause:
            layer_sequence_headdir(p2_pause, seqdir_left);
            layer_sequence_play(p2_pause);
            with(obj_KBManager_Pause_1) {vis = false;}
            break;
        case UIMenuState.pcView:
            layer_sequence_headdir(p2_pcView, seqdir_left);
            layer_sequence_play(p2_pcView);
            with(obj_PCView) {vis = false;}
            break;
        case UIMenuState.quest:
            layer_sequence_headdir(p2_quest, seqdir_left);
            layer_sequence_play(p2_quest);
            with(obj_Menu_QuestList_1) {vis = false;}
            with(obj_Menu_QuestInfo_1) {vis = false;}
            break;
        case UIMenuState.stats:
            layer_sequence_headdir(p2_playerStats, seqdir_left);
            layer_sequence_play(p2_playerStats);
            with(obj_Menu_PlayerStats_1) {vis = false;}
            break;    
    }
}

function RightOnEnter()
{
    switch (p2State)
    {
        case UIMenuState.noUI:
            alarm[1] = 10;
            layer_sequence_headdir(p2_game, seqdir_right);
            layer_sequence_play(p2_game);
            break;
        case UIMenuState.crafting:
            layer_sequence_headdir(p2_crafting, seqdir_right);
            layer_sequence_play(p2_crafting);
            with (obj_Menu_Crafting_1) {vis = true;}
            break;
        case UIMenuState.dialogue:
            layer_sequence_headdir(p2_dialogue, seqdir_right);
            layer_sequence_play(p2_dialogue);
            with (obj_Menu_DialogueText_1) {vis = true;}
            with (obj_Menu_DialogueSpeaker_1) {vis = true;}
            break;
        case UIMenuState.inventory:
            layer_sequence_headdir(p2_inventory, seqdir_right);
            layer_sequence_play(p2_inventory);
            with(obj_InventoryList_1) {vis = true;}
            with(obj_InventoryEquipped_1) {vis = true;}
            break;
        case UIMenuState.pause:
            layer_sequence_headdir(p2_pause, seqdir_right);
            layer_sequence_play(p2_pause);
            with(obj_KBManager_Pause_1) {vis = true;}
            break;
        case UIMenuState.pcView:
            layer_sequence_headdir(p2_pcView, seqdir_right);
            layer_sequence_play(p2_pcView);
            with(obj_PCView) {vis = true;}
            break;
        case UIMenuState.quest:
            layer_sequence_headdir(p2_quest, seqdir_right);
            layer_sequence_play(p2_quest);
            with(obj_Menu_QuestList_1) {vis = true;}
            with(obj_Menu_QuestInfo_1) {vis = true;}
            break;
        case UIMenuState.stats:
            layer_sequence_headdir(p2_playerStats, seqdir_right);
            layer_sequence_play(p2_playerStats);
            with(obj_Menu_PlayerStats_1) {vis = true;}
            break;    
    }
} 


echo($"notification sequence pos: {layer_sequence_get_x(p1_notification)}, {layer_sequence_get_y(p1_notification)}");
echo($"notification sequence pos: {layer_sequence_get_x(p2_notification)}, {layer_sequence_get_y(p2_notification)}");