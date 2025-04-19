deleteTimer = 2;
text = "";
textCharLimit = TextCharLimit;

commandLibrary = new CommandLibrary();

function EnterPressed()
{
    if (text != "" && text != undefined)
    {
        // separate the text before the (
        text = string_lower(string_trim(text));
        var textSplit = string_split_ext(text, [ "(", ")" ], true);
        var commandName = textSplit[0];
        
        var commandParamArray = [];
        for (var i = 1; i < array_length(textSplit); i += 1) {
            array_push(commandParamArray, textSplit[i]);
        }

        var couldRun = commandLibrary.RunCommand(commandName, commandParamArray);
        
        if (couldRun) {
            text = "";
            commandParamArray = [];
            return;
        }
    }

    FailedToRunCommand();
}

function FailedToRunCommand() {}



