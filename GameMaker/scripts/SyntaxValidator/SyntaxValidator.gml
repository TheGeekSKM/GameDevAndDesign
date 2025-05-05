/// Script: ValidateSyntax
/// @function            ValidateSyntax(_rawCode)
/// @description         Checks raw script code for basic syntax errors before compilation.
/// @param {String} _rawCode The raw script code to validate.
/// @returns {Struct}    Struct containing { Valid: bool, Error: string (empty if valid) }

function ValidateSyntax(_rawCode) {
    var lines = string_split(_rawCode, "\n");
    var braceBalance = 0;
    var insideFunction = false;
    var blockTypeStack = [];
    var declaredVariables = ds_list_create();

    for (var i = 0; i < array_length(lines); i += 1) {
        var lineNumber = i + 1;
        var line = string_trim(lines[i]);

        if (line == "" || string_starts_with(line, "//")) 
        {
            continue;
        }

        // --- Function Definition ---
        if (string_starts_with(line, "function")) 
        {
            if (insideFunction) 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Cannot define function inside another function.") }; 
            }

            var nameStart = string_pos("function ", line) + 9; 
            var parenPos = string_pos("(", line); 
            var closeParenPos = string_pos(")", line);

            if (!(nameStart > 9 && parenPos > nameStart && closeParenPos > parenPos)) 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid function syntax.") }; 
            }

            var funcName = string_trim(string_copy(line, nameStart, parenPos - nameStart));

            if (funcName == "") 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Function name empty.") }; 
            }

            insideFunction = true;
            ds_list_clear(declaredVariables);
            array_push(blockTypeStack, { type: "function", lineNumber: lineNumber });
            continue;
        }

        // --- Block Handling ({ and }) ---
        if (line == "{") 
        {
            if (array_length(blockTypeStack) == 0) 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{'.") }; 
            }

            if (variable_struct_exists(blockTypeStack[array_length(blockTypeStack) - 1], "hasOpened") && blockTypeStack[array_length(blockTypeStack) - 1].hasOpened) 
            {
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{' - already inside an opened block.") };
            }

            blockTypeStack[array_length(blockTypeStack) - 1].hasOpened = true;
            braceBalance += 1;
            continue;
        }

        if (line == "}") 
        {
            if (array_length(blockTypeStack) == 0 || braceBalance <= 0) 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unmatched closing brace '}}'.") }; 
            }

            var currentBlock = blockTypeStack[array_length(blockTypeStack) - 1];

            if (!variable_struct_exists(currentBlock, "hasOpened") || !currentBlock.hasOpened) 
            {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Closing brace '}}' found, but expected block (e.g., Repeat or function on line ", string(currentBlock.lineNumber), ") seems incomplete (missing '{{').") };
            }

            braceBalance -= 1;
            var closedBlock = array_pop(blockTypeStack);

            if (closedBlock.type == "function") 
            {
                if (braceBalance != 0) 
                { 
                    ds_list_destroy(declaredVariables); 
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Closing brace '}}' for function does not match overall brace balance.") }; 
                }

                insideFunction = false;
                ds_list_clear(declaredVariables);
            }

            continue;
        }

        // --- Repeat Block ---
        if (string_starts_with(line, "Repeat(")) 
        {
            var openParen = string_pos("(", line); 
            var closeParen = string_last_pos(")", line);
            
            if (!(openParen > 0 && closeParen > openParen)) 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid Repeat syntax. Expected Repeat(Param).") }; 
            }
            
            var repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
            var isValidParam = false;
            
            if (string_digits(repeatParam) == repeatParam && repeatParam != "") 
            {
                if (real(repeatParam) > 0) 
                {
                    isValidParam = true;
                }
                else 
                { 
                    ds_list_destroy(declaredVariables); 
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Repeat amount must be positive.") }; 
                }
            } 
            else 
            {
                var paramOpenParen = string_pos("(", repeatParam);
                
                if (paramOpenParen > 0 && string_ends_with(repeatParam, ")")) 
                { 
                    // Nested call
                    var innerName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                    
                    if (innerName != "" && global.vars.CommandLibrary[$ string_lower(innerName)] != undefined) 
                    { 
                        isValidParam = true; 
                    } 
                    else 
                    { 
                        ds_list_destroy(declaredVariables); 
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Nested command '", innerName, "' in Repeat not found or invalid.") }; 
                    }
                }
                else if (string_lettersdigits(repeatParam) == repeatParam && repeatParam != "") 
                { 
                    // Variable
                    if (ds_list_find_index(declaredVariables, repeatParam) != -1) 
                    { 
                        isValidParam = true; 
                    } 
                    else 
                    { 
                        ds_list_destroy(declaredVariables); 
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", repeatParam, "' used in Repeat before declaration.") }; 
                    }
                }
            }
            
            if (!isValidParam) 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid parameter '", repeatParam, "' for Repeat. Expected positive number, declared variable, or valid nested call.") }; 
            }
            
            array_push(blockTypeStack, { type: "repeat", lineNumber: lineNumber });
            continue;
        }

        // --- Variable Declaration ---
        if (string_starts_with(line, "var ")) 
        {
            var parts = string_split(line, "=");
            if (array_length(parts) == 2) 
            {
                var declarationPart = string_trim(parts[0]); 
                var valuePart = string_trim(string_replace(parts[1], ";", ""));
                if (string_starts_with(declarationPart, "var ")) 
                {
                    var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));
                    if (varName == "" || !(string_char_at(varName, 1) >= "a" && string_char_at(varName, 1) <= "z" || string_char_at(varName, 1) >= "A" && string_char_at(varName, 1) <= "Z")) 
                    { 
                        ds_list_destroy(declaredVariables); 
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid variable name '", varName, "'.") }; 
                    }
                    if (ds_list_find_index(declaredVariables, varName) != -1) 
                    { 
                        ds_list_destroy(declaredVariables); 
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", varName, "' already declared.") }; 
                    }

                    // Validate value part: Number or Function Call
                    var isValidValue = false;
                    if (string_digits(valuePart) == valuePart && valuePart != "") 
                    { 
                        // Number
                        isValidValue = true;
                    } 
                    else 
                    {
                        var valOpenParen = string_pos("(", valuePart);
                        if (valOpenParen > 0 && string_ends_with(valuePart, ")")) 
                        { 
                            // Function Call
                            var funcNamePart = string_trim(string_copy(valuePart, 1, valOpenParen - 1));
                            // Check if function exists in library
                            if (funcNamePart != "" && global.vars.CommandLibrary[$ string_lower(funcNamePart)] != undefined) 
                            {
                                // TODO: Optionally check if this function actually returns a value based on library metadata
                                isValidValue = true;
                            } 
                            else 
                            { 
                                ds_list_destroy(declaredVariables); 
                                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Function '", funcNamePart, "' used in assignment not found in library.") }; 
                            }
                        }
                    }

                    if (!isValidValue) 
                    { 
                        ds_list_destroy(declaredVariables); 
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid value '", valuePart, "' for variable '", varName, "'. Expected number or function call.") }; 
                    }
                    ds_list_add(declaredVariables, varName); 
                    // Declare variable only if value is valid
                } 
                else 
                { 
                    ds_list_destroy(declaredVariables); 
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid var declaration.") }; 
                }
            } 
            else 
            { 
                ds_list_destroy(declaredVariables); 
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid var declaration syntax. Expected 'var name = value;'. Found '", line, "'") }; 
            }
            continue;
         }

        // --- Normal Instruction / Command ---
        var openParen = string_pos("(", line);
        var commandName = "";
        var param = "";

        if (openParen > 0)
        {
            var closeParen = string_last_pos(")", line);

            if (closeParen > openParen)
            {
                commandName = string_trim(string_copy(line, 1, openParen - 1));
                param = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));

                if (commandName == "")
                {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Missing command name.") };
                }

                if (global.vars.CommandLibrary[$ string_lower(commandName)] == undefined)
                {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Command '", commandName, "' not found.") };
                }

                if (param != "")
                {
                    var isNumeric = (string_digits(param) == param);
                    var isString = (string_starts_with(param, "\"") && string_ends_with(param, "\""));
                    var paramOpenParen = string_pos("(", param);
                    var isNestedCall = (paramOpenParen > 0 && string_ends_with(param, ")"));
                    var isVariable = (!isNumeric && !isString && !isNestedCall && string_lettersdigits(param) == param && param != "");

                    if (isVariable)
                    {
                        if (ds_list_find_index(declaredVariables, param) == -1)
                        {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", param, "' used before declaration.") };
                        }
                    }
                    else if (isNestedCall)
                    {
                        var innerName = string_trim(string_copy(param, 1, paramOpenParen - 1));

                        if (innerName == "" || global.vars.CommandLibrary[$ string_lower(innerName)] == undefined)
                        {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Nested command '", innerName, "' not found.") };
                        }
                    }
                    else if (isString)
                    {
                        var stringValue = string_copy(param, 2, string_length(param) - 2);

                        if (string_pos("\"", stringValue) > 0)
                        {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Strings cannot contain double quotes.") };
                        }
                    }
                    else if (!isNumeric)
                    {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid parameter format '", param, "'.") };
                    }
                }
            }
            else
            {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Mismatched or missing closing parenthesis for command '", string_copy(line, 1, openParen - 1), "'.") };
            }
        }
        else
        {
            commandName = string_trim(line);

            if (commandName == "")
            {
                continue;
            }

            if (global.vars.CommandLibrary[$ string_lower(commandName)] == undefined)
            {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Command '", commandName, "' not found.") };
            }

            if (string_lettersdigits(commandName) != commandName)
            {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid command name '", commandName, "'.") };
            }
        }
    } // End of line loop

    // Final checks
    if (braceBalance != 0) { 
        ds_list_destroy(declaredVariables); 
        return { Valid: false, Error: "Syntax Error: Unmatched braces '{}'." }; 
    }
    if (insideFunction) { ds_list_destroy(declaredVariables); return { Valid: false, Error: "Syntax Error: Unclosed 'function' block." }; }
    if (array_length(blockTypeStack) != 0) { ds_list_destroy(declaredVariables); return { Valid: false, Error: "Syntax Error: Unclosed block (likely Repeat)." }; }

    ds_list_destroy(declaredVariables);
    return { Valid: true, Error: "" };
}
