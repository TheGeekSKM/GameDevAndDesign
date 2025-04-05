// Inherit the parent event
event_inherited();

resumeHoverColor = make_color_rgb(215, 255, 204);
resumeClickColor = make_color_rgb(149, 255, 119);

mainMenuHoverColor = make_color_rgb(206, 245, 255);
mainMenuClickColor = make_color_rgb(119, 227, 255);

quitHoverColor = make_color_rgb(255, 206, 206);
quitClickColor = make_color_rgb(255, 119, 119);

Subscribe("PauseOpen", function() {
    obj_GUI_PanelMoveable.OpenMenu();
    global.vars.PauseGame(id);
});


function Resume()
{
    obj_GUI_PanelMoveable.HideMenu();
    global.vars.ResumeGame(global.vars.Player);
}

function MainMenu()
{
    Transition(rmMainMenu, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
}

function Quit()
{
    game_end();
}

buttonContainer = new ButtonContainer(id, true);
buttonContainer.SetPadding(18);
buttonContainer.SetSpacing(10);
buttonContainer.AddButton("Resume", resumeHoverColor, resumeClickColor, Resume)
buttonContainer.AddButton("Main Menu", mainMenuHoverColor, mainMenuClickColor, MainMenu)
buttonContainer.AddButton("Quit", quitHoverColor, quitClickColor, Quit)
buttonContainer.Create();

obj_GUI_PanelMoveable.closeButtonCallback = function() {
    global.vars.ResumeGame(global.vars.Player);
}