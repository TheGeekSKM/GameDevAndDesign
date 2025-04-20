global.LocationManager = id;

MenuStack = [];
CurrentMenu = undefined;

function GetAllOptionsInCurrentMenu()
{
    var str = "";

    if (CurrentMenu != undefined) 
    {
        for (var i = 0; i < array_length(CurrentMenu.options); i += 1) 
        {
            var file = CurrentMenu.options[i];
            var line = "";

            if (file.fileType == FileType.DIRECTORY) {
                line = string(file.name) + " (Folder)";
            } 
            else if (file.fileType == FileType.FILE) {
                line = string(file.name) + " (Executable)";
            }

            // Add newline only if it's not the last item
            if (i < array_length(CurrentMenu.options) - 1) {
                line += "\n";
            }

            str += line;
        }
    }

    return str;
}

function TryOpenElement(_fileName)
{
    var targetName = string_lower(_fileName);
    var file = undefined;

    var foundFile = false;
    for (var i = 0; i < array_length(CurrentMenu.options); i += 1) {
        if (string_lower(CurrentMenu.options[i].name) == targetName) {
            file = CurrentMenu.options[i];
            foundFile = true;
        }
    }

    if (!foundFile) {
        global.MainTextBox.AddMessage($"ERROR: File [slant]\"{_fileName}\"[/] not found in current directory.");
        return;
    }

    switch (file.fileType) 
    {
        case FileType.DIRECTORY:
            __openMenu(file);
            break;
        case FileType.FILE:
            __openFile(file);
            break;
    }
}

function GoBackMenu()
{
    if (array_length(MenuStack) > 1) {
        CurrentMenu = array_pop(MenuStack);
        CurrentMenu = array_pop(MenuStack);
    }
    else CurrentMenu = MenuStack[0];
        
    global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Move Back to Directory: {CurrentMenu.name}");
}

function GetCurrentPath()
{
    var path = "";
    for (var i = 0; i < array_length(MenuStack) - 1; i += 1) {
        path = string_concat(path, MenuStack[i].name, "/");
    }
    
    path = string_concat(path, MenuStack[array_length(MenuStack) - 1].name, " > ");

    return string_trim(path);
}

function __openMenu(_folder)
{
    CurrentMenu = _folder;
    array_push(MenuStack, CurrentMenu);
    
    global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Opened Directory: {_folder.name}");
    global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Current Path: {GetCurrentPath()}");
    
}

function __openFile(_file) { _file.Call(); }

var desktopFolder = new Directory("C:", [
    new Directory("Games", [
        new Directory("GameMaker", [
            new FileItem("GameMaker.exe", function() { global.MainTextBox.AddMessage("GameMaker Executable Opened!"); }),
            new FileItem("GameMaker Studio 2.exe", function() { global.MainTextBox.AddMessage("GameMaker Studio 2 Executable Opened!"); })
        ]),
        new FileItem("Steam.exe", function() { global.MainTextBox.AddMessage("Steam Executable Opened!"); }),
        new FileItem("EpicGamesLauncher.exe", function() { global.MainTextBox.AddMessage("Epic Games Launcher Executable Opened!"); })
    ]),
    new Directory("Documents", [
        new Directory("My Games", [
            new Directory("GameMaker Studio 2", [
                new Directory("My Projects", [
                    new FileItem("Project1.gml", function() { global.MainTextBox.AddMessage("Project1.gml Opened!"); }),
                    new FileItem("Project2.gml", function() { global.MainTextBox.AddMessage("Project2.gml Opened!"); })
                ])
            ])
        ])
    ])
]);

__openMenu(desktopFolder);