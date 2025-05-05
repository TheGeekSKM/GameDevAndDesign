global.Interpreter = id;

compiledInstructions = [];
lineMapping = [];
currentIndex = 0;
lastResult = undefined;
isRunning = false;
instructionsPerAlarmTick = 2;
tickDelay = 5;
currentRawLine = -1;

variableStore = ds_map_create();
loopStack = [];


// --- Clean Up Event ---
if (ds_exists(variableStore, ds_type_map)) { ds_map_destroy(variableStore); }


// --- Functions ---

/// @function            StartInterpreter(_compiledStruct)
function StartInterpreter(_compiledStruct) {
    if (_compiledStruct == undefined || (variable_struct_exists(_compiledStruct, "Errors") && _compiledStruct.Errors != undefined)) 
    {
        var errorMsg = "Interpreter Error: Cannot start with invalid code.";
        if (variable_struct_exists(_compiledStruct, "Errors") && _compiledStruct.Errors != undefined && array_length(_compiledStruct.Errors) > 0) { errorMsg = string_concat(errorMsg, "\nFirst Error: ", _compiledStruct.Errors[0]); }
        show_message(errorMsg); 
        isRunning = false; 
        return;
    }
    compiledInstructions = _compiledStruct.CompiledArray;
    lineMapping = _compiledStruct.LineMapping;
    currentIndex = 0; 
    lastResult = undefined; 
    currentRawLine = -1;
    ds_map_clear(variableStore);
    loopStack = [];
    isRunning = true; alarm[0] = tickDelay;
    show_message("Interpreter started.");
}

/// @function            StopInterpreter()
function StopInterpreter() {
    isRunning = false; 
    alarm[0] = -1;
    compiledInstructions = []; 
    lineMapping = []; 
    currentRawLine = -1;
    ds_map_clear(variableStore); 
    loopStack = [];
    show_message("Interpreter stopped.");
}

/// @function            ExecuteInstruction(_instr)
function ExecuteInstruction(_instr) {
    if (_instr == "" || _instr == undefined) {
        return;
    }
    show_message(string_concat("Executing: ", _instr));

    // --- Handle Variable Declaration (Direct Value) ---
    if (string_starts_with(_instr, "DeclareVar(")) {
        var content = string_copy(_instr, 12, string_length(_instr) - 12);
        var commaPos = string_pos(",", content);
        if (commaPos > 0) {
            var varName = string_copy(content, 1, commaPos - 1);
            var varValueStr = string_copy(content, commaPos + 1, string_length(content) - commaPos);
            variableStore[? varName] = real(varValueStr);
            show_message(string_concat("Declared '", varName, "' = ", string(variableStore[? varName])));
            // TODO: Subtract memory cost for variable declaration/storage
        } else {
            show_message(string_concat("Error: Malformed DeclareVar: ", _instr));
            StopInterpreter();
        }
        return;
    }

    // --- Handle Variable Assignment (From [result]) ---
    if (string_starts_with(_instr, "AssignVar(")) {
         var content = string_copy(_instr, 11, string_length(_instr) - 11); // Get "name,[result])"
         var commaPos = string_pos(",", content);
         if (commaPos > 0) {
            var varName = string_copy(content, 1, commaPos - 1);
            var valueSource = string_copy(content, commaPos + 1, string_length(content) - commaPos); // Should be "[result]"
            show_message(string_concat("Value source: ", valueSource));

            if (valueSource == "[result]") {
                if (lastResult != undefined) {
                    variableStore[? varName] = lastResult;
                    show_message(string_concat("Assigned '", varName, "' = ", string(lastResult), " from [result]"));
                    // TODO: Subtract memory cost for assignment operation (optional)
                } else {
                    show_message(string_concat("Warning: AssignVar trying to use [result] for '", varName,"' but last result was undefined. Variable not assigned."));
                }
            } else {
                show_message(string_concat("Error: Malformed AssignVar instruction. Expected '[result]' as source: ", _instr, " (found: ", valueSource, ")"));
                StopInterpreter();
            }
         } else {
             show_message(string_concat("Error: Malformed AssignVar instruction: ", _instr));
             StopInterpreter();
         }
         return;
    }

    // --- Handle RepeatStart ---
    if (string_starts_with(_instr, "RepeatStart(")) 
    {
        var content = string_copy(_instr, 13, string_length(_instr) - 13 - 1);
        var commaPos = string_pos(",", content);
        var jumpOffsetPos = string_pos("jump_offset:", content);
        if (commaPos > 0 && jumpOffsetPos > commaPos) 
        {
            var paramPart = string_copy(content, 1, commaPos - 1);
            var jumpOffsetStr = string_copy(content, jumpOffsetPos + 12, string_length(content) - (jumpOffsetPos + 11));
            var jumpOffset = real(jumpOffsetStr);
            var loopCount = 0;
            var colonPos = string_pos(":", paramPart);
            if (colonPos > 0) 
            {
                var paramType = string_copy(paramPart, 1, colonPos - 1);
                var paramValue = string_copy(paramPart, colonPos + 1, string_length(paramPart) - colonPos);
                if (paramType == "number") 
                {
                    loopCount = real(paramValue);
                } 
                else if (paramType == "lookup") 
                {
                     if (ds_map_exists(variableStore, paramValue)) 
                     {
                        loopCount = variableStore[? paramValue];
                     } 
                     else 
                     {
                        show_message(string_concat("Error: Variable '", paramValue, "' not found for Repeat."));
                        StopInterpreter();
                        return;
                     }
                } 
                else if (paramType == "result") 
                {
                    if (lastResult != undefined) 
                    {
                        loopCount = lastResult;
                    } 
                    else 
                    {
                        show_message("Warning: Repeat using [result] but last result undefined. Repeating 0 times.");
                        loopCount = 0;
                    }
                } 
                else 
                {
                    show_message(string_concat("Error: Unknown param type in RepeatStart: ", paramType));
                    StopInterpreter();
                    return;
                }
            } 
            else 
            {
                show_message(string_concat("Error: Malformed param part in RepeatStart: ", paramPart));
                StopInterpreter();
                return;
            }

            loopCount = max(0, floor(loopCount));
            if (loopCount <= 0) 
            {
                currentIndex += jumpOffset;
                show_message(string_concat("Repeat count is ", string(loopCount), ", skipping loop block."));
            } 
            else 
            {
                // TODO: Subtract memory cost for entering/managing a loop (optional)
                array_push(loopStack, { remaining_count: loopCount, loop_body_start_index: currentIndex + 1 });
                show_message(string_concat("Starting Repeat block, count = ", string(loopCount)));
            }
        } 
        else 
        {
            show_message(string_concat("Error: Malformed RepeatStart: ", _instr));
            StopInterpreter();
        }
        return;
    }

    // --- Handle RepeatEnd ---
    if (string_starts_with(_instr, "RepeatEnd(")) 
    {
        if (array_length(loopStack) == 0) 
        {
            show_message("Error: RepeatEnd encountered without active loop on stack.");
            StopInterpreter();
            return;
        }
        var content = string_copy(_instr, 11, string_length(_instr) - 11 - 1);
        var jumpOffsetStr = string_copy(content, 13, string_length(content) - 12);
        var jumpBackOffset = real(jumpOffsetStr);
        var currentLoop = loopStack[array_length(loopStack) - 1];
        currentLoop.remaining_count -= 1;
        if (currentLoop.remaining_count > 0) 
        {
            currentIndex -= jumpBackOffset;
            show_message(string_concat("Repeating loop, ", string(currentLoop.remaining_count), " remaining."));
            // TODO: Subtract memory cost for each loop iteration (optional)
        } 
        else 
        {
            array_pop(loopStack);
            show_message("Finished Repeat block.");
            // TODO: Add back memory cost for managing loop if subtracted in RepeatStart (optional)
        }
        return;
    }

    // --- Handle Regular Commands ---
    var openParen = string_pos("(", _instr);
    var commandName = "";
    var paramString = "";

    if (openParen > 0) 
    {
        var closeParen = string_last_pos(")", _instr);
        if (closeParen > openParen) 
        {
            commandName = string_lower(string_copy(_instr, 1, openParen - 1));
            paramString = string_copy(_instr, openParen + 1, closeParen - openParen - 1);
        } 
        else 
        {
            show_message(string_concat("Error: Mismatched parentheses: ", _instr));
            StopInterpreter();
            return;
        }
    } 
    else 
    {
        commandName = string_lower(_instr);
        paramString = "";
    }

    if (commandName == "") 
    {
        show_message("Error: Empty command name encountered.");
        StopInterpreter();
        return;
    }
    if (global.vars.CommandLibrary[$ commandName] == undefined) 
    {
        show_message(string_concat("Error: Command '", commandName, "' not found."));
        StopInterpreter();
        return;
    }

    var command = global.vars.CommandLibrary[$ commandName];
    var actualParamValue = undefined;

    if (paramString == "[result]") 
    {
        actualParamValue = lastResult;
        if (actualParamValue == undefined) 
        {
            show_message(string_concat("Warning: Using [result] for '", commandName, "' but undefined."));
        }
    } 
    else if (string_starts_with(paramString, "lookup:")) 
    {
        var varName = string_copy(paramString, 8, string_length(paramString) - 7);
        if (ds_map_exists(variableStore, varName)) 
        {
            actualParamValue = variableStore[? varName];
        } 
        else 
        {
            show_message(string_concat("Error: Variable '", varName, "' not found."));
            StopInterpreter();
            return;
        }
    } 
    else if (string_starts_with(paramString, "string:")) 
    {
        actualParamValue = string_copy(paramString, 8, string_length(paramString) - 7);
    } 
    else if (string_digits(paramString) == paramString && paramString != "") 
    {
        actualParamValue = real(paramString);
    } 
    else if (paramString == "") 
    {
        actualParamValue = 0; // Default parameter value if none provided
    } 
    else 
    {
        show_message(string_concat("Error: Unknown param format '", paramString, "'."));
        StopInterpreter();
        return;
    }

    try
    {
        // TODO: Subtract memory cost BEFORE executing the command based on command.Cost
        var returnVal = command.CallBackFunc(actualParamValue);
        if (variable_struct_exists(command, "ReturnsValue") && command.ReturnsValue)
        {
            lastResult = returnVal;
            show_message(string_concat("'", commandName, "' returned: ", string(lastResult)));
        }
    }
    catch (_exception)
    {
        var errorLineInfo = (currentRawLine != -1)
            ? string_concat("(Raw Line: ", string(currentRawLine), ")")
            : "";
        show_message(string_concat("RUNTIME ERROR in '", commandName, "' ", errorLineInfo, ":\n", _exception.message));
        StopInterpreter();
    }
}
