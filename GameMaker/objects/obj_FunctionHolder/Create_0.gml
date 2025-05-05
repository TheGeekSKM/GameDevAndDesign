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
    var _global_name = $"CompiledCode{Index + 1}";
    var _global_value = variable_global_get(_global_name); // Get the value


    compiledCode = _global_value; // Assign AFTER debugging

    // Add a safety check before using the variable
    if (!is_struct(compiledCode)) {
        compiledCode = {}; // Reset to avoid crash, but indicates a problem
    }

    // Now the line that might fail
    if (variable_struct_exists(compiledCode, "FunctionName")) // Check the potentially reset compiledCode
    {
        functionName = compiledCode.FunctionName;
        functionScript = compiledCode.RawCode;
    }
    else
    {
        // This might happen if compiledCode holds an error struct { Errors: [...] }
    }
}
