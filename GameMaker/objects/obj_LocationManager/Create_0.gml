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
    
        global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Move Back to Directory: {CurrentMenu.name}");
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
    
    global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Opened Directory: {_folder.name}");
    global.MainTextBox.AddMessage($"{current_hour}:{current_minute}:{current_second} -> Current Path: {GetCurrentPath()}");
    global.MainTextBox.AddMessage($"{GetAllOptionsInCurrentMenu()}");
    
    
}

function __openFileItem(_FileItem) { _FileItem.Call(); }

var gameDevFolder = new Directory("GameDev", 
[
    new FileItem("Trello.exe", function() { 
        var data = SafeReadJson(working_directory + "GameData.json");
        if (data == undefined)
        {
            OpenGamePlanner();
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] Game Designed! Open Trello.exe again to confirm it (It's a system error, just go with it)!");
            
        }
        else {
            global.GameData = data;
            global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] Great! Game Data Stored! Feel free to check the Log.txt in the V: Folder to see your deadline!");
        }
    }),
    new FileItem("GameMaker.exe", function() { 
        var quality = random_range(15, 35);
        global.GameData.Quality += quality;
        
        var burnout = round(quality / 15);
        global.GameData.Burnout += burnout;
        Raise("BurnoutModified", global.GameData.Burnout);

        global.GameData.CurrentDay++;
        if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
        {
            Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }
        
        global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a lot of progress in 8hrs, despite the tremendous lack of prebuilt systems! Check your log to see updates! Don't forget to Devlog!!");
    }),
    new FileItem("VisualStudio.exe", function() { 
        var quality = random_range(10, 50);
        global.GameData.Quality += quality;
        
        var burnout = round(quality / 10);
        global.GameData.Burnout += burnout;
        Raise("BurnoutModified", global.GameData.Burnout);

        global.GameData.CurrentDay++;
        if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
        {
            Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }        
        global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a lot of progress in 8hrs, despite the fact that VSCode eats up so much of your RAM...and it's VSCODE! Check your log to see updates! Don't forget to Devlog!!");
    }),
]);

JournalFolder = new FileItem("Log.txt", function() {
        
        OpenTextDisplay(
        $"Log ({current_month}/{current_day}/{current_year}, {current_hour}:{current_minute})",
        $"Current Statistics: \n1. Game Name: {global.GameData.Name}\n2. Number of Days in Project: {global.GameData.CurrentDay}/{global.GameData.MaxNumOfDays} days\n3. Public Interest: {global.GameData.Interest}\n4. Burnout Level: {global.GameData.Burnout}"
        )}
);

devLogFolder = new Directory("DevLog", 
[
    new FileItem("OBS.exe", function() { 
        var interest = random_range(10, 50);
        global.GameData.Interest += interest;
 
        var burnout = round(interest / 10);
        global.GameData.Burnout += burnout;
        Raise("BurnoutModified", global.GameData.Burnout);


        global.GameData.CurrentDay++;
        if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
        {
            Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }        
 
        global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You made a lot of progress in 8hrs! Your devlog got {global.GameData.Interest} views!! Check your log to see updates! Don't forget to Devlog!!");
    }),
]);

function RestGames()
{
    var interest = random_range(3, 20);
    global.GameData.Interest -= interest;

    var burnout = round(interest / 7) + irandom_range(0, 3);
    global.GameData.Burnout -= burnout;
    Raise("BurnoutModified", global.GameData.Burnout);


    global.GameData.CurrentDay++;
    if (global.GameData.CurrentDay >= global.GameData.MaxNumOfDays)
    {
        Transition(rmEnd, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
    }    

    global.MainTextBox.AddMessage($"[c_lime]NOTE:[/] You rested and played video games for day. It was nice...hopefully...your anxiety didn't actually let you enjoy too much...Check your log to see updates! Don't forget to WORK!!");   
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
    Raise("BurnoutModified", global.GameData.Burnout);


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

function GetProfessorMessage(quality, interest, deadline_pct) {
    var msg = "";
    var rng = irandom(2); // 0, 1, or 2

    // BASED ON QUALITY
    if (quality <= 40) {
        switch (rng) {
            case 0: msg = "You -> Yourself: Are you even [slant]trying[/]? This is disgraceful."; break;
            case 1: msg = "You -> Yourself: This is beneath my lowest expectations."; break;
            case 2: msg = "You -> Yourself: I didn't think you could disappoint me this creatively."; break;
        }
    }
    else if (quality <= 70) {
        switch (rng) {
            case 0: msg = "You -> Yourself: This is tolerable. But tolerable is failure in disguise."; break;
            case 1: msg = "You -> Yourself: You're halfway there—and already slowing down."; break;
            case 2: msg = "You -> Yourself: You're on a knife's edge. Blink, and you fall."; break;
        }
    }
    else {
        switch (rng) {
            case 0: msg = "You -> Yourself: So? One good build doesn't mean you can breathe."; break;
            case 1: msg = "You -> Yourself: This is acceptable. Which means you've stopped aiming higher."; break;
            case 2: msg = "You -> Yourself: Don't confuse momentum with mastery."; break;
        }
    }

    // MODIFIER: INTEREST
    if (interest >= 80) {
        msg = string_concat(msg, " The world is watching. Don't embarrass us both.");
        //msg += " The world is watching. Don’t embarrass us both.";
    }
    else if (interest <= 30) {
        msg = string_concat(msg, " No one cares. [slant]Make[/] them care before it's too late.");
        //msg += " No one cares. *Make* them care before it's too late.";
    }

    // TIME PRESSURE OVERLAY
    if (deadline_pct >= 0.8) {
        var final_msgs = [
            "This is the endgame. Panic is not optional.",
            "Deadline's on your doorstep, and you're still fumbling.",
            "No more extensions. No more excuses. Deliver or die."
        ];
        msg = string_concat(msg, " ", final_msgs[irandom(2)]);
    }
    else if (deadline_pct >= 0.5) {
        msg += " Time's bleeding away. Are you going to [slant]do something[/], or just flail?";
    }
    else if (deadline_pct >= 0.2) {
        msg += " You still think you have time. How quaint.";
    }

    return string_concat(msg, "\n");
}

mailManager = new FileItem("MailManager.exe", function() { obj_ChatManager.SaveMessage("", GetProfessorMessage(global.GameData.Quality, global.GameData.Interest, (global.GameData.CurrentDay / global.GameData.MaxNumOfDays))) CreateNewWindow(2); });
gameSteamPage = new FileItem("MySteamPage.html", function() { show_message("BETA: MySteamPage.html"); });
toDoList = new FileItem("ToDoList.txt", function() { OpenTextDisplay("To Do List", @"[c_yellow][scale, 2]How To Make A Video Game (Easy Edition)[/]

Step #1: Open Trello and plan for game (I think it's in the GameDev folder..?)

Step #2: Open GameMaker and work on game!

Step #3: Go to Log and write!

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