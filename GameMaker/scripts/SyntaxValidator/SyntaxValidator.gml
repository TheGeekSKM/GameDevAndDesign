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
    var lastStatementWasIf = false;
    var errors = [];

    var IsValidExpression = function(_exprStr, _lineNumber, errors) {
        var openParenCount = string_count("(", _exprStr);
        var closeParenCount = string_count(")", _exprStr);
        if (openParenCount != closeParenCount) {
            return { Valid: false, Error: string_concat("Line ", string(_lineNumber), ": Mismatched parentheses in expression '", _exprStr, "'.") };
        }
        var invalidPatterns = ["++", "--", "**", "//", "+*", "+/", "*+", "/+", "()"];
        for(var k=0; k < array_length(invalidPatterns); k++) {
            if (string_pos(invalidPatterns[k], _exprStr) > 0) {
                if (invalidPatterns[k] == "()" && string_pos_ext("(", _exprStr, string_pos("()", _exprStr) -1) > 0 && string_lettersdigits(string_char_at(_exprStr, string_pos("()", _exprStr))) == string_char_at(_exprStr, string_pos("()", _exprStr)) ) {
                    // Allow MyFunc()
                } else {
                    array_push(errors, string_concat("Line ", string(_lineNumber), ": Invalid operator sequence or empty parentheses in expression '", _exprStr, "'."));
                    return false;
                }
            }
        }
        var trimmedExpr = string_trim(_exprStr);
        if (trimmedExpr == "") {
            array_push(errors, string_concat("Line ", string(_lineNumber), ": Empty expression."));
            return false;
        }
        var firstChar = string_char_at(trimmedExpr, 1);
        var lastChar = string_char_at(trimmedExpr, string_length(trimmedExpr));
        
        var _string_pos_array = function(_array, _string) {
            for (var j = 0; j < array_length(_array); j += 1) {
                if (string_pos(_array[j], _string) != -1) {
                    return j;
                }
            }
            return -1;
        };
        
        
        if (_string_pos_array(["*", "/", "+"], firstChar) != -1 && firstChar != "-") {
            array_push(errors, string_concat("Line ", string(_lineNumber), ": Expression cannot start with operator '", firstChar, "'."));
            return false;
        }
        if (_string_pos_array(["*", "/", "+", "-"], lastChar) != -1) {
            array_push(errors, string_concat("Line ", string(_lineNumber), ": Expression cannot end with operator '", lastChar, "'."));
            return false;
        }
        return true;
    }


    for (var i = 0; i < array_length(lines); i += 1) {
        var lineNumber = i + 1;
        var line = string_trim(lines[i]);
        var currentLineIsIfRelated = false;

        if (line == "" || string_starts_with(line, "//")) {
            continue;
        }

        if (string_starts_with(line, "function")) {
            if (insideFunction) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Cannot define function inside another function.") };
            }
            var nameStart = string_pos("function ", line) + 9;
            var parenPos = string_pos("(", line);
            var closeParenPos = string_pos(")", line);
            if (!(nameStart > 9 && parenPos > nameStart && closeParenPos > parenPos)) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid function syntax.") };
            }
            var funcName = string_trim(string_copy(line, nameStart, parenPos - nameStart));
            if (funcName == "") {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Function name empty.") };
            }
            insideFunction = true;
            ds_list_clear(declaredVariables);
            array_push(blockTypeStack, { type: "function", lineNumber: lineNumber, expectsBrace: true, hasOpenedBrace: false });
            lastStatementWasIf = false;
            continue;
        }

        if (string_starts_with(line, "if (") && string_ends_with(line, ")")) {
            var conditionStr = string_trim(string_copy(line, 4, string_length(line) - 4 -1));
            if (string_trim(conditionStr) == "") {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Empty condition in 'if' statement.") };
            }
            if (!IsValidExpression(conditionStr, lineNumber) && ParseCondition(conditionStr, lineNumber) == undefined) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber),": Invalid condition in 'if': ", conditionStr) };
            }
            array_push(blockTypeStack, { type: "if", lineNumber: lineNumber, expectsBrace: true, hasOpenedBrace: false });
            lastStatementWasIf = true;
            currentLineIsIfRelated = true;
            continue;
        }

        if (string_starts_with(line, "else if (") && string_ends_with(line, ")")) {
            if (!lastStatementWasIf) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": 'else if' without preceding 'if' or 'else if'.") };
            }
            var conditionStr = string_trim(string_copy(line, 9, string_length(line) - 9 -1));
            if (string_trim(conditionStr) == "") {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Empty condition in 'else if' statement.") };
            }
            if (!IsValidExpression(conditionStr, lineNumber) && ParseCondition(conditionStr, lineNumber) == undefined) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber),": Invalid condition in 'else if': ", conditionStr) };
            }
            array_push(blockTypeStack, { type: "elseif", lineNumber: lineNumber, expectsBrace: true, hasOpenedBrace: false });
            lastStatementWasIf = true;
            currentLineIsIfRelated = true;
            continue;
        }

        if (line == "else") {
            if (!lastStatementWasIf) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": 'else' without preceding 'if' or 'else if'.") };
            }
            array_push(blockTypeStack, { type: "else", lineNumber: lineNumber, expectsBrace: true, hasOpenedBrace: false });
            lastStatementWasIf = true;
            currentLineIsIfRelated = true;
            continue;
        }

        if (line == "{") {
            if (array_length(blockTypeStack) == 0) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{'.") };
            }
            var currentActiveBlock = blockTypeStack[array_length(blockTypeStack) - 1];
            if (!currentActiveBlock.expectsBrace) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{' for block type '", currentActiveBlock.type, "'.") };
            }
            if (currentActiveBlock.hasOpenedBrace) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unexpected opening brace '{{' - block already opened.") };
            }
            currentActiveBlock.hasOpenedBrace = true;
            braceBalance += 1;
            lastStatementWasIf = false;
            continue;
        }

        if (line == "}") {
            if (array_length(blockTypeStack) == 0 || braceBalance <= 0) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Unmatched closing brace '}}'.") };
            }
            var blockBeingClosed = blockTypeStack[array_length(blockTypeStack) - 1];
            if (!blockBeingClosed.hasOpenedBrace) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Closing brace '}}' for block on line ", string(blockBeingClosed.lineNumber)," which was not opened with '{'.") };
            }
            braceBalance -= 1;
            var closedBlock = array_pop(blockTypeStack);
            if (closedBlock.type == "function") {
                if (braceBalance != 0 && array_length(blockTypeStack) == 0) {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Closing brace '}}' for function does not match overall brace balance.") };
                }
                insideFunction = false;
                ds_list_clear(declaredVariables);
            }
            if (closedBlock.type == "if" || closedBlock.type == "elseif") {
                lastStatementWasIf = true;
            } else {
                lastStatementWasIf = false;
            }
            continue;
        }

        if (string_starts_with(line, "Repeat(")) {
            var openParen = string_pos("(", line);
            var closeParen = string_last_pos(")", line);
            if (!(openParen > 0 && closeParen > openParen)) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid Repeat syntax. Expected Repeat(Param).") };
            }
            var repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
            var isValidParam = false;
            if (string_digits(repeatParam) == repeatParam && repeatParam != "") {
                if (real(repeatParam) > 0) {
                    isValidParam = true;
                } else {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Repeat amount must be positive.") };
                }
            } else {
                var paramOpenParen = string_pos("(", repeatParam);
                if (paramOpenParen > 0 && string_ends_with(repeatParam, ")")) {
                    var innerName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                    if (innerName != "" && global.vars.CommandLibrary[$ string_lower(innerName)] != undefined) {
                        isValidParam = true;
                    } else {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Nested command '", innerName, "' in Repeat not found or invalid.") };
                    }
                } else if (string_lettersdigits(repeatParam) == repeatParam && repeatParam != "") {
                    if (ds_list_find_index(declaredVariables, repeatParam) != -1) {
                        isValidParam = true;
                    } else {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", repeatParam, "' used in Repeat before declaration.") };
                    }
                } else if (!IsValidExpression(repeatParam, lineNumber)) {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: errors[array_length(errors)-1] };
                } else {
                    isValidParam = true;
                }
            }
            if (!isValidParam) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid parameter '", repeatParam, "' for Repeat.") };
            }
            array_push(blockTypeStack, { type: "repeat", lineNumber: lineNumber, expectsBrace: true, hasOpenedBrace: false });
            lastStatementWasIf = false;
            continue;
        }

         if (string_starts_with(line, "var ")) {
             var parts = string_split(line, "=");
             if (array_length(parts) == 2) {
                 var declarationPart = string_trim(parts[0]);
                 var valuePart = string_trim(string_replace(parts[1], ";", ""));
                 if (string_starts_with(declarationPart, "var ")) {
                     var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));
                     if (varName == "" || !(string_char_at(varName, 1) >= "a" && string_char_at(varName, 1) <= "z" || string_char_at(varName, 1) >= "A" && string_char_at(varName, 1) <= "Z")) {
                         ds_list_destroy(declaredVariables);
                         return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid variable name '", varName, "'.") };
                     }
                     if (ds_list_find_index(declaredVariables, varName) != -1) {
                         ds_list_destroy(declaredVariables);
                         return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", varName, "' already declared.") };
                     }
                     var isValidValue = false;
                     if (string_digits(valuePart) == valuePart && valuePart != "") {
                         isValidValue = true;
                     } else {
                         var valOpenParen = string_pos("(", valuePart);
                         if (valOpenParen > 0 && string_ends_with(valuePart, ")")) {
                             var funcNamePart = string_trim(string_copy(valuePart, 1, valOpenParen - 1));
                             if (funcNamePart != "" && global.vars.CommandLibrary[$ string_lower(funcNamePart)] != undefined) {
                                 isValidValue = true;
                             } else {
                                 ds_list_destroy(declaredVariables);
                                 return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Function '", funcNamePart, "' in assignment not found.") };
                             }
                         } else if (!IsValidExpression(valuePart, lineNumber)) {
                             ds_list_destroy(declaredVariables);
                             return { Valid: false, Error: errors[array_length(errors)-1] };
                         } else {
                             isValidValue = true;
                         }
                     }
                     if (!isValidValue) {
                         ds_list_destroy(declaredVariables);
                         return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid value '", valuePart, "' for var '", varName, "'.") };
                     }
                     ds_list_add(declaredVariables, varName);
                 } else {
                     ds_list_destroy(declaredVariables);
                     return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid var declaration.") };
                 }
             } else {
                 ds_list_destroy(declaredVariables);
                 return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid var declaration syntax. Expected 'var name = value;'. Found '", line, "'") };
             }
            lastStatementWasIf = false;
            continue;
         }

        var openParen = string_pos("(", line);
        var commandName = "";
        var param = "";
        if (openParen > 0) {
            var closeParen = string_last_pos(")", line);
            if (closeParen > openParen) {
                commandName = string_trim(string_copy(line, 1, openParen - 1));
                param = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
                if (commandName == "") {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Missing command name.") };
                }
                if (global.vars.CommandLibrary[$ string_lower(commandName)] == undefined) {
                    ds_list_destroy(declaredVariables);
                    return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Command '", commandName, "' not found.") };
                }
                if (param != "") {
                    var isNumeric = (string_digits(param) == param);
                    var isString = (string_starts_with(param, "\"") && string_ends_with(param, "\""));
                    var paramOpenParen = string_pos("(", param);
                    var isNestedCall = (paramOpenParen > 0 && string_ends_with(param, ")"));
                    var isVariable = (!isNumeric && !isString && !isNestedCall && string_lettersdigits(param) == param && param != "");
                    var isExpression = (!isNumeric && !isString && !isNestedCall && !isVariable && IsValidExpression(param, lineNumber));
                    if (isVariable) {
                        if (ds_list_find_index(declaredVariables, param) == -1) {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Variable '", param, "' used before declaration.") };
                        }
                    } else if (isNestedCall) {
                        var innerName = string_trim(string_copy(param, 1, paramOpenParen - 1));
                        if (innerName == "" || global.vars.CommandLibrary[$ string_lower(innerName)] == undefined) {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Nested command '", innerName, "' not found.") };
                        }
                    } else if (isString) {
                        var stringValue = string_copy(param, 2, string_length(param) - 2);
                        if (string_pos("\"", stringValue) > 0) {
                            ds_list_destroy(declaredVariables);
                            return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Strings cannot contain double quotes.") };
                        }
                    } else if (!isNumeric && !isExpression) {
                        ds_list_destroy(declaredVariables);
                        return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid parameter format '", param, "'. Not num, str, call, var, or valid expr.") };
                    }
                }
            } else {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Mismatched or missing closing parenthesis for command '", string_copy(line, 1, openParen-1) ,"'.") };
            }
        } else {
            commandName = string_trim(line);
            if (commandName == "") {
                continue;
            }
            if (global.vars.CommandLibrary[$ string_lower(commandName)] == undefined) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Command '", commandName, "' not found.") };
            }
            if (string_lettersdigits(commandName) != commandName) {
                ds_list_destroy(declaredVariables);
                return { Valid: false, Error: string_concat("Line ", string(lineNumber), ": Invalid command name '", commandName, "'.") };
            }
        }

        if (!currentLineIsIfRelated) {
            lastStatementWasIf = false;
        }
    } // End of line loop

    if (array_length(errors) > 0) {
        ds_list_destroy(declaredVariables);
        return { Valid: false, Error: errors[0] };
    }
    if (braceBalance != 0) {
        ds_list_destroy(declaredVariables);
        return { Valid: false, Error: "Syntax Error: Unmatched braces '{}'." };
    }
    if (insideFunction) {
        ds_list_destroy(declaredVariables);
        return { Valid: false, Error: "Syntax Error: Unclosed 'function' block." };
    }
    if (array_length(blockTypeStack) != 0) {
        ds_list_destroy(declaredVariables);
        return { Valid: false, Error: "Syntax Error: Unclosed block (e.g. Repeat, If, Function missing '}')" };
    }

    ds_list_destroy(declaredVariables);
    return { Valid: true, Error: "" };
}