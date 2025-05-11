deleteTimer = 2;
text = "";
textCharLimit = TextCharLimit;

commandLibrary = new CommandLibrary();

currentKeyword = "";
currentParamArray = [];

text_selected = false;

recentlyEnteredCommands = [];
recentlyEnteredCommandIndex = -1;

function EnterPressed()
{
    if (text != "" && text != undefined)
    {
        array_push(recentlyEnteredCommands, text);
        recentlyEnteredCommandIndex = array_length(recentlyEnteredCommands);
        echo(recentlyEnteredCommands)

        // separate the text before the (
        text = string_lower(string_trim(text));
        var textSplit = string_split_ext(text, [ "(", ")", ",", " "], true);
        var commandName = textSplit[0];

        currentKeyword = commandName;
        
        var commandParamArray = [];
        for (var i = 1; i < array_length(textSplit); i += 1) {
            array_push(commandParamArray, textSplit[i]);
        }

        currentParamArray = commandParamArray;

        var couldRun = commandLibrary.RunCommand(commandName, commandParamArray);
        
        if (couldRun) {
            text = "";
            commandParamArray = [];
            return;
        }
        else {
            text = "";
            commandParamArray = [];
        }
        
    }

    FailedToRunCommand();
}

function FailedToRunCommand() {}


function AttemptAutocomplete()
{
    if (text == "" || text == undefined)
    {
        return;
    }

    var textSplit = string_split_ext(text, [ "(", ")", ",", " "], true);
    //get the last word
    var lastWord = textSplit[array_length(textSplit) - 1];

    var autocorrected = false;

    //// loop through the command library
    //var commandList = struct_get_names(global.vars.CommandLibrary);
    //var commandListLength = array_length(commandList);
//
    //for (var i = 0; i < commandListLength; i += 1) 
    //{
        //if (string_starts_with(string_lower(commandList[i]), string_lower(lastWord)))
        //{
            //lastWord = commandList[i];
            //autocorrected = true;
            //break;
        //}
    //}

    if (!autocorrected)
    {
        // loop through commands in the local command library
        var localCommandList = struct_get_names(commandLibrary);
        var localCommandListLength = array_length(localCommandList);

        for (var i = 0; i < localCommandListLength; i += 1) 
        {
            if (string_starts_with(string_lower(localCommandList[i]),  string_lower(lastWord)))
            {
                lastWord = localCommandList[i];
                autocorrected = true;
                break;
            }
        }
    }

    if (!autocorrected && variable_global_exists("LocationManager"))
    {
        // loop through the current files in the current directory
        var optionsArray = global.LocationManager.GetFileNameArrayInCurrentMenu();
        var optionsArrayLength = array_length(optionsArray);

        for (var i = 0; i < optionsArrayLength; i += 1) 
        {
            if (string_starts_with(string_lower(optionsArray[i]),  string_lower(lastWord)))
            {
                lastWord = optionsArray[i];
                autocorrected = true;
                break;
            }
        }
    }


    if (autocorrected)
    {
        var finalString = "";
        for (var i = 0; i < array_length(textSplit); i += 1) 
        {
            if (i == array_length(textSplit) - 1)
            {
                finalString += string_concat(" ", lastWord);
            }
            else
            {
                finalString += string_concat(" ", textSplit[i]);
            }
        }

        text = string_trim(finalString);
    }
}