function Command(_keyword, _paramCount, _callbackArray) constructor {
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
    function AddCommand(_keyword, _paramArray, _callbackArray) 
    {
        var command = new Command(_keyword, _paramArray, _callbackArray);
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
            show_message($"Command {_commandKeyword} does not exist in the library.");
            return false;
        }
        else if (command[0] == InvalidCommandError.INVALID_PARAM_COUNT) 
        {
            show_message($"Command {_commandKeyword} has an invalid number of parameters. Expected {command[1]} parameters, got {array_length(_commandParamArray)} parameters instead!");
            return false;
        }
    }
}