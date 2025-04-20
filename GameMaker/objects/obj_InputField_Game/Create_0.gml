// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("clear", 0, [function() {
    global.MainTextBox.ClearBox();
}]);

commandLibrary.AddCommand("chat", 0, [function() {
    CreateNewWindow(2)
}]);