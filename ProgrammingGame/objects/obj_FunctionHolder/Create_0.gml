depth = -5
functionName = "";
functionScript = "";

function CallScript()
{
    if (functionScript != "")
    {
        global.Interpreter.StartInterpreter(functionScript);
    }
}
