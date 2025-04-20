// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("clear", 0, [function() {
    global.MainTextBox.ClearBox();
}]);

commandLibrary.AddCommand("chat", 0, [function() {
    var done = CreateNewWindow(2);
    if (done) global.MainTextBox.AddMessage($"{current_hour}:{current_minute} -> Opened Chat Window Log!");
    else global.MainTextBox.AddMessage($"{current_hour}:{current_minute} -> Chat Window Log already Open!")
}]);