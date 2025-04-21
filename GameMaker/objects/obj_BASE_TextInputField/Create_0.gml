deleteTimer = 2;
text = "";
textCharLimit = TextCharLimit;

commandLibrary = new CommandLibrary();

currentKeyword = "";
currentParamArray = [];

text_selected = false;

function EnterPressed()
{
    if (text != "" && text != undefined)
    {
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
    }

    FailedToRunCommand();
}

function FailedToRunCommand() {}