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
            var fileItem = CurrentMenu.options[i];
            var line = "";

            if (fileItem.fileType == FileType.DIRECTORY) {
                line = string(fileItem.name) + " (Folder)";
            } 
            else if (fileItem.fileType == FileType.FILE) {
                line = string(fileItem.name) + " (Executable)";
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

function TryOpenElement(_FileItemName)
{
    var targetName = string_lower(_FileItemName);
    var FileItem = undefined;

    var foundFileItem = false;
    for (var i = 0; i < array_length(CurrentMenu.options); i += 1) {
        if (string_lower(CurrentMenu.options[i].name) == targetName) {
            FileItem = CurrentMenu.options[i];
            foundFileItem = true;
        }
    }

    if (!foundFileItem) {
        global.MainTextBox.AddMessage($"ERROR: FileItem [slant]\"{_FileItemName}\"[/] not found in current directory.");
        return;
    }

    switch (FileItem.fileType) 
    {
        case FileType.DIRECTORY:
            __openMenu(FileItem);
            break;
        case FileType.FILE:
            __openFileItem(FileItem);
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

function __openFileItem(_FileItem) { _FileItem.Call(); }

var gameDevFolder = new Directory("GameDev", 
[
    new FileItem("Trello.exe", function() { show_message("Trello.exe"); }),
    new FileItem("GameMaker.exe", function() { show_message("GameMaker.exe"); }),
    new FileItem("VisualStudio.exe", function() { show_message("VisualStudio.exe"); }),
]);

JournalFolder = new Directory("Journal", 
[
    new FileItem("Log.txt", function() { show_message("Log.txt"); }),
]);

devLogFolder = new Directory("DevLog", 
[
    new FileItem("OBS.exe", function() { show_message("OBS.exe"); }),
]);

gamesFolder = new Directory("Games", 
[
    new FileItem("Minecraft.exe", function() { show_message("Minecraft.exe"); }),
    new FileItem("Helldivers2.exe", function() { show_message("Helldivers2.exe"); }),
    new FileItem("Darkwood.exe", function() { show_message("Darkwood.exe"); }),
]);

moviesFolder = new Directory("Movies", 
[
    new FileItem("The_King_2019.wbrip", function() { show_message("The_King_2019.wbrip"); }),
    new FileItem("HTTYD2.wbrip", function() { show_message("HTTYD2.wbrip"); }),
]);

mailManager = new FileItem("MailManager.exe", function() { show_message("MailManager.exe"); });
gameSteamPage = new FileItem("MySteamPage.html", function() { show_message("MySteamPage.html"); });
toDoList = new FileItem("ToDoList.txt", function() { OpenTextDisplay("To Do List", @"How To Make A Video Game (Easy Edition)
Step #1: Open Trello and plan for game (I think it's in the GameDev folder..?)

Step #2: Open GameMaker and work on game!

Step #3: Go to Journal and write!

Step #4: Make Devlog with OBS

Step #5: Check Emails from Publishers

Step #6: Check Steam Page Reviews

Step #7: NEVER EVER REST!!! DON'T DO IT!! ONLY HARDCORE WIN!!! There 100% is a win state of life and you DEFINITELY don't keep growing as a person. Rest and Recovery DEFINITELY are not priorities and if you ever rest, your professors and your friends will laugh at you, stupid!") });

var desktopFolder = new Directory("V:", 
[
    toDoList,
    gameDevFolder,
    JournalFolder,
    devLogFolder,
    gamesFolder,
    moviesFolder,
    mailManager,
    gameSteamPage
]);

__openMenu(desktopFolder);