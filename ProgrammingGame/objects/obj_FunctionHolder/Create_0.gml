depth = -5
functionName = "";
functionScript = "";
selected = false;

compiledCode = {};

function CallScript()
{
    if (functionScript != "")
    {
        global.Interpreter.StartInterpreter(functionScript);
    }
}

function Selected()
{
    selected = true;
}

function NotSelected()
{
    selected = false;
}
