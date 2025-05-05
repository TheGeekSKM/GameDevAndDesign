/// Script: CompileCode
/// @function            CompileCode(_code)
/// @description         Compiles raw script code into executable instructions and metadata.
/// @param {String} _code The raw script code to compile.
/// @returns {Struct}    Struct containing { FunctionName, CompiledArray, LineMapping, Cost, Errors (optional) }

function CompileCode(_code) {
    var compiledInstructions = [];
    var memoryCost = 0;
    var instructionToRawLineMap = [];
    var errors = []; // Store compilation errors

    var lines = string_split(_code, "\n");
    // Stack to track nested blocks ({}) and associate them with Repeat/Function
    // Each entry: { type: "repeat" | "function" | "other", startInstructionIndex: index, rawLineNumber: num }
    var blockStack = [];
    // Stack specifically for patching Repeat jumps later
    // Each entry: { repeatStartIndex: index, correspondingBraceLine: num }
    var repeatPatchStack = [];

    var insideFunction = false;
    var functionName = "Main";

    for (var i = 0; i < array_length(lines); i++) {
        var rawLineNumber = i + 1;
        var line = string_trim(lines[i]);

        if (line == "" || string_starts_with(line, "//")) continue;

        // --- Function Definition ---
        if (string_starts_with(line, "function")) {
            if (insideFunction) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Cannot define function inside another function."));
                continue;
            }
            var nameStart = string_pos("function ", line) + 9;
            var parenPos = string_pos("(", line);
            if (nameStart > 9 && parenPos > nameStart) {
                functionName = string_trim(string_copy(line, nameStart, parenPos - nameStart));
                if (functionName == "") array_push(errors, string_concat("Line ", string(rawLineNumber), ": Function name cannot be empty."));
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid function definition syntax."));
                functionName = "InvalidFunction";
            }
            insideFunction = true;
            // Push function block onto stack, expecting a '{' soon
            array_push(blockStack, { type: "function", startInstructionIndex: array_length(compiledInstructions), rawLineNumber: rawLineNumber });
            continue;
        }

        // --- Block Handling ({ and }) ---
        if (line == "{") {
            if (array_length(blockStack) == 0) {
                 array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected opening brace '{{'."));
                 continue;
            }
             // Mark the last block pushed (Repeat or Function) as having its opening brace found.
             // This helps associate the correct closing brace later.
             blockStack[array_length(blockStack) - 1].hasOpenedBrace = true;
            continue;
        }
        if (line == "}") {
            if (array_length(blockStack) == 0) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected closing brace '}}'."));
                continue;
            }

            var closingBlock = array_pop(blockStack);

            // Check if the popped block was actually opened with a brace
            if (!variable_struct_exists(closingBlock, "hasOpenedBrace") || !closingBlock.hasOpenedBrace) {
                 array_push(errors, string_concat("Line ", string(rawLineNumber), ": Closing brace '}}' does not match an opened block (e.g., missing '{{' after Repeat or function)."));
                 // Push it back maybe? Or just error out. Erroring out is safer.
                 continue;
            }


            if (closingBlock.type == "repeat") {
                // --- Compile RepeatEnd and Patch Jumps ---
                var repeatStartIndex = closingBlock.startInstructionIndex;
                // Calculate jump offset to go back to the instruction *after* RepeatStart
                var jumpBackOffset = array_length(compiledInstructions) - repeatStartIndex;
                // Compile the RepeatEnd instruction, pointing back to RepeatStart+1
                var repeatEndInstruction = string_concat("RepeatEnd(jump_offset:", string(jumpBackOffset), ")"); // Use string_concat
                array_push(compiledInstructions, repeatEndInstruction);
                array_push(instructionToRawLineMap, rawLineNumber); // Map '}' to RepeatEnd

                // Now patch the corresponding RepeatStart instruction
                // Calculate jump offset to go *past* the RepeatEnd instruction we just added
                var jumpForwardOffset = array_length(compiledInstructions) - 1 - repeatStartIndex;
                // Modify the placeholder RepeatStart instruction
                var repeatStartInstr = compiledInstructions[repeatStartIndex];
                // Find the comma before jump_offset placeholder
                var jumpPlaceholderPos = string_pos(",jump_offset:-1", repeatStartInstr);
                if (jumpPlaceholderPos > 0) {
                    var instructionBase = string_copy(repeatStartInstr, 1, jumpPlaceholderPos); // Includes comma
                    compiledInstructions[repeatStartIndex] = string_concat(instructionBase, "jump_offset:", string(jumpForwardOffset), ")"); // Use string_concat
                } else {
                     // This should not happen if RepeatStart was compiled correctly
                     array_push(errors, string_concat("Line ", string(closingBlock.rawLineNumber), ": Internal Compiler Error: Could not patch RepeatStart jump offset."));
                }

            } else if (closingBlock.type == "function") {
                insideFunction = false;
                // Optionally add a Return instruction here
                // array_push(compiledInstructions, "Return");
                // array_push(instructionToRawLineMap, rawLineNumber);
            } else {
                 // Closing a block type we don't specifically handle yet (e.g., 'other')
                 // Or potentially an error if blockStack logic is flawed
                 array_push(errors, string_concat("Line ", string(rawLineNumber), ": Closing brace '}}' for an unexpected block type '", closingBlock.type, "'.")); // Use string_concat
            }
            continue;
        }

        // --- Repeat Block Start ---
        if (string_starts_with(line, "Repeat(")) {
            var openParen = string_pos("(", line);
            var closeParen = string_last_pos(")", line);
            var repeatParam = "";
            var repeatParamType = "invalid";
            var compiledRepeatStart = "";

            if (openParen > 0 && closeParen > openParen) {
                repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
                if (string_digits(repeatParam) == repeatParam && repeatParam != "") { // Number
                    if (real(repeatParam) > 0) {
                        repeatParamType = "number";
                        compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":", repeatParam, ",jump_offset:-1)");
                    } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Repeat amount must be positive. Found '", repeatParam, "'.")); }
                } else {
                    var paramOpenParen = string_pos("(", repeatParam);
                    if (paramOpenParen > 0 && string_ends_with(repeatParam, ")")) { // Nested call
                        var innerCommandName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                        if (innerCommandName != "" && string_lettersdigits(innerCommandName) == innerCommandName) {
                            array_push(compiledInstructions, repeatParam); array_push(instructionToRawLineMap, rawLineNumber); memoryCost += GetInstructionMemoryCost(repeatParam);
                            repeatParamType = "result";
                            compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":[result],jump_offset:-1)");
                        } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call syntax in Repeat parameter '", repeatParam, "'.")); }
                    } else if (string_lettersdigits(repeatParam) == repeatParam && repeatParam != "" && (string_char_at(repeatParam, 1) >= "a" && string_char_at(repeatParam, 1) <= "z" || string_char_at(repeatParam, 1) >= "A" && string_char_at(repeatParam, 1) <= "Z")) { // Variable
                        repeatParamType = "lookup";
                        compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":", repeatParam, ",jump_offset:-1)");
                    } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid parameter '", repeatParam, "' for Repeat. Expected positive number, variable, or nested call.")); }
                }
            } else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid Repeat syntax. Expected Repeat(Param).")); }

            if (compiledRepeatStart != "") {
                var repeatStartIndex = array_length(compiledInstructions);
                array_push(compiledInstructions, compiledRepeatStart);
                array_push(instructionToRawLineMap, rawLineNumber);
                memoryCost += 1;
                array_push(blockStack, { type: "repeat", startInstructionIndex: repeatStartIndex, rawLineNumber: rawLineNumber });
            }
            continue;
        }


         // --- Variable Declaration ---
         if (string_starts_with(line, "var ")) {
             var parts = string_split(line, "=");
             if (array_length(parts) == 2) {
                 var declarationPart = string_trim(parts[0]);
                 var valuePart = string_trim(string_replace(parts[1], ";", "")); // Remove potential semicolon

                 if (string_starts_with(declarationPart, "var ")) {
                     var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));

                     if (varName != "" && (string_char_at(varName, 1) >= "a" && string_char_at(varName, 1) <= "z" || string_char_at(varName, 1) >= "A" && string_char_at(varName, 1) <= "Z")) {
                         // Check value type: Number or Function Call?
                         if (string_digits(valuePart) == valuePart && valuePart != "") { // Numeric Value
                             var compiledLine = string_concat("DeclareVar(", varName, ",", valuePart, ")");
                             array_push(compiledInstructions, compiledLine);
                             array_push(instructionToRawLineMap, rawLineNumber);
                             memoryCost += 1;
                         } else {
                             // Check if it's a function call like FunctionName()
                             var valOpenParen = string_pos("(", valuePart);
                             if (valOpenParen > 0 && string_ends_with(valuePart, ")")) { // Function Call Value
                                 var funcNamePart = string_trim(string_copy(valuePart, 1, valOpenParen - 1));
                                 // Basic check if function name looks valid
                                 if (funcNamePart != "" && string_lettersdigits(funcNamePart) == funcNamePart) {
                                     // 1. Compile the function call itself
                                     array_push(compiledInstructions, valuePart);
                                     array_push(instructionToRawLineMap, rawLineNumber);
                                     memoryCost += GetInstructionMemoryCost(valuePart);
                                     // 2. Compile the assignment instruction using [result]
                                     var assignInstruction = string_concat("AssignVar(", varName, ",[result])"); // NEW instruction
                                     array_push(compiledInstructions, assignInstruction);
                                     array_push(instructionToRawLineMap, rawLineNumber); // Map this line number again
                                     memoryCost += 1; // Cost for assignment itself
                                 } else {
                                     array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid function name '", funcNamePart, "' in variable assignment."));
                                 }
                             } else { // Neither Number nor Function Call
                                 array_push(errors, string_concat("Line ", string(rawLineNumber), ": Variable '", varName, "' can only be initialized with a numeric value or function call. Found '", valuePart, "'."));
                             }
                         }
                     } else {
                         array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable name '", varName, "'. Must start with a letter and not be empty."));
                     }
                 } else {
                     array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable declaration syntax."));
                 }
             } else {
                 array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable declaration syntax. Expected 'var name = value;'."));
             }
             continue;
         }


        // --- Normal Instruction / Command ---
        var openParen = string_pos("(", line);
        var command = "";
        var param = "";
        var compiledLine = "";

        if (openParen > 0) {
            var closeParen = string_last_pos(")", line);
            if (closeParen > openParen) {
                command = string_trim(string_copy(line, 1, openParen - 1));
                param = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
                if (command == "") { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Missing command name.")); continue; }

                if (param == "") { compiledLine = string_concat(command, "()"); }
                else if (string_digits(param) == param) { compiledLine = string_concat(command, "(", param, ")"); }
                else if (string_starts_with(param, "\"") && string_ends_with(param, "\"")) {
                     var stringValue = string_copy(param, 2, string_length(param) - 2);
                     if (string_pos("\"", stringValue) == 0) {
                        compiledLine = string_concat(command, "(string:", stringValue, ")");
                        memoryCost += string_length(stringValue);
                     } else {
                         array_push(errors, string_concat("Line ", string(rawLineNumber), ": String parameters cannot contain double quotes. Found in '", param, "'."));
                         compiledLine = string_concat(command, "(invalid_param)");
                     }
                } else {
                     var paramOpenParen = string_pos("(", param);
                     if (paramOpenParen > 0 && string_ends_with(param, ")")) { // Nested call
                         var innerCommandName = string_trim(string_copy(param, 1, paramOpenParen - 1));
                         if (innerCommandName != "" && string_lettersdigits(innerCommandName) == innerCommandName) {
                             array_push(compiledInstructions, param); array_push(instructionToRawLineMap, rawLineNumber); memoryCost += GetInstructionMemoryCost(param);
                             compiledLine = string_concat(command, "([result])");
                         } else {
                             array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call syntax in parameter '", param, "'. Inner command name looks invalid."));
                             compiledLine = string_concat(command, "(invalid_param)");
                         }
                     }
                     else if (string_lettersdigits(param) == param && param != "" && (string_char_at(param, 1) >= "a" && string_char_at(param, 1) <= "z" || string_char_at(param, 1) >= "A" && string_char_at(param, 1) <= "Z")) { // Variable
                         compiledLine = string_concat(command, "(lookup:", param, ")");
                     }
                     else {
                         array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid parameter format '", param, "' for command '", command, "'. Expected number, string literal, nested call, or variable name."));
                         compiledLine = string_concat(command, "(invalid_param)");
                     }
                }
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Mismatched or missing closing parenthesis for command '", string_copy(line, 1, openParen-1) ,"'."));
                continue;
            }
        } else {
            command = string_trim(line);
            if (command == "") continue;
            if (string_lettersdigits(command) == command) { compiledLine = command; }
            else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid command name '", command, "'.")); continue; }
        }

        if (compiledLine != "") {
             array_push(compiledInstructions, compiledLine);
             array_push(instructionToRawLineMap, rawLineNumber);
             if (!string_ends_with(compiledLine, "([result])")) { memoryCost += GetInstructionMemoryCost(compiledLine); }
             else { memoryCost += 1; }
        }
    } // End of line loop

    if (array_length(blockStack) > 0) {
         var unclosedBlock = blockStack[array_length(blockStack)-1];
         array_push(errors, string_concat("Compilation Error: Unclosed '", unclosedBlock.type, "' block starting near line ", string(unclosedBlock.rawLineNumber), "."));
    }

    if (array_length(errors) > 0) {
         return { Errors: errors };
    } else {
        return {
            FunctionName: functionName,
            CompiledArray: compiledInstructions,
            LineMapping: instructionToRawLineMap,
            Cost: memoryCost,
            Errors: undefined,
            RawCode: _code 
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
