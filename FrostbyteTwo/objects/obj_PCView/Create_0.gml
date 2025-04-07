// Inherit the parent event
event_inherited();

Subscribe("PCViewOpen", function() {
    OpenMenu()
    global.vars.PauseGame(global.vars.Player);
})

closeButtonCallback = function() {
    global.vars.ResumeGame(global.vars.Player);
}

followCPU = 0;
followGPU = 0;
followRAM = 0;