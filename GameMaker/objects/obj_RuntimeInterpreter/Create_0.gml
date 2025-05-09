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
lastConditionResult = false; // For if statements (used by EvalCond)
operandStack = []; // For mathematical expressions



// --- Functions ---

/// @function            StartInterpreter(_compiledStruct)
function StartInterpreter(_compiledStruct) {
    if (_compiledStruct == undefined || (variable_struct_exists(_compiledStruct, "Errors") && _compiledStruct.Errors != undefined)) {
        var errorMsg = "Interpreter Error: Cannot start with invalid code.";
        if (variable_struct_exists(_compiledStruct, "Errors") && _compiledStruct.Errors != undefined && array_length(_compiledStruct.Errors) > 0) {
            errorMsg = string_concat(errorMsg, "\nFirst Error: ", _compiledStruct.Errors[0]);
        }
        show_message(errorMsg);
        isRunning = false;
        return;
    }
    compiledInstructions = _compiledStruct.CompiledArray;
    lineMapping = _compiledStruct.LineMapping;
    currentIndex = 0;
    lastResult = undefined;
    currentRawLine = -1;
    lastConditionResult = false;
    ds_map_clear(variableStore);
    loopStack = [];
    operandStack = [];
    isRunning = true;
    alarm[0] = tickDelay;
    show_debug_message("Interpreter started.");
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
    operandStack = [];
    show_debug_message("Interpreter stopped.");
}

/// @function            ExecuteInstruction(_instr)
function ExecuteInstruction(_instr) {
    if (_instr == "" || _instr == undefined) {
        return;
    }
    show_debug_message(string_concat("Executing: ", _instr));

    // --- Math Operand Stack Instructions ---
    if (string_starts_with(_instr, "PushNum(")) {
        var valStr = string_copy(_instr, 9, string_length(_instr) - 9 -1);
        array_push(operandStack, real(valStr));
        show_debug_message(string_concat("Pushed number: ", valStr));
        return;
    }
    if (string_starts_with(_instr, "PushVar(")) {
        var varName = string_copy(_instr, 9, string_length(_instr) - 9 -1);
        if (ds_map_exists(variableStore, varName)) {
            array_push(operandStack, variableStore[? varName]);
            show_debug_message(string_concat("Pushed var '", varName, "': ", string(variableStore[? varName])));
        } else {
            show_debug_message(string_concat("Error: Variable '", varName, "' not found for PushVar."));
            StopInterpreter();
        }
        return;
    }
    if (_instr == "PushResult") {
        if (lastResult != undefined) {
            array_push(operandStack, lastResult);
            show_debug_message(string_concat("Pushed lastResult: ", string(lastResult)));
        } else {
            show_debug_message("Warning: PushResult called but lastResult is undefined. Pushing 0.");
            array_push(operandStack, 0);
        }
        return;
    }
    var PerformOperation = function(op_func) {
        if (array_length(operandStack) < 2) {
            show_debug_message("Error: Not enough operands on stack for operation.");
            StopInterpreter();
            return false;
        }
        var b = array_pop(operandStack);
        var a = array_pop(operandStack);
        if (!is_real(a) || !is_real(b)) {
            show_debug_message(string_concat("Error: Operands for math operation are not numbers (",string(a),", ",string(b),")."));
            StopInterpreter();
            return false;
        }
        array_push(operandStack, op_func(a, b));
        show_debug_message(string_concat("Performed operation, result: ", string(operandStack[array_length(operandStack)-1])));
        return true;
    }
    if (_instr == "OpAdd") {
        if (!PerformOperation(function(a,b){return a+b;})) {
            return;
        }
        return;
    }
    if (_instr == "OpSubtract") {
        if (!PerformOperation(function(a,b){return a-b;})) {
            return;
        }
        return;
    }
    if (_instr == "OpMultiply") {
        if (!PerformOperation(function(a,b){return a*b;})) {
            return;
        }
        return;
    }
    if (_instr == "OpDivide") {
        if (array_length(operandStack) < 2) {
            show_debug_message("Error: Not enough operands for Divide.");
            StopInterpreter();
            return;
        }
        var b_val = operandStack[array_length(operandStack)-1];
        if (!is_real(b_val) || b_val == 0) {
            show_debug_message(string_concat("Error: Division by zero or non-numeric divisor (", string(b_val), ")."));
            StopInterpreter();
            return;
        }
        if (!PerformOperation(function(a,b){return a/b;})) {
            return;
        }
        return;
    }
    if (string_starts_with(_instr, "AssignFromStack(")) {
        if (array_length(operandStack) < 1) {
            show_debug_message("Error: Operand stack empty for AssignFromStack.");
            StopInterpreter();
            return;
        }
        var varName = string_copy(_instr, 17, string_length(_instr) - 17 -1);
        var value = array_pop(operandStack);
        variableStore[? varName] = value;
        show_debug_message(string_concat("Assigned '", varName, "' = ", string(value), " from operand stack."));
        return;
    }

    if (string_starts_with(_instr, "DeclareVar(")) {
        var content = string_copy(_instr, 12, string_length(_instr) - 12);
        var commaPos = string_pos(",", content);
        if (commaPos > 0) {
            var varName = string_copy(content, 1, commaPos - 1);
            var varValueStr = string_copy(content, commaPos + 1, string_length(content) - commaPos);
            variableStore[? varName] = real(varValueStr);
            show_debug_message(string_concat("Declared '", varName, "' = ", string(variableStore[? varName])));
        } else {
            show_debug_message(string_concat("Error: Malformed DeclareVar: ", _instr));
            StopInterpreter();
        }
        return;
    }

    if (string_starts_with(_instr, "AssignVar(")) {
         var content = string_copy(_instr, 11, string_length(_instr) - 11);
         var commaPos = string_pos(",", content);
         if (commaPos > 0) {
             var varName = string_copy(content, 1, commaPos - 1);
             var valueSource = string_copy(content, commaPos + 1, string_length(content) - commaPos -1);
             if (valueSource == "[result]") {
                 if (lastResult != undefined) {
                     variableStore[? varName] = lastResult;
                     show_debug_message(string_concat("Assigned '", varName, "' = ", string(lastResult), " from [result]"));
                 } else {
                     show_debug_message(string_concat("Warning: AssignVar '", varName,"' [result] undefined."));
                 }
             } else {
                 show_debug_message(string_concat("Error: Malformed AssignVar instruction. Expected '[result]' as source: ", _instr));
                 StopInterpreter();
             }
         } else {
             show_debug_message(string_concat("Error: Malformed AssignVar instruction: ", _instr));
             StopInterpreter();
         }
         return;
    }

    if (string_starts_with(_instr, "EvalCond(")) {
        var content = string_copy(_instr, 10, string_length(_instr) - 10 -1);
        var parts = string_split(content, ",");
        if (array_length(parts) == 3) {
            var op1_part = parts[0];
            var operator = parts[1];
            var op2_part = parts[2];
            var op1_val, op2_val;
            var GetOperandValue = function(_opStr) {
                var colonPos = string_pos(":", _opStr);
                if (colonPos <= 0) {
                    show_debug_message(string_concat("Error: Malformed operand in EvalCond: ", _opStr));
                    StopInterpreter();
                    return undefined;
                }
                var type = string_copy(_opStr, 1, colonPos - 1);
                var val = string_copy(_opStr, colonPos + 1, string_length(_opStr) - colonPos);
                if (type == "number") {
                    return real(val);
                }
                if (type == "lookup") {
                    if (ds_map_exists(variableStore, val)) {
                        return variableStore[? val];
                    } else {
                        show_debug_message(string_concat("Error: Var '", val, "' not found in EvalCond."));
                        StopInterpreter();
                        return undefined;
                    }
                }
                if (type == "result") {
                    if (lastResult != undefined) {
                        return lastResult;
                    } else {
                        show_debug_message("Warning: EvalCond using [result] but undefined.");
                        return 0;
                    }
                }
                show_debug_message(string_concat("Error: Unknown operand type '", type, "' in EvalCond."));
                StopInterpreter();
                return undefined;
            };
            op1_val = GetOperandValue(op1_part);
            if (op1_val == undefined && isRunning) {
                return;
            }
            op2_val = GetOperandValue(op2_part);
            if (op2_val == undefined && isRunning) {
                return;
            }

            lastConditionResult = false;
            if (operator == "==") {
                lastConditionResult = (op1_val == op2_val);
            } else if (operator == "!=") {
                lastConditionResult = (op1_val != op2_val);
            } else if (operator == ">") {
                lastConditionResult = (op1_val > op2_val);
            } else if (operator == "<") {
                lastConditionResult = (op1_val < op2_val);
            } else if (operator == ">=") {
                lastConditionResult = (op1_val >= op2_val);
            } else if (operator == "<=") {
                lastConditionResult = (op1_val <= op2_val);
            } else {
                show_debug_message(string_concat("Error: Unknown operator '", operator, "' in EvalCond."));
                StopInterpreter();
                return;
            }
            show_debug_message(string_concat("EvalCond: ", op1_part, " ", operator, " ", op2_part, " -> ", string(lastConditionResult)));
        } else {
            show_debug_message(string_concat("Error: Malformed EvalCond: ", _instr));
            StopInterpreter();
        }
        return;
    }

    if (string_starts_with(_instr, "JumpFalse(")) {
        var offsetStr = string_copy(_instr, 11, string_length(_instr) - 11 -1);
        var offset = real(offsetStr);
        if (!lastConditionResult) {
            currentIndex += offset;
            show_debug_message(string_concat("JumpFalse: Condition false, jumping by ", string(offset)));
            currentIndex -=1;
        } else {
            show_debug_message("JumpFalse: Condition true, no jump.");
        }
        return;
    }

    if (string_starts_with(_instr, "JumpFalseFromStack(")) {
        if (array_length(operandStack) < 1) {
            show_debug_message("Error: Operand stack empty for JumpFalseFromStack.");
            StopInterpreter();
            return;
        }
        var conditionValue = array_pop(operandStack);
        var conditionIsFalse = false;
        if (is_real(conditionValue)) {
            conditionIsFalse = (conditionValue == 0);
        } else if (is_bool(conditionValue)) {
            conditionIsFalse = !conditionValue;
        } else {
            show_debug_message(string_concat("Error: Non-boolean/numeric value popped for JumpFalseFromStack: ", string(conditionValue)));
            StopInterpreter();
            return;
        }

        var offsetStr = string_copy(_instr, 20, string_length(_instr) - 20 -1);
        var offset = real(offsetStr);
        if (conditionIsFalse) {
            currentIndex += offset;
            show_debug_message(string_concat("JumpFalseFromStack: Condition was false, jumping by ", string(offset)));
            currentIndex -=1;
        } else {
            show_debug_message("JumpFalseFromStack: Condition was true, no jump.");
        }
        return;
    }

    if (string_starts_with(_instr, "Jump(")) {
        var offsetStr = string_copy(_instr, 6, string_length(_instr) - 6 -1);
        var offset = real(offsetStr);
        currentIndex += offset;
        show_debug_message(string_concat("Jump: Unconditional by ", string(offset)));
        currentIndex -=1;
        return;
    }

    if (string_starts_with(_instr, "RepeatStart(")) {
        var content = string_copy(_instr, 13, string_length(_instr) - 13 - 1);
        var commaPos = string_pos(",", content);
        var jumpOffsetPos = string_pos("jump_offset:", content);
        if (commaPos > 0 && jumpOffsetPos > commaPos) {
            var paramPart = string_copy(content, 1, commaPos - 1);
            var jumpOffsetStr = string_copy(content, jumpOffsetPos + 12, string_length(content) - (jumpOffsetPos + 11));
            var jumpOffset = real(jumpOffsetStr);
            var loopCount = 0;
            var colonPos = string_pos(":", paramPart);
            if (colonPos > 0) {
                var paramType = string_copy(paramPart, 1, colonPos - 1);
                var paramValue = string_copy(paramPart, colonPos + 1, string_length(paramPart) - colonPos);
                if (paramType == "number") {
                    loopCount = real(paramValue);
                } else if (paramType == "lookup") {
                    if (ds_map_exists(variableStore, paramValue)) {
                        loopCount = variableStore[? paramValue];
                    } else {
                        show_debug_message(string_concat("Error: Var '", paramValue, "' not found for Repeat."));
                        StopInterpreter();
                        return;
                    }
                } else if (paramType == "result") {
                    if (lastResult != undefined) {
                        loopCount = lastResult;
                    } else {
                        show_debug_message("Warning: Repeat using [result] but undefined. Repeating 0x.");
                        loopCount = 0;
                    }
                } else if (paramType == "expr_result") {
                    if (array_length(operandStack) > 0) {
                        loopCount = array_pop(operandStack);
                    } else {
                        show_debug_message("Error: Operand stack empty for RepeatStart(expr_result).");
                        StopInterpreter();
                        return;
                    }
                } else {
                    show_debug_message(string_concat("Error: Unknown param type in RepeatStart: ", paramType));
                    StopInterpreter();
                    return;
                }
            } else {
                show_debug_message(string_concat("Error: Malformed param part in RepeatStart: ", paramPart));
                StopInterpreter();
                return;
            }
            loopCount = max(0, floor(loopCount));
            if (!is_real(loopCount)) {
                show_debug_message(string_concat("Error: Loop count for Repeat is not a number: ", string(loopCount)));
                StopInterpreter();
                return;
            }

            if (loopCount <= 0) {
                currentIndex += jumpOffset;
                currentIndex -=1;
                show_debug_message(string_concat("Repeat count ", string(loopCount), ", skipping."));
            } else {
                array_push(loopStack, { remaining_count: loopCount, loop_body_start_index: currentIndex + 1 });
                show_debug_message(string_concat("Starting Repeat, count = ", string(loopCount)));
            }
        } else {
            show_debug_message(string_concat("Error: Malformed RepeatStart: ", _instr));
            StopInterpreter();
        }
        return;
    }

    if (string_starts_with(_instr, "RepeatEnd(")) {
        if (array_length(loopStack) == 0) {
            show_debug_message("Error: RepeatEnd no active loop.");
            StopInterpreter();
            return;
        }
        var content = string_copy(_instr, 11, string_length(_instr) - 11 - 1);
        var jumpOffsetStr = string_copy(content, 13, string_length(content) - 12);
        var jumpBackOffset = real(jumpOffsetStr);
        var currentLoop = loopStack[array_length(loopStack) - 1];
        currentLoop.remaining_count -= 1;
        if (currentLoop.remaining_count > 0) {
            currentIndex -= jumpBackOffset;
            currentIndex -=1;
            show_debug_message(string_concat("Repeating, ", string(currentLoop.remaining_count), " left."));
        } else {
            array_pop(loopStack);
            show_debug_message("Finished Repeat.");
        }
        return;
    }

    var openParen = string_pos("(", _instr);
    var commandName = "";
    var paramString = "";

    if (openParen > 0) {
        var closeParen = string_last_pos(")", _instr);
        if (closeParen > openParen) {
            commandName = string_lower(string_copy(_instr, 1, openParen - 1));
            paramString = string_copy(_instr, openParen + 1, closeParen - openParen - 1);
        } else {
            show_debug_message(string_concat("Error: Mismatched parens: ", _instr));
            StopInterpreter();
            return;
        }
    } else {
        commandName = string_lower(_instr);
        paramString = "";
    }

    if (commandName == "") {
        show_debug_message("Error: Empty command name.");
        StopInterpreter();
        return;
    }
    if (global.vars.CommandLibrary[$ commandName] == undefined) {
        show_debug_message(string_concat("Error: Command '", commandName, "' not found."));
        StopInterpreter();
        return;
    }

    var command = global.vars.CommandLibrary[$ commandName];
    var actualParamValue = undefined;

    if (paramString == "[result]") {
        actualParamValue = lastResult;
        if (actualParamValue == undefined) {
            show_debug_message(string_concat("Warning: Using [result] for '", commandName, "' but undefined."));
        }
    } else if (paramString == "[expr_result]") {
        if (array_length(operandStack) > 0) {
            actualParamValue = array_pop(operandStack);
            show_debug_message(string_concat("Using expression result for '", commandName, "': ", string(actualParamValue)));
        } else {
            show_debug_message(string_concat("Error: Operand stack empty for '", commandName, "'([expr_result])."));
            StopInterpreter();
            return;
        }
    } else if (string_starts_with(paramString, "lookup:")) {
        var varName = string_copy(paramString, 8, string_length(paramString) - 7);
        if (ds_map_exists(variableStore, varName)) {
            actualParamValue = variableStore[? varName];
        } else {
            show_debug_message(string_concat("Error: Var '", varName, "' not found."));
            StopInterpreter();
            return;
        }
    } else if (string_starts_with(paramString, "string:")) {
        actualParamValue = string_copy(paramString, 8, string_length(paramString) - 7);
    } else if (string_digits(paramString) == paramString && paramString != "") {
        actualParamValue = real(paramString);
    } else if (paramString == "") {
        actualParamValue = 0;
    } else {
        show_debug_message(string_concat("Error: Unknown param format '", paramString, "'."));
        StopInterpreter();
        return;
    }

    try {
        // TODO: Mem Cost Command
        var returnVal = command.CallBackFunc(actualParamValue);
        if (variable_struct_exists(command, "ReturnsValue") && command.ReturnsValue) {
            lastResult = returnVal;
            show_debug_message(string_concat("'", commandName, "' returned: ", string(lastResult)));
        }
    } catch (_exception) {
        var errorLineInfo = (currentRawLine != -1) ? string_concat("(Raw Line: ", string(currentRawLine), ")") : "";
        show_message(string_concat("RUNTIME ERROR in '", commandName, "' ", errorLineInfo, ":\n", _exception.message));
        StopInterpreter();
    }
}
