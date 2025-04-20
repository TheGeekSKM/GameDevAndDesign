// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("enter", 0, [function() {
    Transition(rmGame, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide)    
}]);
commandLibrary.AddCommand("credits", 0, [function() {
    CreateNewWindow(1);    
}]);

commandLibrary.AddCommand("exit", 0, [function() {
    game_end();    
}]);