/// @function                ValidateSyntax(_rawCode)
/// @description             Checks raw script code for basic syntax errors before compilation.
/// @param {String} _rawCode The raw script code to validate.
/// @returns {Struct}        Struct containing { Valid: bool, Error: string (empty if valid) }

function ValidateSyntax(_rawCode) {

    // Initial validation
    if (_rawCode == "" || string_trim(_rawCode) == "") // Trim check
    {
        return { Valid: false, Error: "No code is present." };
    }

    var lines = string_split(string_replace_all(_rawCode, "\r\n", "\n"), "\n"); // Normalize newlines
    var braceBalance = 0;
    var insideFunction = false;
    var blockTypeStack = []; // Tracks nested block types (function, repeat)
    var declaredVariables = ds_list_create(); // Track variables declared in the current scope

    /// @function _is_valid_identifier(_name)
    /// @description Checks if a string is a valid GML identifier (starts with letter/_, contains letters/digits/_)
    /// @param {String} _name String to check
    /// @returns {Boolean}
    var _is_valid_identifier = function(_name) {
        if (_name == "") return false;
        var _firstChar = string_char_at(_name, 1);
        if (!((_firstChar >= "a" && _firstChar <= "z") || (_firstChar >= "A" && _firstChar <= "Z") || _firstChar == "_")) {
            return false;
        }
        if (string_length(_name) > 1) {
            var _rest = string_copy(_name, 2, string_length(_name) - 1);
            // Check if remaining characters are letters, digits, or underscores
            // string_lettersdigits allows letters and digits. We need to manually allow underscores.
            for (var _c = 1; _c <= string_length(_rest); _c++) {
                var _char = string_char_at(_rest, _c);
                if (!((_char >= "a" && _char <= "z") || (_char >= "A" && _char <= "Z") || (_char >= "0" && _char <= "9") || _char == "_")) {
                    return false; // Invalid character found
                }
            }
        }
        return true; // All checks passed
    }

    /// @function _command_exists(_name)
    /// @description Checks if a command exists in the library (case-insensitive)
    /// @param {String} _name Command name to check
    /// @returns {Boolean}
    var _command_exists = function(_name) {
        if (variable_global_exists("vars") && is_struct(global.vars) && variable_struct_exists(global.vars, "CommandLibrary") && is_struct(global.vars.CommandLibrary)) {
            var _cmdLibKeys = variable_struct_get_names(global.vars.CommandLibrary);
            var _nameLower = string_lower(_name);
            for (var k = 0; k < array_length(_cmdLibKeys); k++) {
                if (_nameLower == string_lower(_cmdLibKeys[k])) {
                    return true;
                }
            }
        }
        return false;
    }


    for (var i = 0; i < array_length(lines); i += 1) {
        var lineNumber = i + 1;
        var line = string_trim(lines[i]);

        // Skip empty lines and comments
        if (line == "" || string_starts_with(line, "//")) continue;

        // --- Function Definition ---
        if (string_starts_with(line, "function")) {
            if (insideFunction) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Cannot define function inside another function.") };
            }
            var nameStart = string_pos("function ", line) + 9;
            var parenPos = string_pos("(", line);
            var closeParenPos = string_pos(")", line); // Use first ')'

            if (!(nameStart > 9 && parenPos > nameStart && closeParenPos > parenPos)) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid function syntax.") };
            }
            var funcName = string_trim(string_copy(line, nameStart, parenPos - nameStart));
            if (funcName == "") {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Function name empty.") };
            }
            // Validate function name format using helper
            if (!_is_valid_identifier(funcName)) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid function name '", funcName, "'.") };
            }
            insideFunction = true;
            ds_list_clear(declaredVariables); // Reset variables for new function scope
            array_push(blockTypeStack, { type: "function", lineNumber: lineNumber });
            continue;
        }

        // --- Block Handling ({ and }) ---
        if (line == "{") {
            if (array_length(blockTypeStack) == 0) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{'.") };
            }
            var _topBlock = array_last(blockTypeStack);
            // Check if the block expecting this brace has already been marked as opened
            if (!is_struct(_topBlock) || (variable_struct_exists(_topBlock, "hasOpened") && _topBlock.hasOpened)) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{' - check block structure.") };
            }
            _topBlock.hasOpened = true; // Mark the block as opened
            braceBalance += 1;
            continue;
        }
        if (line == "}") {
            if (array_length(blockTypeStack) == 0 || braceBalance <= 0) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unmatched closing brace '}}'.") };
            }

            var currentBlock = array_last(blockTypeStack); // Peek at the block

            // Check if the block expecting this brace was actually opened
            if (!is_struct(currentBlock) || !variable_struct_exists(currentBlock, "hasOpened") || !currentBlock.hasOpened) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Closing brace '}}' found, but expected block (e.g., Repeat or function on line ", string(currentBlock.lineNumber), ") seems incomplete (missing '{{').") };
            }

            braceBalance -= 1;
            var closedBlock = array_pop(blockTypeStack); // Pop the now-closed block

            if (closedBlock.type == "function") {
                // Function block closed, reset function flag and clear local vars
                if (braceBalance != 0) { // Function must close at brace balance 0
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Closing brace '}}' for function does not match overall brace balance.") };
                }
                insideFunction = false;
                ds_list_clear(declaredVariables);
            }
            // No specific action needed for closing 'repeat' block in validator beyond popping stack
            continue;
        }

        // --- Repeat Block ---
        if (string_starts_with(line, "Repeat(")) {
            var openParen = string_pos("(", line);
            var closeParen = string_last_pos(")", line);
            if (!(openParen > 0 && closeParen > openParen)) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid Repeat syntax. Expected Repeat(Param).") };
            }

            var repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
            var isValidParam = false;
            if (string_digits(repeatParam) == repeatParam && repeatParam != "") { // Number check
                if (real(repeatParam) > 0) isValidParam = true;
                else { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Repeat amount must be positive.") }; }
            } else {
                var paramOpenParen = string_pos("(", repeatParam);
                if (paramOpenParen > 0 && string_ends_with(repeatParam, ")")) { // Nested call check
                    var innerName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                    // Check if inner command exists using helper
                    if (innerName != "" && _command_exists(innerName)) { isValidParam = true; }
                    else { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Nested command '", innerName, "' in Repeat not found or invalid.") }; }
                }
                // Variable name check using helper
                else if (repeatParam != "" && _is_valid_identifier(repeatParam)) {
                    if (ds_list_find_index(declaredVariables, repeatParam) != -1) { isValidParam = true; }
                    else { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", repeatParam, "' used in Repeat before declaration.") }; }
                }
            }
            if (!isValidParam) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid parameter '", repeatParam, "' for Repeat. Expected positive number, declared variable, or valid nested call.") };
            }
            array_push(blockTypeStack, { type: "repeat", lineNumber: lineNumber }); // Expecting a '{'
            continue;
        }

        // --- Variable Declaration ---
        if (string_starts_with(line, "var ")) {
            var eqPos = string_pos("=", line);
            if (eqPos > 0) {
                var declarationPart = string_trim(string_copy(line, 1, eqPos - 1));
                var valuePart = string_trim(string_replace(string_copy(line, eqPos + 1, string_length(line) - eqPos), ";", ""));

                if (string_starts_with(declarationPart, "var ")) {
                    var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));

                    // Validate variable name format using helper
                    if (!_is_valid_identifier(varName)) {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid variable name '", varName, "'.") };
                    }

                    // Check for redeclaration
                    if (ds_list_find_index(declaredVariables, varName) != -1) {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", varName, "' already declared in this scope.") };
                    }

                    // Validate the assigned value (Number OR Function Call)
                    var isValueNumeric = (string_digits(valuePart) == valuePart && valuePart != "");
                    var isValueFunctionCall = false;
                    var valueOpenParen = string_pos("(", valuePart);
                    var valueCloseParen = string_last_pos(")", valuePart); // Use last pos

                    if (!isValueNumeric && valueOpenParen > 0 && valueCloseParen == string_length(valuePart)) {
                        var funcNamePart = string_trim(string_copy(valuePart, 1, valueOpenParen - 1));
                        // Check if the function name exists using helper
                        if (funcNamePart != "" && _command_exists(funcNamePart)) {
                            isValueFunctionCall = true;
                            // Could add parameter validation for the function call here if needed
                        }
                    }

                    // If it's neither a number nor a valid function call, it's an error
                    if (!isValueNumeric && !isValueFunctionCall) {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", varName, "' must be assigned a numeric value or a valid function call. Found '", valuePart, "'.") };
                    }

                    // If valid, add to declared list for this scope
                    ds_list_add(declaredVariables, varName);

                } else { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid var declaration syntax near 'var'.") }; }
            } else { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid var declaration syntax. Expected 'var name = value;'. Found '", line, "'") }; }
            continue;
        }

        // --- Normal Instruction / Command ---
        var openParen = string_pos("(", line); var commandName = ""; var param = "";
        if (openParen > 0) { // Command with parameters
            var closeParen = string_last_pos(")", line);
            if (closeParen > openParen) {
                commandName = string_trim(string_copy(line, 1, openParen - 1));
                param = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));

                if (commandName == "") { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Missing command name.") }; }

                // Check if command exists using helper
                if (!_command_exists(commandName)) { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Command '", commandName, "' not found.") }; }


                // Validate parameter if not empty
                if (param != "") {
                    var isNumeric = (string_digits(param) == param);
                    var isString = (string_starts_with(param, "\"") && string_ends_with(param, "\""));
                    var paramOpenParen = string_pos("(", param);
                    var isNestedCall = (paramOpenParen > 0 && string_ends_with(param, ")"));
                    var isVariable = (!isNumeric && !isString && !isNestedCall && param != "" && _is_valid_identifier(param)); // Use helper

                    if (isVariable) { // Check if variable used as param is declared
                        if (ds_list_find_index(declaredVariables, param) == -1) {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", param, "' used before declaration.") };
                        }
                    } else if (isNestedCall) { // Check if nested command exists
                        var innerName = string_trim(string_copy(param, 1, paramOpenParen - 1));
                        if (innerName == "" || !_command_exists(innerName)) { // Use helper
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Nested command '", innerName, "' not found.") };
                        }
                    } else if (isString) { // Check for quotes inside string
                        var stringValue = string_copy(param, 2, string_length(param) - 2);
                        if (string_pos("\"", stringValue) > 0) {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Strings cannot contain double quotes.") };
                        }
                    } else if (!isNumeric) { // If not any valid type
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid parameter format '", param, "'.") };
                    }
                } // End parameter validation
            } else { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Mismatched or missing closing parenthesis for command '", string_copy(line, 1, openParen-1) ,"'.") }; }
        } else { // Simple command without parentheses
            commandName = string_trim(line); if (commandName == "") continue;
            // Check if command exists using helper
            if (!_command_exists(commandName)) { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Command '", commandName, "' not found.") }; }

            // Validate command name format using helper
            if (!_is_valid_identifier(commandName)) { ds_list_destroy(declaredVariables); return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid command name '", commandName, "'.") }; }
        }
    } // End of line loop

    // Final checks after looping through all lines
    if (braceBalance != 0) { ds_list_destroy(declaredVariables); return { Valid: false, Error: "Syntax Error: Unmatched braces '{}'." }; }
    if (insideFunction) { ds_list_destroy(declaredVariables); return { Valid: false, Error: "Syntax Error: Unclosed 'function' block (missing '}}')." }; }
    if (array_length(blockTypeStack) != 0) { ds_list_destroy(declaredVariables); return { Valid: false, Error: "Syntax Error: Unclosed block (likely Repeat, missing '}}')." }; }

    // If all checks passed
    ds_list_destroy(declaredVariables);
    return { Valid: true, Error: "" };
}
