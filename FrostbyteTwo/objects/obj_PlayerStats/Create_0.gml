// Inherit the parent event
event_inherited();

Subscribe("StatsOpen", function() {
    OpenMenu();
    global.vars.PauseGame(id);
})

closeButton.AddCallback(function () {
    global.vars.ResumeGame(id);
})

textScale = 0.45;
