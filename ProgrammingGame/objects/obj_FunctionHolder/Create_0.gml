depth = -5
functionName = "";
functionScript = "";
selected = false;

compiledCode = {};
hovered = false;

playerExists = instance_exists(obj_Player);



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

if (variable_global_exists($"CompiledCode{Index + 1}"))
{
    compiledCode = variable_global_get($"CompiledCode{Index + 1}")
    
    if (compiledCode[$ "FunctionName"] != undefined)
    {
        functionName = compiledCode.FunctionName;
        functionScript = compiledCode.RawCode;
    }
    
    
}
