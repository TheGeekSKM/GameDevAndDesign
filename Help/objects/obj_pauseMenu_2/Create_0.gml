// Inherit the parent event
event_inherited();

vis = false;

buttons = ["Resume", "Inventory", "Quests", "Main Menu", "Exit"];
buttonFunc = [
    function() {
        Raise("PauseClose", obj_Player2);
    },
    function() {
        Raise("InventoryOpen", obj_Player2);
    },
    function() {
        Raise("QuestOpen", obj_Player2);
    },
    function() {
        Transition(rmMainMenu, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    },
    function() {
        game_end();
    }
];

selectIndex = 0;
buttonSprite = spr_button;
startingPos = new Vector2(0, -100);

blackBackgroundAlpha = 0;