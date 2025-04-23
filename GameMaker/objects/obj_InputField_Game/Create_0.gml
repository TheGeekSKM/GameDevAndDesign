// Inherit the parent event
event_inherited();

commandLibrary.AddCommand("clear", 0, [function() {
    global.MainTextBox.AddMessage("> clear", true)
    global.MainTextBox.ClearBox();

}]);

commandLibrary.AddCommand("cls", 0, [function() {
    global.MainTextBox.AddMessage("> cls", true)
    global.MainTextBox.ClearBox();
}]);

commandLibrary.AddCommand("chat", 0, [function() {
    global.MainTextBox.AddMessage("> chat", true)
    var done = CreateNewWindow(2);
    if (done) global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Opened Chat Window Log!", true);
    else global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Chat Window Log already Open!", true)
}]);

commandLibrary.AddCommand("list", 0, [function() {
    global.MainTextBox.AddMessage($"> list", true);
    var str = global.LocationManager.GetAllOptionsInCurrentMenu();
    global.MainTextBox.AddMessage($"{str}", true);
}]);

commandLibrary.AddCommand("dir", 0, [function() {
    global.MainTextBox.AddMessage($"> dir", true);
    var str = global.LocationManager.GetAllOptionsInCurrentMenu();
    global.MainTextBox.AddMessage($"{str}", true);
}]);

commandLibrary.AddCommand("cd", 1, [function(_args) {
    global.MainTextBox.AddMessage($"> cd {_args[0]}", true);
    if (_args[0] == "..")
    {
        global.LocationManager.GoBackMenu();
        var str = global.LocationManager.GetAllOptionsInCurrentMenu();
        global.MainTextBox.AddMessage($"{str}", true);
    }
    else
    {
        global.LocationManager.TryOpenElement(_args[0]);
    }
}]);

commandLibrary.AddCommand("start", 1, [function(_args) {
    global.MainTextBox.AddMessage($"> start {_args[0]}", true)
    global.LocationManager.TryOpenElement(_args[0]);
}]);


commandLibrary.AddCommand("exit", 0, [function() {
    global.MainTextBox.AddMessage("> exit", true)
    game_end();
}]);

commandLibrary.AddCommand("help", 0, [function() {
    global.MainTextBox.AddMessage("> help", true)
    CreateNewWindow(5);
}]);

//commandLibrary.AddCommand("mainmenu", 0, [function() {
    //global.WindowManager.GameEnd();
    //Transition(rmInit2, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
//}]);