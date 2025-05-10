function Commands(_keyword, _paramCount, _callbackArray) constructor {
    self.keyword = _keyword;
    self.paramCount = _paramCount;
    self.callbackArray = _callbackArray;

    function Call(_passedInParamArray) 
    {
        for (var i = 0; i < array_length(self.callbackArray); i += 1) 
        {
            if (self.callbackArray[i] != undefined) self.callbackArray[i](_passedInParamArray);
        }
    }
}


enum InvalidCommandError
{
    DOES_NOT_EXIST = -1,
    INVALID_PARAM_COUNT = -2,
}
function CommandLibrary() constructor 
{

    function AddCommand(_keyword, _paramCount, _callbackArray) 
    {
        var command = new Commands(_keyword, _paramCount, _callbackArray);
        if (self[$ _keyword] == undefined) self[$ _keyword] = command;
        else show_message($"Command {_keyword} already exists in the library.");
    }
    
    function ValidateCommand(_keyword, _paramArray) 
    {
        var command = self[$ _keyword];
        if (command == undefined) return [InvalidCommandError.DOES_NOT_EXIST, undefined];
        else if (command.paramCount != array_length(_paramArray)) return [InvalidCommandError.INVALID_PARAM_COUNT, command.paramCount];
        else return [0, command];
    }
    

    function RunCommand(_commandKeyword, _commandParamArray)
    {
        var command = ValidateCommand(_commandKeyword, _commandParamArray);
        if (command[0] == 0)
        {
            command[1].Call(_commandParamArray);
            return true;
        }
        else if (command[0] == InvalidCommandError.DOES_NOT_EXIST) 
        {
            var str = $"Command [slant]\"{_commandKeyword}\"[/] does not exist in the library.";
            if (variable_global_exists("MainTextBox"))
            {
                global.MainTextBox.AddMessage($"[c_yellow]WARNING: [\]{str}\n    [c_player]TIP:[/] Use the [wave][c_gold]\"dir\"[/] command to view valid names in the current folder!");
            }
            else {
                var notif = instance_create_depth(400, 224, -1000, obj_BadCode);
                notif.SetDescription(str);
            }


            return false;
        }
        else if (command[0] == InvalidCommandError.INVALID_PARAM_COUNT) 
        {
            var str = $"Command [slant]\"{_commandKeyword}\"[/] has an invalid number of parameters. Expected {command[1]} params, but got {array_length(_commandParamArray)}, instead.";
            if (variable_global_exists("MainTextBox"))
            {
                global.MainTextBox.AddMessage($"[c_yellow]WARNING: [\]{str}\n    [c_player]TIP:[/] Use the [wave][c_gold]\"help\"[/] command to view the different commands and their required Parameters!");
            }
            else {
                var notif = instance_create_depth(400, 224, -1000, obj_BadCode);
                notif.SetDescription(str);
            }
            return false;
        }
    }
}