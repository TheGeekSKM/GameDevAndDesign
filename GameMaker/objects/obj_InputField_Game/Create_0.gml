// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("clear", 0, [function() {
    global.MainTextBox.ClearBox();
}]);

commandLibrary.AddCommand("chat", 0, [function() {
    var done = CreateNewWindow(2);
    if (done) global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Opened Chat Window Log!");
    else global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Chat Window Log already Open!")
}]);

commandLibrary.AddCommand("list", 0, [function() {
    var str = global.LocationManager.GetAllOptionsInCurrentMenu();
    global.MainTextBox.AddMessage($"{str}");
}]);

commandLibrary.AddCommand("open", 1, [function(_args) {
    var str = global.LocationManager.TryOpenElement(_args[0]);
}]);

commandLibrary.AddCommand("back", 0, [function() {
    var str = global.LocationManager.GoBackMenu();
}]);

commandLibrary.AddCommand("exit", 0, [function() {
    game_end();
}]);

commandLibrary.AddCommand("help", 0, [function() {
    CreateNewWindow(5);
}]);