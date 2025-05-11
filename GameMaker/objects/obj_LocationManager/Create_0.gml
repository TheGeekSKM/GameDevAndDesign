global.LocationManager = id;

MenuStack = [];
CurrentMenu = undefined;
function pad_left(_str, _len) {
    while (string_length(_str) < _len) _str = " " + _str;
    return _str;
}
function pad_right(_str, _len) {
    while (string_length(_str) < _len) _str += " ";
    return _str;
}

function GetFileNameArrayInCurrentMenu() 
{
    var returnArr = [];
    for (var i = 0; i < array_length(CurrentMenu.options); i += 1) 
    {
        array_push(returnArr, CurrentMenu.options[i].name);
    }
    return returnArr;
}

function GetFileTypeFromName(_name) 
{
    var fileType = FileType.FILE;
    for (var i = 0; i < array_length(CurrentMenu.options); i += 1) 
    {
        if (string_lower(CurrentMenu.options[i].name) == string_lower(_name)) 
        {
            fileType = CurrentMenu.options[i].fileType;
            break;
        }
    }
    return fileType;
}

function GetAllOptionsInCurrentMenu() {
    var out = $" Directory of {CurrentMenu.name}\n\n";
    var opts = CurrentMenu.options;
    if (array_length(opts) == 0) return out + "  [empty]\n";
    
    // Simulate CMD header
    out += "   Date        Time      " + pad_right("Size", 12) + "Name\n";
    out += "   ----------  --------  ------------ --------------\n";
    for (var i = 0; i < array_length(opts); i++) {
        var itm = opts[i];
        var meta = itm.meta;
        var isFolder = (itm.fileType == FileType.DIRECTORY);
        var dateStr = meta != undefined ? string_copy(meta.created, 1, 10) : "01/01/2024";
        var timeStr = meta != undefined ? string_copy(meta.created, 11, 8) : "12:00 AM";// + " " + string_copy(meta.created, 18, 2) : "12:00 AM";
        var sizeStr = isFolder ? "<DIR>" : string(meta.size);
        sizeStr = pad_left(sizeStr, 10);
        var nameStr = itm.name;

        out += "   " + dateStr + "  " + timeStr + "  " + sizeStr + "  " + nameStr + "\n";
    }
    return out;
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
        global.MainTextBox.AddMessage($"[c_red]ERROR:[/] FileItem [slant]\"{_FileItemName}\"[/] not found in current directory.");
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
    function GoBackMenu()
    {
        if (array_length(MenuStack) > 1) {
            array_pop(MenuStack); // Pop current menu
            CurrentMenu = MenuStack[array_length(MenuStack) - 1]; // Set to the new top of the stack
        }
        else {
            // Already at root
            CurrentMenu = MenuStack[0];
        }
    
        global.MainTextBox.AddMessage($"[c_lime]{current_hour}:{current_minute}:{current_second}[/] -> Move Back to Directory: {CurrentMenu.name}");
        global.MainTextBox.AddMessage($"{GetAllOptionsInCurrentMenu()}");
    }
    
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
    array_push(MenuStack, _folder);
    CurrentMenu = _folder;
    
    global.MainTextBox.AddMessage($"[c_lime]{current_hour}:{current_minute}:{current_second}[/] -> Opened Directory: {_folder.name}");
    global.MainTextBox.AddMessage($"[c_lime]{current_hour}:{current_minute}:{current_second}[/] -> Current Path: {GetCurrentPath()}");
    global.MainTextBox.AddMessage($"{GetAllOptionsInCurrentMenu()}");
    
    
}

function __openFileItem(_FileItem) { _FileItem.Call(); }

gameDevFolder = new Directory("GameDev", 
[
    new FileItem("Trello.exe", function() { 
        if (variable_global_exists("GameData")) 
        {
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You already designed a game! Open [c_gold]GameMaker.exe[/], [c_gold]VisualStudio.exe[/], or [c_gold]V:/DevLog/OBS.exe[/] to work on it!");
            return;
        } 
        OpenGamePlanner();
    }),
    new FileItem("GameMaker.exe", function() 
    {
        if (!variable_global_exists("GameData")) 
        {
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You haven't designed a game yet! Start [c_gold]Trello.exe[/] first to design a game with the [c_lime][wave]'start'[/] command!");
            return;
        }         
        obj_MiniGameManager.LaunchProgrammingMinigame();
    }),
    new FileItem("VisualStudio.exe", function() { 

        if (!variable_global_exists("GameData")) 
        {
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You haven't designed a game yet! Start [c_gold]Trello.exe[/] first to design a game with the [c_lime][wave]'start'[/] command!");
            return;
        } 

        var quality = random_range(10, 50);
        global.GameData.Quality += quality;
        
        var burnout = round(quality / 10);
        global.GameData.Burnout += burnout;
        Raise("BurnoutModified", burnout);

        global.GameData.CurrentDay++;
        if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
        {
            Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }        
        global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a lot of progress in 8hrs, despite the fact that VSCode eats up so much of your RAM...and it's VSCODE! Check your log to see updates! Don't forget to Devlog!!");
    }),
]);

JournalFolder = new FileItem("Log.txt", function() {
        
    var currentStats = string_concat("Current Statistics: \n1. Game Name: ", 
        global.GameData.Name, "\n2. Number of Days in Project: ", 
        global.GameData.CurrentDay, "/", 
        global.GameData.MaxNumOfDays, " days\n3. Public Interest: ", 
        global.GameData.Interest, "\n4. Burnout Level: ", 
        global.GameData.Burnout
    );
    
    var logText = string_concat(
        "Log (", current_month, 
        "/", current_day + global.GameData.CurrentDay, 
        "/", current_year, ", ", 
        current_hour, ":", 
        current_minute, ")"
    );
    
    OpenTextDisplay(logText, currentStats)}
);

devLogFolder = new Directory("DevLog", 
[
    new FileItem("OBS.exe", function() {
        if (!variable_global_exists("GameData")) 
        {
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You haven't designed a game yet! Start [c_gold]V:/GameDev/Trello.exe[/] first to design a game with the [c_lime][wave]'start'[/] command!");
            return;
        } 
        obj_MiniGameManager.LaunchEditingMinigame();
    }),
]);

function RestGames()
{
    var interest = random_range(3, 20);
    global.GameData.Interest -= interest;

    var burnout = round(interest / 7) + irandom_range(0, 3);
    global.GameData.Burnout -= burnout;
    Raise("BurnoutModified", burnout);


    global.GameData.CurrentDay++;
    if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
    {
        Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    }    

    global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You rested and played video games for day. It was nice...[wave]hopefully[/]...your anxiety didn't actually let you enjoy too much...Check your log to see updates! Don't forget to WORK!!");   
}

gamesFolder = new Directory("Games", 
[
    new FileItem("Minecraft.exe", function() { RestGames(); }),
    new FileItem("Helldivers2.exe", function() { RestGames(); }),
    new FileItem("Darkwood.exe", function() { RestGames(); }),
]);

function RestMovies()
{
    var interest = random_range(3, 20);
    global.GameData.Interest -= interest;

    var burnout = round(interest / 7) + irandom_range(0, 3);
    global.GameData.Burnout -= burnout;
    Raise("BurnoutModified", burnout);


    global.GameData.CurrentDay++;
    if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
    {
        Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    }    

    global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You rested and watched movies for day. It was nice...hopefully...your anxiety didn't actually let you enjoy too much...Check your log to see updates! Don't forget to WORK!!");   
}

moviesFolder = new Directory("Movies", 
[
    new FileItem("The_King_2019.wbrip", function() { RestMovies(); }),
    new FileItem("HTTYD2.wbrip", function() { RestMovies(); }),
]);



mailManager = new FileItem("MailManager.exe", function() {  
    CreateNewWindow(2);
});
gameSteamPage = new FileItem("MySteamPage.html", function() { show_message("BETA: MySteamPage.html"); });
toDoList = new FileItem("ToDoList.txt", function() { OpenTextDisplay("To Do List", @"[c_yellow][scale, 2]How To Make A Video Game (Easy Edition)[/]

Step #1: Open Trello and plan for game (I think it's in the GameDev folder..?)
[c_gold]cd [c_cyan]GameDev [c_grey][slant]-> This will navigate to the GameDev folder.[/]
[c_gold]start [c_cyan]Trello.exe [c_grey][slant]-> This will open Trello.[/]

Step #2: Open GameMaker and work on game!
[c_gold]dir [c_grey][slant]-> This will help me check what folder I'm in.[/]
[c_gold]start [c_cyan]GameMaker.exe [c_grey]or [c_gold]start VisualStudio.exe [c_grey][slant]-> I can start up GameMaker.exe or VisualStudio.exe when I'm in the GameDev folder.[/]

Step #3: Go to Log and write!
[c_gold]cd [c_cyan].. [c_grey][slant]-> This will take me out of my current folder and it should leave me in the Main V: folder[/]
[c_gold]start [c_cyan]Log.txt [c_grey][slant]-> This will open the Log.txt file, so I can check in on the game's progress...and how I'm feeling...[/]

Step #4: Make Devlog with OBS
[c_gold]cd [c_cyan]DevLog [c_grey][slant]-> This will take me to the DevLog folder.[/]
[c_gold]start [c_cyan]OBS.exe [c_grey][slant]-> This will open OBS, so I can record my Devlog.[/]

Step #8: NEVER EVER REST!!! DON'T DO IT!! ONLY HARDCORE WIN!!! There 100% is a win state of life and you DEFINITELY don't keep growing as a person. Rest and Recovery DEFINITELY are not priorities and if you ever rest, your professors and your friends will laugh at you, stupid!") });

var desktopFolder = new Directory("V:", 
[
    toDoList,
    gameDevFolder,
    JournalFolder,
    devLogFolder,
    gamesFolder,
    moviesFolder,
    mailManager,
    //gameSteamPage
]);

__openMenu(desktopFolder);