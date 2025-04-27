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

    for (var i = 0; i < array_length(lines); i++) 
    {
        var rawLineNumber = i + 1;
        var line = string_trim(lines[i]);

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
            } 
            else 
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid function definition syntax."));
                functionName = "InvalidFunction";
            }
            insideFunction = true;
            // Push function block onto stack, expecting a '{' soon
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
            // Mark the last block pushed (Repeat or Function) as having its opening brace found.
            // This helps associate the correct closing brace later.
            blockStack[array_length(blockStack) - 1].hasOpenedBrace = true;
            continue;
        }
        if (line == "}") 
        {
            if (array_length(blockStack) == 0) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected closing brace '}}'."));
                continue;
            }

            var closingBlock = array_pop(blockStack);

            // Check if the popped block was actually opened with a brace
            if (!variable_struct_exists(closingBlock, "hasOpenedBrace") || !closingBlock.hasOpenedBrace) 
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Closing brace '}}' does not match an opened block (e.g., missing '{{' after Repeat or function)."));
                // Push it back maybe? Or just error out. Erroring out is safer.
                continue;
            }


            if (closingBlock.type == "repeat") 
            {
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
                if (jumpPlaceholderPos > 0) 
                {
                    var instructionBase = string_copy(repeatStartInstr, 1, jumpPlaceholderPos); // Includes comma
                    compiledInstructions[repeatStartIndex] = string_concat(instructionBase, "jump_offset:", string(jumpForwardOffset), ")"); // Use string_concat
                } 
                else 
                {
                    // This should not happen if RepeatStart was compiled correctly
                    array_push(errors, string_concat("Line ", string(closingBlock.rawLineNumber), ": Internal Compiler Error: Could not patch RepeatStart jump offset."));
                }

            } 
            else if (closingBlock.type == "function") 
            {
                insideFunction = false;
                // Optionally add a Return instruction here
                // array_push(compiledInstructions, "Return");
                // array_push(instructionToRawLineMap, rawLineNumber);
            } 
            else 
            {
                // Closing a block type we don't specifically handle yet (e.g., 'other')
                // Or potentially an error if blockStack logic is flawed
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Closing brace '}}' for an unexpected block type '", closingBlock.type, "'.")); // Use string_concat
            }
            continue;
        }

        // --- Repeat Block Start ---
        // NOTE: This is fundamentally changed. No unrolling. Generate markers.
        if (string_starts_with(line, "Repeat(")) 
        {
            // Use string_last_pos for the closing parenthesis of Repeat itself
            var openParen = string_pos("(", line);
            var closeParen = string_last_pos(")", line); // Use last pos here
            var repeatParam = "";
            var repeatParamType = "invalid"; // number, lookup, result, invalid
            var compiledRepeatStart = "";

            if (openParen > 0 && closeParen > openParen) 
            {
                repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));

                if (string_digits(repeatParam) == repeatParam && repeatParam != "") 
                { 
                    // Number
                    if (real(repeatParam) > 0) 
                    {
                        repeatParamType = "number";
                        compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":", repeatParam, ",jump_offset:-1)"); // Use string_concat
                    } 
                    else 
                    {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Repeat amount must be positive. Found '", repeatParam, "'.")); // Use string_concat
                    }
                } 
                else 
                {
                    // Check for Nested Call or Variable
                    var paramOpenParen = string_pos("(", repeatParam);
                    // Check if the parameter itself looks like a function call
                    if (paramOpenParen > 0 && string_ends_with(repeatParam, ")")) 
                    { 
                        // Nested call
                        var innerCommandName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                        if (innerCommandName != "" && string_lettersdigits(innerCommandName) == innerCommandName) 
                        {
                            // Compile the inner call first
                            array_push(compiledInstructions, repeatParam); // e.g., "Inner()"
                            array_push(instructionToRawLineMap, rawLineNumber);
                            memoryCost += GetInstructionMemoryCost(repeatParam);
                            // Then compile RepeatStart using the result
                            repeatParamType = "result";
                            compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":[result],jump_offset:-1)"); // Use string_concat
                        } 
                        else 
                        {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call syntax in Repeat parameter '", repeatParam, "'.")); // Use string_concat
                        }
                    // Check if it looks like a variable name
                    } 
                    else if (string_lettersdigits(repeatParam) == repeatParam && repeatParam != "" && (string_char_at(repeatParam, 1) >= "a" && string_char_at(repeatParam, 1) <= "z" || string_char_at(repeatParam, 1) >= "A" && string_char_at(repeatParam, 1) <= "Z")) 
                    { 
                        // Variable
                        repeatParamType = "lookup";
                        compiledRepeatStart = string_concat("RepeatStart(", repeatParamType, ":", repeatParam, ",jump_offset:-1)"); // Use string_concat
                    } 
                    else 
                    {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid parameter '", repeatParam, "' for Repeat. Expected positive number, variable, or nested call.")); // Use string_concat
                    }
                }
            } 
            else 
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid Repeat syntax. Expected Repeat(Param)."));
            }

            // If a valid RepeatStart was generated, add it and push to block stack
            if (compiledRepeatStart != "") 
            {
                var repeatStartIndex = array_length(compiledInstructions);
                array_push(compiledInstructions, compiledRepeatStart);
                // Map the Repeat(N) line itself to the RepeatStart instruction
                array_push(instructionToRawLineMap, rawLineNumber);
                // Expect a '{' next
                array_push(blockStack, { type: "repeat", startInstructionIndex: repeatStartIndex, rawLineNumber: rawLineNumber });
            }
            continue; // Done processing Repeat line
        }



        // --- Variable Declaration ---
        if (string_starts_with(line, "var ")) 
        {
            var parts = string_split(line, "=");
            if (array_length(parts) == 2) {
                var declarationPart = string_trim(parts[0]);
                var valuePart = string_trim(string_replace(parts[1], ";", ""));
                if (string_starts_with(declarationPart, "var ")) {
                    var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));
                    if (varName != "" && (string_char_at(varName, 1) >= "a" && string_char_at(varName, 1) <= "z" || string_char_at(varName, 1) >= "A" && string_char_at(varName, 1) <= "Z")) 
                    {
                        if (string_digits(valuePart) == valuePart && valuePart != "") 
                        {
                            var compiledLine = string_concat("DeclareVar(", varName, ",", valuePart, ")"); // Use string_concat
                            array_push(compiledInstructions, compiledLine);
                            array_push(instructionToRawLineMap, rawLineNumber);
                            memoryCost += 1;
                        } 
                        else 
                        {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Variable '", varName, "' can only be initialized with a numeric value. Found '", valuePart, "'.")); // Use string_concat
                        }
                    } 
                    else 
                    {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable name '", varName, "'. Must start with a letter and not be empty.")); // Use string_concat
                    }
                } 
                else 
                {
                    array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable declaration syntax."));
                }
            } 
            else 
            {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid variable declaration syntax. Expected 'var name = value;'."));
            }
            continue;
        }


        // --- Normal Instruction / Command ---

        var openParen = string_pos("(", line);
        var command = "";
        var param = "";
        var compiledLine = "";

        if (openParen > 0) 
        { 
            // Command with potential parameters
            // Find the LAST closing parenthesis for the main command
            var closeParen = string_last_pos(")", line); // Use last pos here

            if (closeParen > openParen) 
            {
                command = string_trim(string_copy(line, 1, openParen - 1));
                // Extract parameter between the first '(' and the last ')'
                param = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));

                if (command == "") { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Missing command name.")); continue; }

                // --- Parameter Type Checking (logic remains similar) ---
                if (param == "") { compiledLine = string_concat(command, "()"); }
                else if (string_digits(param) == param) { compiledLine = string_concat(command, "(", param, ")"); }
                else if (string_starts_with(param, "\"") && string_ends_with(param, "\"")) 
                {
                    var stringValue = string_copy(param, 2, string_length(param) - 2);
                    if (string_pos("\"", stringValue) == 0) 
                    {
                        compiledLine = string_concat(command, "(string:", stringValue, ")");
                        memoryCost += string_length(stringValue);
                    } 
                    else 
                    {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": String parameters cannot contain double quotes. Found in '", param, "'."));
                        compiledLine = string_concat(command, "(invalid_param)");
                    }
                } 
                else 
                {
                    var paramOpenParen = string_pos("(", param);
                    // Check if param itself looks like a function call
                    if (paramOpenParen > 0 && string_ends_with(param, ")")) 
                    { 
                        // Nested call
                        var innerCommandName = string_trim(string_copy(param, 1, paramOpenParen - 1));
                        if (innerCommandName != "" && string_lettersdigits(innerCommandName) == innerCommandName) 
                        {
                            // Compile Inner() first
                            array_push(compiledInstructions, param); array_push(instructionToRawLineMap, rawLineNumber); memoryCost += GetInstructionMemoryCost(param);
                            // Then compile Outer([result])
                            compiledLine = string_concat(command, "([result])");
                        } 
                        else 
                        {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call syntax in parameter '", param, "'. Inner command name looks invalid."));
                            compiledLine = string_concat(command, "(invalid_param)");
                        }
                    }
                    // Check if param looks like a variable name
                    else if (string_lettersdigits(param) == param && param != "" && (string_char_at(param, 1) >= "a" && string_char_at(param, 1) <= "z" || string_char_at(param, 1) >= "A" && string_char_at(param, 1) <= "Z")) 
                    { 
                        // Variable
                        compiledLine = string_concat(command, "(lookup:", param, ")");
                    }
                    // Doesn't match known types
                    else 
                    {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid parameter format '", param, "' for command '", command, "'. Expected number, string literal, nested call, or variable name."));
                        compiledLine = string_concat(command, "(invalid_param)");
                    }
                }
                // --- End Parameter Type Checking ---

            } 
            else 
            { 
                // Mismatched parentheses (openParen > 0 but no valid closeParen found after it)
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Mismatched or missing closing parenthesis for command '", string_copy(line, 1, openParen-1) ,"'."));
                continue;
            }
        } 
        else 
        { 
            // Simple command with no parentheses
            command = string_trim(line);
            if (command == "") continue;
            if (string_lettersdigits(command) == command) { compiledLine = command; }
            else { array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid command name '", command, "'.")); continue; }
        }

        // Add the compiled line to the list
        if (compiledLine != "") 
        {
            array_push(compiledInstructions, compiledLine);
            array_push(instructionToRawLineMap, rawLineNumber);
            if (!string_ends_with(compiledLine, "([result])")) { memoryCost += GetInstructionMemoryCost(compiledLine); }
            else { memoryCost += 1; }
        }
    } // End of line loop

    // Check for unclosed blocks
    if (array_length(blockStack) > 0) 
    {
        var unclosedBlock = blockStack[array_length(blockStack)-1];
        array_push(errors, string_concat("Compilation Error: Unclosed '", unclosedBlock.type, "' block starting near line ", string(unclosedBlock.rawLineNumber), "."));
    }


    if (array_length(errors) > 0) 
    {
        return { Errors: errors };
    } 
    else 
    {
        return {
            FunctionName: functionName,
            CompiledArray: compiledInstructions,
            LineMapping: instructionToRawLineMap,
            Cost: memoryCost,
            Errors: undefined
        };
    }
}


function GetInstructionMemoryCost(instruction) {
    // trim the instruction from spaces and () and split by spaces to get the first word
    var trimmedInstruction = string_trim(instruction);
    var instructionList = string_split_ext(trimmedInstruction, [" ", "(", ")"]);
    var firstWord = string_lower(instructionList[0]);
    var cost = 0;
    

    if (global.vars.CommandLibrary[$ firstWord] != undefined) 
    {
        cost = global.vars.CommandLibrary[$firstWord].Cost;
    }
    else if (string_starts_with(firstWord, "var")) 
    {
        cost = 1; // Assuming a variable declaration costs 1
    }
    else if (string_starts_with(firstWord, "repeat")) 
    {
        cost = 1; // Assuming a repeat statement costs 3
    }
    else {
        return -1;
    }

    return cost;
}

/// @description   CalculateMemoryCost takes the raw code and calculates its memory cost.
/// @param {string} _code The raw code to be calculated
/// @returns {number} The memory cost of the code
function CalculateMemoryCost(_code)
{
    var compiled = CompileCode(_code);
    show_message(compiled)
    return compiled.Cost;
}