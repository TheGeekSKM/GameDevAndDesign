/// @function                CompileCode(_code)
/// @description             Compiles raw script code into executable instructions and metadata.
/// @param {String} _code The raw script code to compile.
/// @returns {Struct}        Struct containing { FunctionName, CompiledArray, LineMapping, Cost, Errors (optional) }

function CompileCode(_code) {

    // Initial validation
    if (_code == "" || string_trim(_code) == "") // Trim check for whitespace-only code
    {
        // Return error struct immediately if code is empty
        return { Errors: ["No code is present."] };
    }

    var compiledInstructions = [];
    var memoryCost = 0;
    var instructionToRawLineMap = [];
    var errors = []; // Store compilation errors

    var lines = string_split(string_replace_all(_code, "\r\n", "\n"), "\n"); // Normalize newlines
    var blockStack = []; // Tracks nested blocks ({}) for Repeat/Function

    var insideFunction = false;
    var functionName = "Main"; // Default function name

    /// @function _is_valid_identifier(_name)
    /// @description Internal helper to check identifier validity
    var _is_valid_identifier = function(_name) {
        if (_name == "") return false;
        var _firstChar = string_char_at(_name, 1);
        if (!((_firstChar >= "a" && _firstChar <= "z") || (_firstChar >= "A" && _firstChar <= "Z") || _firstChar == "_")) {
            return false;
        }
        if (string_length(_name) > 1) {
            var _rest = string_copy(_name, 2, string_length(_name) - 1);
            for (var _c = 1; _c <= string_length(_rest); _c++) {
                var _char = string_char_at(_rest, _c);
                if (!((_char >= "a" && _char <= "z") || (_char >= "A" && _char <= "Z") || (_char >= "0" && _char <= "9") || _char == "_")) {
                    return false;
                }
            }
        }
        return true;
    };


    for (var i = 0; i < array_length(lines); i++)
    {
        var rawLineNumber = i + 1;
        var line = string_trim(lines[i]);

        // Skip empty lines and comments
        if (line == "" || string_starts_with(line, "//")) continue;

        // --- Function Definition ---
        if (string_starts_with(line, "function"))
        {
            if (insideFunction)
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Cannot define function inside another function."));
                continue;
            }
            var nameStart = string_pos("function ", line) + 9;
            var parenPos = string_pos("(", line);
            if (nameStart > 9 && parenPos > nameStart)
            {
                functionName = string_trim(string_copy(line, nameStart, parenPos - nameStart));
                if (functionName == "") array_push(errors, string_concat("Line ", string(rawLineNumber), ": Function name cannot be empty."));
                // Validate function name using helper
                else if (!_is_valid_identifier(functionName)) {
                    array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid function name '", functionName, "'."));
                }
            }
            else
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid function definition syntax."));
                functionName = "InvalidFunction"; // Mark as invalid but continue parsing if possible
            }
            insideFunction = true;
            array_push(blockStack, { type: "function", startInstructionIndex: array_length(compiledInstructions), rawLineNumber: rawLineNumber });
            continue;
        }

        // --- Block Handling ({ and }) ---
        if (line == "{")
        {
            if (array_length(blockStack) == 0)
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected opening brace '{{'."));
                continue;
            }
            // Mark the last block as having its opening brace found.
            var _topBlock = array_last(blockStack);
            if (is_struct(_topBlock)) { // Safety check
                _topBlock.hasOpenedBrace = true;
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Internal Compiler Error: Block stack malformed when processing '{{'."));
            }
            continue;
        }
        if (line == "}")
        {
            if (array_length(blockStack) == 0) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected closing brace '}}'."));
                continue;
            }

            var closingBlock = array_pop(blockStack);

            if (!is_struct(closingBlock) || !variable_struct_exists(closingBlock, "hasOpenedBrace") || !closingBlock.hasOpenedBrace)
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Closing brace '}}' does not match an opened block (e.g., missing '{{' after Repeat or function)."));
                continue;
            }

            if (closingBlock.type == "repeat")
            {
                // --- Compile RepeatEnd and Patch Jumps ---
                var repeatStartIndex = closingBlock.startInstructionIndex;
                // Jump back to the instruction *after* RepeatStart
                var jumpBackOffset = array_length(compiledInstructions) - repeatStartIndex;
                var repeatEndInstruction = string_concat("RepeatEnd(jump_offset:", string(jumpBackOffset), ")"); // Use string_concat
                array_push(compiledInstructions, repeatEndInstruction);
                array_push(instructionToRawLineMap, rawLineNumber); // Map '}' to RepeatEnd

                // Patch the corresponding RepeatStart instruction
                var jumpForwardOffset = array_length(compiledInstructions) - 1 - repeatStartIndex; // Jump past RepeatEnd
                var repeatStartInstr = compiledInstructions[repeatStartIndex];
                var jumpPlaceholderPos = string_pos(",jump_offset:-1", repeatStartInstr);
                if (jumpPlaceholderPos > 0)
                {
                    var instructionBase = string_copy(repeatStartInstr, 1, jumpPlaceholderPos); // Includes comma
                    compiledInstructions[repeatStartIndex] = string_concat(instructionBase, "jump_offset:", string(jumpForwardOffset), ")"); // Use string_concat
                }
                else { array_push(errors, string_concat("Line ", string(closingBlock.rawLineNumber), ": Internal Compiler Error: Could not patch RepeatStart jump offset.")); }
            }
            else if (closingBlock.type == "function")
            {
                insideFunction = false;
                // Add implicit Return at the end of a function block
                array_push(compiledInstructions, "Return");
                array_push(instructionToRawLineMap, rawLineNumber);
            }
            else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Closing brace '}}' for an unexpected block type '", closingBlock.type, "'.")); } // Use string_concat
            continue;
        }

        // --- Repeat Block Start ---
        if (string_starts_with(line, "Repeat("))
        {
            var openParen = string_pos("(", line);
            var closeParen = string_last_pos(")", line);
            var repeatParam = "";
            var repeatParamType = "invalid";
            var compiledRepeatStart = "";

            if (openParen > 0 && closeParen > openParen)
            {
                repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));

                if (string_digits(repeatParam) == repeatParam && repeatParam != "") { // Number check
                    if (real(repeatParam) > 0) {
                        repeatParamType = "number";
                        compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":", repeatParam, ",jump_offset:-1)"); // Use string_concat
                    } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Repeat amount must be positive. Found '", repeatParam, "'.")); } // Use string_concat
                } else {
                    var paramOpenParen = string_pos("(", repeatParam);
                    if (paramOpenParen > 0 && string_ends_with(repeatParam, ")")) { // Nested call check
                        var innerCommandName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                        // Validate inner command name format using helper
                        if (innerCommandName != "" && _is_valid_identifier(innerCommandName)) {
                            // Compile inner call first
                            array_push(compiledInstructions, repeatParam); // Assume inner call is valid instruction format
                            array_push(instructionToRawLineMap, rawLineNumber);
                            memoryCost += GetInstructionMemoryCost(repeatParam); // Add cost of inner call
                            // Then compile RepeatStart using the result
                            repeatParamType = "result";
                            compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":[result],jump_offset:-1)"); // Use string_concat
                        } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call syntax in Repeat parameter '", repeatParam, "'.")); } // Use string_concat
                    }
                    // Variable name check using helper
                    else if (repeatParam != "" && _is_valid_identifier(repeatParam)) {
                        repeatParamType = "lookup";
                        compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":", repeatParam, ",jump_offset:-1)"); // Use string_concat
                    } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid parameter '", repeatParam, "' for Repeat. Expected positive number, variable, or nested call.")); } // Use string_concat
                }
            } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid Repeat syntax. Expected Repeat(Param).")); } // Use string_concat

            if (compiledRepeatStart != "") {
                var repeatStartIndex = array_length(compiledInstructions);
                array_push(compiledInstructions, compiledRepeatStart);
                array_push(instructionToRawLineMap, rawLineNumber);
                array_push(blockStack, { type: "repeat", startInstructionIndex: repeatStartIndex, rawLineNumber: rawLineNumber });
            }
            continue;
        }


        // --- Variable Declaration ---
        if (string_starts_with(line, "var "))
        {
            var eqPos = string_pos("=", line);
            if (eqPos > 0) {
                var declarationPart = string_trim(string_copy(line, 1, eqPos - 1));
                var valuePart = string_trim(string_replace(string_copy(line, eqPos + 1, string_length(line) - eqPos), ";", "")); // Get part after '=' and remove trailing ';'

                if (string_starts_with(declarationPart, "var ")) {
                    var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));

                    // Validate variable name using helper
                    if (_is_valid_identifier(varName))
                    {
                        // Check if valuePart is a number
                        if (string_digits(valuePart) == valuePart && valuePart != "")
                        {
                            var compiledLine = string_concat("DeclareVar(", varName, ",", valuePart, ")"); // Use string_concat
                            array_push(compiledInstructions, compiledLine);
                            array_push(instructionToRawLineMap, rawLineNumber);
                            memoryCost += 1; // Cost for declaring var with literal
                        }
                        // Check if valuePart looks like a function call
                        else if (string_pos("(", valuePart) > 0 && string_ends_with(valuePart, ")"))
                        {
                            // It's a function call assignment
                            // 1. Compile the function call itself
                            array_push(compiledInstructions, valuePart);
                            array_push(instructionToRawLineMap, rawLineNumber); // Map function call to this line
                            memoryCost += GetInstructionMemoryCost(valuePart); // Add cost of the function call

                            // 2. Compile the assignment instruction
                            var assignInstruction = string_concat("AssignVarFromLastResult(", varName, ")"); // Use string_concat
                            array_push(compiledInstructions, assignInstruction);
                            array_push(instructionToRawLineMap, rawLineNumber); // Map assignment also to this line
                            memoryCost += 1; // Add cost for the assignment itself
                        }
                        // Invalid assignment value
                        else
                        {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Variable '", varName, "' can only be initialized with a numeric value or function call. Found '", valuePart, "'.")); // Use string_concat
                        }
                    } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable name '", varName, "'.")); } // Use string_concat
                } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable declaration syntax near 'var'.")); } // Use string_concat
            } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable declaration syntax. Expected 'var name = value;'. Missing '='.")); } // Use string_concat
            continue; // Done processing var line
        }


        // --- Normal Instruction / Command ---
        var openParen = string_pos("(", line);
        var command = "";
        var param = "";
        var compiledLine = "";

        if (openParen > 0) { // Command with potential parameters
            var closeParen = string_last_pos(")", line);
            if (closeParen > openParen) {
                command = string_trim(string_copy(line, 1, openParen - 1));
                param = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
                if (command == "") { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Missing command name.")); continue; } // Use string_concat
                // Validate command name format using helper
                if (!_is_valid_identifier(command)) { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid command name '", command, "'.")); continue; } // Use string_concat


                // Parameter Type Parsing
                if (param == "") { compiledLine = string_concat(command, "()"); } // Use string_concat
                else if (string_digits(param) == param) { compiledLine = string_concat(command, "(", param, ")"); } // Use string_concat
                else if (string_starts_with(param, "\"") && string_ends_with(param, "\"")) { // String literal
                    var stringValue = string_copy(param, 2, string_length(param) - 2);
                    if (string_pos("\"", stringValue) == 0) { // Ensure no quotes inside
                        compiledLine = string_concat(command, "(string:", stringValue, ")"); // Use string_concat
                        memoryCost += string_length(stringValue); // Add string length to cost
                    } else {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": String parameters cannot contain double quotes. Found in '", param, "'.")); // Use string_concat
                        compiledLine = string_concat(command, "(invalid_param)"); // Use string_concat
                    }
                } else {
                    var paramOpenParen = string_pos("(", param);
                    if (paramOpenParen > 0 && string_ends_with(param, ")")) { // Nested call
                        var innerCommandName = string_trim(string_copy(param, 1, paramOpenParen - 1));
                        // Validate inner command name format using helper
                        if (innerCommandName != "" && _is_valid_identifier(innerCommandName)) {
                            // Compile Inner() first
                            array_push(compiledInstructions, param); array_push(instructionToRawLineMap, rawLineNumber); memoryCost += GetInstructionMemoryCost(param);
                            // Then compile Outer([result])
                            compiledLine = string_concat(command, "([result])"); // Use string_concat
                        } else {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call syntax in parameter '", param, "'. Inner command name looks invalid.")); // Use string_concat
                            compiledLine = string_concat(command, "(invalid_param)"); // Use string_concat
                        }
                    }
                    // Variable lookup using helper
                    else if (param != "" && _is_valid_identifier(param)) {
                        compiledLine = string_concat(command, "(lookup:", param, ")"); // Use string_concat
                    }
                    // Invalid parameter
                    else {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid parameter format '", param, "' for command '", command, "'. Expected number, string literal, nested call, or variable name.")); // Use string_concat
                        compiledLine = string_concat(command, "(invalid_param)"); // Use string_concat
                    }
                }
            } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Mismatched or missing closing parenthesis for command '", string_copy(line, 1, openParen-1) ,"'.")); continue; } // Use string_concat
        } else { // Simple command with no parentheses
            command = string_trim(line);
            if (command == "") continue; // Skip if trimming resulted in empty string
            // Validate command name format using helper
            if (_is_valid_identifier(command)) { compiledLine = command; }
            else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid command name '", command, "'.")); continue; } // Use string_concat
        }

        // Add the compiled line to the list
        if (compiledLine != "" && !string_ends_with(compiledLine, "(invalid_param)"))
        {
            array_push(compiledInstructions, compiledLine);
            array_push(instructionToRawLineMap, rawLineNumber);
            // Add cost, excluding the [result] placeholder itself
            if (!string_ends_with(compiledLine, "([result])")) {
                memoryCost += GetInstructionMemoryCost(compiledLine);
            } else {
                // The cost of the inner function was already added, add 1 for the outer call wrapper
                memoryCost += 1;
            }
        }
    } // End of line loop

    // Check for unclosed blocks
    while (array_length(blockStack) > 0)
    {
        var unclosedBlock = array_pop(blockStack); // Pop to report all unclosed blocks
        if (is_struct(unclosedBlock)) {
            array_push(errors, string_concat("Compilation Error: Unclosed '", unclosedBlock.type, "' block starting near line ", string(unclosedBlock.rawLineNumber), ". Missing '}}'.")); // Use string_concat
        } else {
            array_push(errors, "Compilation Error: Malformed block stack detected at end of compilation."); // Should not happen
        }
    }


    if (array_length(errors) > 0)
    {
        return { Errors: errors }; // Return only errors if compilation failed
    }
    else
    {
        // Success
        return {
            FunctionName: functionName,
            CompiledArray: compiledInstructions,
            LineMapping: instructionToRawLineMap,
            Cost: memoryCost,
            Errors: undefined, // Indicate success
            RawCode: _code,    // Include original code for reference if needed
        };
    }
}


/// @function                GetInstructionMemoryCost(instruction)
/// @description             Calculates the estimated memory cost of a single compiled instruction.
/// @param {String} instruction The compiled instruction string.
/// @returns {Number}        The estimated memory cost, or -1 if unrecognized.
function GetInstructionMemoryCost(instruction) {
    // Extract base command name (part before '(' if it exists)
    var commandName = instruction;
    var parenPos = string_pos("(", instruction);
    if (parenPos > 0) {
        commandName = string_copy(instruction, 1, parenPos - 1);
    }
    commandName = string_lower(string_trim(commandName)); // Lowercase for lookup

    var cost = 0;

    // Check Command Library
    if (variable_global_exists("vars") && is_struct(global.vars) && variable_struct_exists(global.vars, "CommandLibrary") && is_struct(global.vars.CommandLibrary))
    {
        // Case-insensitive check against command library keys
        var _cmdLibKeys = variable_struct_get_names(global.vars.CommandLibrary);
        for (var k = 0; k < array_length(_cmdLibKeys); k++) {
            if (commandName == string_lower(_cmdLibKeys[k])) {
                // Access cost using the original key casing stored in _cmdLibKeys[k]
                // Ensure the entry itself is a struct with a 'Cost' key
                var _commandEntry = global.vars.CommandLibrary[$ _cmdLibKeys[k]];
                if (is_struct(_commandEntry) && variable_struct_exists(_commandEntry, "Cost")) {
                    cost = _commandEntry.Cost;
                    return cost; // Found in library, return cost
                } else {
                    // Command exists but lacks Cost struct/key - treat as error or default?
                    show_debug_message(string_concat("Warning: Command '", _cmdLibKeys[k], "' found in CommandLibrary but missing expected Cost struct/key.")); // Use string_concat
                    return 1; // Default cost? Or -1 for error? Let's default to 1.
                }
            }
        }
    }

    // Check built-in compiler instructions
    if (commandName == "declarevar") { cost = 1; }
    else if (commandName == "assignvarfromlastresult") { cost = 1; } // Cost for the assignment step
    else if (commandName == "repeatstart") { cost = 1; } // Cost for the start instruction
    else if (commandName == "repeatend") { cost = 1; } // Cost for the end/jump instruction
    else if (commandName == "return") { cost = 1; } // Cost for return
    else {
        // If not found in library or known instructions, consider it an error or unknown cost
        // show_debug_message("Warning: Unknown instruction for cost calculation: " + instruction);
        return -1; // Indicate unrecognized instruction
    }

    return cost;
}

/// @description             CalculateMemoryCost takes the raw code and calculates its memory cost.
/// @param {string} _code The raw code to be calculated
/// @returns {number}        The memory cost of the code, or -1 if compilation fails.
function CalculateMemoryCost(_code)
{
    var compiled = CompileCode(_code);
    // show_message(compiled); // Optional debug
    if (variable_struct_exists(compiled, "Errors") && compiled.Errors != undefined) {
        return -1; // Indicate failure
    }
    return compiled.Cost;
}
