//// Script: CompileCode
/// @function            CompileCode(_code)
/// @description         Compiles raw script code into executable instructions and metadata.
/// @param {String} _code The raw script code to compile.
/// @returns {Struct}    Struct containing { FunctionName, CompiledArray, LineMapping, Cost, Errors (optional) }

function CompileCode(_code) {
    var compiledInstructions = [];
    var memoryCost = 0;
    var instructionToRawLineMap = [];
    var errors = [];

    var lines = string_split(_code, "\n");
    // blockStack entry: { type: "function"|"repeat"|"if"|"elseif"|"else", startInstructionIndex, rawLineNumber,
    //                     hasOpenedBrace: bool,
    //                     if_jump_false_idx: int (for if/elseif),
    //                     if_chain_jump_to_end_indices: array (for if/elseif/else to jump past chain) }
    var blockStack = [];
    var insideFunction = false;
    var functionName = "Main";

    // Helper to add instruction and map line number
    var AddInstruction = function(_instr, _rawLineNum, _cost = 1) {
        array_push(compiledInstructions, _instr);
        array_push(instructionToRawLineMap, _rawLineNum);
        memoryCost += _cost;
    }

    // Helper to patch a jump instruction's offset
    var PatchJumpOffset = function(_instr_idx, _target_instr_idx) {
        if (_instr_idx < 0 || _instr_idx >= array_length(compiledInstructions)) {
            array_push(errors, string_concat("Internal Compiler Error: Invalid instruction index ", string(_instr_idx), " for patching jump."));
            return;
        }
        var instr = compiledInstructions[_instr_idx];
        var offset = _target_instr_idx - _instr_idx; // Relative offset
        // Replace placeholder offset (e.g., -999) with calculated offset
        // Ensure the placeholder is unique enough not to conflict with actual negative offsets if ever used.
        var placeholder = "(-999)";
        if (string_pos(placeholder, instr) > 0) {
            compiledInstructions[_instr_idx] = string_replace(instr, placeholder, string_concat("(", string(offset), ")"));
        } else {
            var openParenPos = string_pos("(", instr);
            var closeParenPos = string_last_pos(")", instr);
            if (openParenPos > 0 && closeParenPos > openParenPos) {
                var instrName = string_copy(instr, 1, openParenPos -1);
                compiledInstructions[_instr_idx] = string_concat(instrName, "(", string(offset), ")");
            } else {
                array_push(errors, string_concat("Internal Compiler Error: Could not find placeholder to patch jump in '", instr, "'."));
            }
        }
    }

    // Helper function to split a string by whitespace, handling multiple spaces
    var _string_split_whitespace_manual = function(_str) {
        var _list = [];
        var _currentWord = "";
        _str = string_trim(_str); // Trim leading/trailing spaces
        for (var _k = 1; _k <= string_length(_str); _k++) {
            var _char = string_char_at(_str, _k);
            if (_char == " " || _char == "\t") { // Space or tab
                if (_currentWord != "") {
                    array_push(_list, _currentWord);
                    _currentWord = "";
                }
            } else {
                _currentWord += _char;
            }
        }
        if (_currentWord != "") { // Add the last word
            array_push(_list, _currentWord);
        }
        return _list;
    }


    // Helper to parse a condition string "op1 operator op2"
    var ParseCondition = function(_conditionStr, _rawLineNum) {
        var parts = _string_split_whitespace_manual(_conditionStr); // Use manual split
        if (array_length(parts) != 3) {
            // Not a simple "op1 operator op2", so return undefined to let ExpressionToRPN handle it
            return undefined;
        }
        var op1 = parts[0];
        var operator = parts[1];
        var op2 = parts[2];
        var op1_type = "invalid", op1_val = op1;
        var op2_type = "invalid", op2_val = op2;

        // Determine op1 type
        if (op1 == "[result]") { op1_type = "result"; op1_val = "[result]"; }
        else if (string_digits(op1) == op1 && op1 != "") { op1_type = "number"; op1_val = op1;}
        else if (string_lettersdigits(op1) == op1 && (string_char_at(op1,1) >= "a" && string_char_at(op1,1) <= "z" || string_char_at(op1,1) >= "A" && string_char_at(op1,1) <= "Z")) { op1_type = "lookup"; op1_val = op1; }
        else { return undefined; } // Not a simple operand

        // Determine op2 type
        if (op2 == "[result]") { op2_type = "result"; op2_val = "[result]"; } // Though [result] as op2 is less common
        else if (string_digits(op2) == op2 && op2 != "") { op2_type = "number"; op2_val = op2; }
        else if (string_lettersdigits(op2) == op2 && (string_char_at(op2,1) >= "a" && string_char_at(op2,1) <= "z" || string_char_at(op2,1) >= "A" && string_char_at(op2,1) <= "Z")) { op2_type = "lookup"; op2_val = op2; }
        else { return undefined; } // Not a simple operand

        // Validate operator
        var valid_ops = ["==", "!=", ">", "<", ">=", "<="];
        if (array_get_index(valid_ops, operator) == -1) {
            array_push(errors, string_concat("Line ", string(_rawLineNum), ": Invalid operator '", operator, "' in simple condition."));
            return undefined;
        }
        return string_concat("EvalCond(", op1_type, ":", op1_val, ",", operator, ",", op2_type, ":", op2_val, ")");
    }

    // Helper to convert array to string for debugging (GML doesn't have array_toString)
    var _array_to_debug_string = function(arr) {
        var str = "[";
        for (var k = 0; k < array_length(arr); k++) {
            str += string(arr[k]);
            if (k < array_length(arr) - 1) {
                str += ", ";
            }
        }
        str += "]";
        return str;
    }

    // --- Helper for Shunting-Yard Algorithm (Simplified) ---
    var ExpressionToRPNInstructions = function(_exprStr, _rawLineNum) {
        var outputQueue = []; // Stores RPN tokens (operands or operator instructions)
        var operatorStack = []; // Stores operators and parentheses
        var tokens = []; // Stores tokenized expression (numbers, variables, operators, parens)

        // Basic Tokenizer (can be made more robust)
        var i = 0;
        while (i < string_length(_exprStr)) {
            var char = string_char_at(_exprStr, i + 1);
            if (char == " " || char == "\t") { i++; continue; } // Skip whitespace

            // Check if previous token was an operator or opening parenthesis
            var prev_token_was_operator_or_paren = false;
            if (array_length(tokens) > 0) {
                var _last_token = tokens[array_length(tokens)-1];
                if (_last_token == "(" || _last_token == "+" || _last_token == "-" || _last_token == "*" || _last_token == "/") {
                    prev_token_was_operator_or_paren = true;
                }
            }

            // Number (handles negative at start/after operator or parenthesis)
            if (string_digits(char) == char ||
                (char == "-" &&
                 (array_length(tokens) == 0 || prev_token_was_operator_or_paren) && // Previous token was an operator or '(' or start
                 i + 1 < string_length(_exprStr) && string_digits(string_char_at(_exprStr, i + 2)) == string_char_at(_exprStr, i + 2) // Next char is a digit
                )
               )
            {
                var numStr = char;
                // If it's a unary minus, consume it and the following digits
                if (char == "-" && (array_length(tokens) == 0 || prev_token_was_operator_or_paren)) {
                    i++; // Move past '-'
                    if (i < string_length(_exprStr)) {
                        char = string_char_at(_exprStr, i + 1);
                        if (string_digits(char) != char) { // Ensure it's a digit after unary minus
                             array_push(errors, string_concat("Line ", string(_rawLineNum), ": Invalid character '", char, "' after unary minus in expression '", _exprStr, "'. Expected digit."));
                             return undefined;
                        }
                        numStr += char; // Add first digit
                    } else { // Ends with unary minus
                         array_push(errors, string_concat("Line ", string(_rawLineNum), ": Expression ends with unary minus in '", _exprStr, "'."));
                         return undefined;
                    }
                }
                // Continue consuming digits for the number
                while (i + 1 < string_length(_exprStr) && string_digits(string_char_at(_exprStr, i + 2)) == string_char_at(_exprStr, i + 2)) {
                    i++;
                    numStr += string_char_at(_exprStr, i + 1);
                }
                array_push(tokens, numStr);
            } else if (string_letters(char) == char || char == "[") { // Variable or [result]
                var identifier = char;
                if (char == "[") { // Potentially [result]
                    while (i + 1 < string_length(_exprStr) && string_char_at(_exprStr, i + 2) != "]") {
                        i++;
                        identifier += string_char_at(_exprStr, i + 1);
                    }
                    if (i + 1 < string_length(_exprStr) && string_char_at(_exprStr, i + 2) == "]") { // Found closing bracket
                        i++;
                        identifier += "]";
                    } else { // Unclosed bracket
                        array_push(errors, string_concat("Line ", string(_rawLineNum), ": Unclosed '[' in expression '", _exprStr, "'."));
                        return undefined;
                    }
                } else { // Regular identifier (variable)
                    while (i + 1 < string_length(_exprStr) && string_lettersdigits(string_char_at(_exprStr, i + 2)) == string_char_at(_exprStr, i + 2)) {
                        i++;
                        identifier += string_char_at(_exprStr, i + 1);
                    }
                }

                if (identifier == "[result]") {
                    array_push(tokens, "[result]");
                } else if (string_lettersdigits(identifier) == identifier && (string_char_at(identifier,1) >= "a" && string_char_at(identifier,1) <= "z" || string_char_at(identifier,1) >= "A" && string_char_at(identifier,1) <= "Z")) {
                    var peek_next_char_idx = i + 1;
                    if (peek_next_char_idx < string_length(_exprStr) && string_char_at(_exprStr, peek_next_char_idx + 1) == "(") {
                        array_push(errors, string_concat("Line ", string(_rawLineNum), ": Direct function calls like '",identifier,"()' inside complex arithmetic expressions are not supported. Assign to a variable or use [result]."));
                        return undefined;
                    }
                    array_push(tokens, identifier); // Variable
                } else if (identifier != "[result]") { // Catch other invalid identifiers
                    array_push(errors, string_concat("Line ", string(_rawLineNum), ": Invalid identifier '", identifier, "' in expression '", _exprStr, "'."));
                    return undefined;
                }

            } else if (char == "(" || char == ")") {
                array_push(tokens, char);
            } else if (char == "+" || char == "-" || char == "*" || char == "/") {
                array_push(tokens, char);
            } else {
                array_push(errors, string_concat("Line ", string(_rawLineNum), ": Unknown character '", char, "' in expression '", _exprStr, "'."));
                return undefined; // Error
            }
            i++;
        }
        show_debug_message(string_concat("Tokens for '",_exprStr,"': ", _array_to_debug_string(tokens)));


        // Shunting-Yard Algorithm
        var precedence = function(op) {
            if (op == "+" || op == "-") return 1;
            if (op == "*" || op == "/") return 2;
            return 0;
        }
        var associativity = function(op) { // All our ops are left-associative
            return "L";
        }

        for (var t = 0; t < array_length(tokens); t++) {
            var token = tokens[t];
            if (string_digits(token) == token || (string_starts_with(token, "-") && string_length(token) > 1 && string_digits(string_copy(token, 2, string_length(token) - 1)) == string_copy(token, 2, string_length(token) - 1) ) ) { // Number
                array_push(outputQueue, string_concat("PushNum(", token, ")"));
            } else if (token == "[result]") { // Handle [result] as an operand
                 array_push(outputQueue, "PushResult");
            } else if (string_lettersdigits(token) == token) { // Variable
                 array_push(outputQueue, string_concat("PushVar(", token, ")"));
            } else if (token == "(") {
                array_push(operatorStack, token);
            } else if (token == ")") {
                while (array_length(operatorStack) > 0 && operatorStack[array_length(operatorStack) - 1] != "(") {
                    var op = array_pop(operatorStack);
                    if (op == "+") array_push(outputQueue, "OpAdd");
                    else if (op == "-") array_push(outputQueue, "OpSubtract");
                    else if (op == "*") array_push(outputQueue, "OpMultiply");
                    else if (op == "/") array_push(outputQueue, "OpDivide");
                }
                if (array_length(operatorStack) == 0) { array_push(errors, string_concat("Line ", string(_rawLineNum), ": Mismatched parentheses in expression '", _exprStr, "'.")); return undefined; }
                array_pop(operatorStack); // Pop the "("
            } else { // Operator
                while (array_length(operatorStack) > 0 && operatorStack[array_length(operatorStack) - 1] != "(" &&
                       (precedence(operatorStack[array_length(operatorStack) - 1]) > precedence(token) ||
                        (precedence(operatorStack[array_length(operatorStack) - 1]) == precedence(token) && associativity(token) == "L"))) {
                    var op = array_pop(operatorStack);
                    if (op == "+") array_push(outputQueue, "OpAdd");
                    else if (op == "-") array_push(outputQueue, "OpSubtract");
                    else if (op == "*") array_push(outputQueue, "OpMultiply");
                    else if (op == "/") array_push(outputQueue, "OpDivide");
                }
                array_push(operatorStack, token);
            }
        }

        while (array_length(operatorStack) > 0) {
            var op = array_pop(operatorStack);
            if (op == "(") { array_push(errors, string_concat("Line ", string(_rawLineNum), ": Mismatched parentheses in expression '", _exprStr, "'.")); return undefined; }
            if (op == "+") array_push(outputQueue, "OpAdd");
            else if (op == "-") array_push(outputQueue, "OpSubtract");
            else if (op == "*") array_push(outputQueue, "OpMultiply");
            else if (op == "/") array_push(outputQueue, "OpDivide");
        }
        show_debug_message(string_concat("RPN for '",_exprStr,"': ", _array_to_debug_string(outputQueue)));
        return outputQueue;
    }
    // --- End of Shunting-Yard Helper ---


    for (var i = 0; i < array_length(lines); i++) {
        var rawLineNumber = i + 1;
        var line = string_trim(lines[i]);

        if (line == "" || string_starts_with(line, "//")) {
            continue;
        }

        if (string_starts_with(line, "function")) {
            if (insideFunction) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Cannot define function inside another function."));
                continue;
            }
            var nameStart = string_pos("function ", line) + 9;
            var parenPos = string_pos("(", line);
            if (nameStart > 9 && parenPos > nameStart) {
                functionName = string_trim(string_copy(line, nameStart, parenPos - nameStart));
                if (functionName == "") {
                    array_push(errors, string_concat("Line ", string(rawLineNumber), ": Function name empty."));
                }
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid function syntax."));
                functionName = "InvalidFunction";
            }
            insideFunction = true;
            array_push(blockStack, { type: "function", startInstructionIndex: array_length(compiledInstructions), rawLineNumber: rawLineNumber, hasOpenedBrace: false, if_chain_jump_to_end_indices: [] });
            continue;
        }

        if (string_starts_with(line, "var ")) {
             var parts = string_split(line, "=");
             if (array_length(parts) == 2) {
                 var declarationPart = string_trim(parts[0]);
                 var valuePart = string_trim(string_replace(parts[1], ";", ""));
                 if (string_starts_with(declarationPart, "var ")) {
                     var varName = string_trim(string_copy(declarationPart, 5, string_length(declarationPart) - 4));
                     if (varName != "" && (string_char_at(varName, 1) >= "a" && string_char_at(varName, 1) <= "z" || string_char_at(varName, 1) >= "A" && string_char_at(varName, 1) <= "Z")) {
                         if (string_digits(valuePart) == valuePart && valuePart != "") {
                             AddInstruction(string_concat("DeclareVar(", varName, ",", valuePart, ")"), rawLineNumber);
                         } else {
                             var valOpenParen = string_pos("(", valuePart);
                             var valCloseParen = string_last_pos(")", valuePart);
                             if (valOpenParen > 0 && valCloseParen == string_length(valuePart) && string_pos_ext(" ", valuePart, valOpenParen) == 0 && string_pos_ext("+", valuePart, 0) == 0 && string_pos_ext("-", valuePart, 0) == 0 && string_pos_ext("*", valuePart, 0) == 0 && string_pos_ext("/", valuePart, 0) == 0 && (string_pos_ext(")", valuePart, valCloseParen-1) == 0 || valCloseParen == string_length(valuePart)) ) {
                                 var funcNamePart = string_trim(string_copy(valuePart, 1, valOpenParen - 1));
                                 if (funcNamePart != "" && string_lettersdigits(funcNamePart) == funcNamePart) {
                                     AddInstruction(valuePart, rawLineNumber, GetInstructionMemoryCost(valuePart));
                                     AddInstruction(string_concat("AssignVar(", varName, ",[result])"), rawLineNumber);
                                 } else {
                                     array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid func name '", funcNamePart, "' in var assignment."));
                                 }
                             } else {
                                 var rpnInstructions = ExpressionToRPNInstructions(valuePart, rawLineNumber);
                                 if (rpnInstructions != undefined) {
                                     for (var rpn_idx = 0; rpn_idx < array_length(rpnInstructions); rpn_idx++) {
                                         AddInstruction(rpnInstructions[rpn_idx], rawLineNumber, GetInstructionMemoryCost(rpnInstructions[rpn_idx]));
                                     }
                                     AddInstruction(string_concat("AssignFromStack(", varName, ")"), rawLineNumber);
                                 }
                             }
                         }
                     } else {
                         array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid var name '", varName, "'."));
                     }
                 } else {
                     array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid var declaration."));
                 }
             } else {
                 array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid var declaration. Expected 'var name = value;'."));
             }
            continue;
        }

        if (string_starts_with(line, "Repeat(")) {
            var openParen = string_pos("(", line);
            var closeParen = string_last_pos(")", line);
            var repeatParam = "";
            var compiledRepeatStart = "";
            if (openParen > 0 && closeParen > openParen) {
                repeatParam = string_trim(string_copy(line, openParen + 1, closeParen - openParen - 1));
                var repeatParamType = "invalid";
                if (string_digits(repeatParam) == repeatParam && repeatParam != "") {
                    if (real(repeatParam) > 0) {
                        compiledRepeatStart = string_concat("RepeatStart(number:", repeatParam, ",jump_offset:-999)");
                    } else {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Repeat amount must be positive."));
                    }
                } else {
                    var paramOpenParen = string_pos("(", repeatParam);
                    var paramCloseParen = string_last_pos(")", repeatParam);
                    if (paramOpenParen > 0 && paramCloseParen == string_length(repeatParam) && string_pos_ext(" ", repeatParam, paramOpenParen) == 0 && string_pos_ext("+", repeatParam, 0) == 0 && string_pos_ext("-", repeatParam, 0) == 0 && string_pos_ext("*", repeatParam, 0) == 0 && string_pos_ext("/", repeatParam, 0) == 0) {
                        var innerCmdName = string_trim(string_copy(repeatParam, 1, paramOpenParen - 1));
                        if (innerCmdName != "" && string_lettersdigits(innerCmdName) == innerCmdName) {
                            AddInstruction(repeatParam, rawLineNumber, GetInstructionMemoryCost(repeatParam));
                            compiledRepeatStart = string_concat("RepeatStart(result:[result],jump_offset:-999)");
                        } else {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call in Repeat '", repeatParam, "'."));
                        }
                    } else if (string_lettersdigits(repeatParam) == repeatParam && (string_char_at(repeatParam,1) >= "a" && string_char_at(repeatParam,1) <= "z" || string_char_at(repeatParam,1) >= "A" && string_char_at(repeatParam,1) <= "Z")) {
                        compiledRepeatStart = string_concat("RepeatStart(lookup:", repeatParam, ",jump_offset:-999)");
                    } else {
                        var rpnInstructions = ExpressionToRPNInstructions(repeatParam, rawLineNumber);
                        if (rpnInstructions != undefined) {
                            for (var rpn_idx = 0; rpn_idx < array_length(rpnInstructions); rpn_idx++) {
                                AddInstruction(rpnInstructions[rpn_idx], rawLineNumber, GetInstructionMemoryCost(rpnInstructions[rpn_idx]));
                            }
                            compiledRepeatStart = string_concat("RepeatStart(expr_result:[expr_result],jump_offset:-999)");
                        } else {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid expression '", repeatParam, "' for Repeat."));
                        }
                    }
                }
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid Repeat syntax."));
            }
            if (compiledRepeatStart != "") {
                var repeatStartIndex = array_length(compiledInstructions);
                AddInstruction(compiledRepeatStart, rawLineNumber);
                array_push(blockStack, { type: "repeat", startInstructionIndex: repeatStartIndex, rawLineNumber: rawLineNumber, hasOpenedBrace: false, if_chain_jump_to_end_indices: [] });
            }
            continue;
        }

        if (string_starts_with(line, "if (") && string_ends_with(line, ")")) {
            var conditionStr = string_trim(string_copy(line, 4, string_length(line) - 4 -1));
            var evalCondInstr = ParseCondition(conditionStr, rawLineNumber);
            var jumpFalseIdx = -1;
            var rpnInstructionsForIf = undefined;

            if (evalCondInstr != undefined) {
                AddInstruction(evalCondInstr, rawLineNumber);
                jumpFalseIdx = array_length(compiledInstructions);
                AddInstruction("JumpFalse(-999)", rawLineNumber);
            } else {
                rpnInstructionsForIf = ExpressionToRPNInstructions(conditionStr, rawLineNumber);
                if (rpnInstructionsForIf != undefined) {
                    for (var rpn_idx = 0; rpn_idx < array_length(rpnInstructionsForIf); rpn_idx++) {
                        AddInstruction(rpnInstructionsForIf[rpn_idx], rawLineNumber, GetInstructionMemoryCost(rpnInstructionsForIf[rpn_idx]));
                    }
                    jumpFalseIdx = array_length(compiledInstructions);
                    AddInstruction("JumpFalseFromStack(-999)", rawLineNumber);
                } else {
                    array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid condition expression in 'if': ", conditionStr));
                    continue;
                }
            }
            if (jumpFalseIdx != -1) {
                var instructionsAddedForCond = (evalCondInstr != undefined) ? 1 : array_length(rpnInstructionsForIf);
                array_push(blockStack, { type: "if", startInstructionIndex: array_length(compiledInstructions) - (instructionsAddedForCond + 1), rawLineNumber: rawLineNumber, hasOpenedBrace: false, if_jump_false_idx: jumpFalseIdx, if_chain_jump_to_end_indices: [] });
            }
            continue;
        }

        if (string_starts_with(line, "else if (") && string_ends_with(line, ")")) {
            if (array_length(blockStack) == 0 || (blockStack[array_length(blockStack)-1].type != "if" && blockStack[array_length(blockStack)-1].type != "elseif")) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": 'else if' without preceding 'if'/'else if'."));
                continue;
            }
            var prevIfData = blockStack[array_length(blockStack)-1];
            var jumpToEndChainIdx = array_length(compiledInstructions);
            AddInstruction("Jump(-999)", prevIfData.rawLineNumber);
            array_push(prevIfData.if_chain_jump_to_end_indices, jumpToEndChainIdx);
            if (prevIfData.if_jump_false_idx != -1) {
                PatchJumpOffset(prevIfData.if_jump_false_idx, array_length(compiledInstructions));
            }

            var conditionStr = string_trim(string_copy(line, 9, string_length(line) - 9 -1));
            var evalCondInstr = ParseCondition(conditionStr, rawLineNumber);
            var jumpFalseIdx = -1;
            var rpnInstructionsForElseIf = undefined;

            if (evalCondInstr != undefined) {
                AddInstruction(evalCondInstr, rawLineNumber);
                jumpFalseIdx = array_length(compiledInstructions);
                AddInstruction("JumpFalse(-999)", rawLineNumber);
            } else {
                rpnInstructionsForElseIf = ExpressionToRPNInstructions(conditionStr, rawLineNumber);
                if (rpnInstructionsForElseIf != undefined) {
                    for (var rpn_idx = 0; rpn_idx < array_length(rpnInstructionsForElseIf); rpn_idx++) {
                        AddInstruction(rpnInstructionsForElseIf[rpn_idx], rawLineNumber, GetInstructionMemoryCost(rpnInstructionsForElseIf[rpn_idx]));
                    }
                    jumpFalseIdx = array_length(compiledInstructions);
                    AddInstruction("JumpFalseFromStack(-999)", rawLineNumber);
                } else {
                    array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid condition expression in 'else if': ", conditionStr));
                    continue;
                }
            }
            if (jumpFalseIdx != -1) {
                var oldIfData = array_pop(blockStack);
                var instructionsAddedForCond = (evalCondInstr != undefined) ? 1 : array_length(rpnInstructionsForElseIf);
                array_push(blockStack, { type: "elseif", startInstructionIndex: array_length(compiledInstructions) - (instructionsAddedForCond + 1), rawLineNumber: rawLineNumber, hasOpenedBrace: false, if_jump_false_idx: jumpFalseIdx, if_chain_jump_to_end_indices: oldIfData.if_chain_jump_to_end_indices });
            }
            continue;
        }

        if (line == "else") {
            if (array_length(blockStack) == 0 || (blockStack[array_length(blockStack)-1].type != "if" && blockStack[array_length(blockStack)-1].type != "elseif")) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": 'else' without preceding 'if'/'else if'."));
                continue;
            }
            var prevIfData = blockStack[array_length(blockStack)-1];
            var jumpToEndChainIdx = array_length(compiledInstructions);
            AddInstruction("Jump(-999)", prevIfData.rawLineNumber);
            array_push(prevIfData.if_chain_jump_to_end_indices, jumpToEndChainIdx);
            if (prevIfData.if_jump_false_idx != -1) {
                PatchJumpOffset(prevIfData.if_jump_false_idx, array_length(compiledInstructions));
            }
            var oldIfData = array_pop(blockStack);
            array_push(blockStack, { type: "else", startInstructionIndex: array_length(compiledInstructions), rawLineNumber: rawLineNumber, hasOpenedBrace: false, if_chain_jump_to_end_indices: oldIfData.if_chain_jump_to_end_indices, if_jump_false_idx: -1 });
            continue;
        }

        if (line == "{") {
            if (array_length(blockStack) == 0) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected '{'."));
                continue;
            }
            var currentActiveBlock = blockStack[array_length(blockStack) - 1];
            if (variable_struct_exists(currentActiveBlock, "hasOpenedBrace") && currentActiveBlock.hasOpenedBrace) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected '{' - block already opened."));
                continue;
            }
            currentActiveBlock.hasOpenedBrace = true;
            continue;
        }

        if (line == "}") {
            if (array_length(blockStack) == 0) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Unexpected '}}'."));
                continue;
            }
            var closingBlock = array_pop(blockStack);
            if (!variable_struct_exists(closingBlock, "hasOpenedBrace") || !closingBlock.hasOpenedBrace) {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": '}}' does not match opened block."));
                continue;
            }
            if (closingBlock.type == "repeat") {
                var repeatStartIndex = closingBlock.startInstructionIndex;
                var jumpBackOffset = array_length(compiledInstructions) - repeatStartIndex;
                AddInstruction(string_concat("RepeatEnd(jump_offset:", string(jumpBackOffset), ")"), rawLineNumber);
                var jumpForwardOffset = array_length(compiledInstructions) - 1 - repeatStartIndex;
                var repeatStartInstr = compiledInstructions[repeatStartIndex];
                var jumpPlaceholderPos = string_pos(",jump_offset:-999", repeatStartInstr);
                if (jumpPlaceholderPos > 0) {
                    var instructionBase = string_copy(repeatStartInstr, 1, jumpPlaceholderPos);
                    compiledInstructions[repeatStartIndex] = string_concat(instructionBase, "jump_offset:", string(jumpForwardOffset), ")");
                } else {
                    array_push(errors, string_concat("Line ", string(closingBlock.rawLineNumber), ": Compiler Error: Could not patch RepeatStart offset."));
                }
            } else if (closingBlock.type == "function") {
                insideFunction = false;
                var currentInstructionPointer = array_length(compiledInstructions);
                for(var j=0; j < array_length(closingBlock.if_chain_jump_to_end_indices); j++) {
                    PatchJumpOffset(closingBlock.if_chain_jump_to_end_indices[j], currentInstructionPointer);
                }
                if (closingBlock.if_jump_false_idx != undefined && closingBlock.if_jump_false_idx != -1) {
                    PatchJumpOffset(closingBlock.if_jump_false_idx, currentInstructionPointer);
                }
            } else if (closingBlock.type == "if" || closingBlock.type == "elseif") {
                var currentInstructionPointer = array_length(compiledInstructions);
                var isFollowedByElseOrElseIf = false;
                if (i + 1 < array_length(lines)) {
                    var nextLineTrimmed = string_trim(lines[i+1]);
                    if (string_starts_with(nextLineTrimmed, "else if (") || nextLineTrimmed == "else") {
                        isFollowedByElseOrElseIf = true;
                    }
                }
                if (!isFollowedByElseOrElseIf) {
                    if (closingBlock.if_jump_false_idx != -1) {
                        PatchJumpOffset(closingBlock.if_jump_false_idx, currentInstructionPointer);
                    }
                    for(var j=0; j < array_length(closingBlock.if_chain_jump_to_end_indices); j++) {
                        PatchJumpOffset(closingBlock.if_chain_jump_to_end_indices[j], currentInstructionPointer);
                    }
                    closingBlock.if_chain_jump_to_end_indices = [];
                }

                if (array_length(blockStack) > 0) {
                    var parentBlock = blockStack[array_length(blockStack)-1];
                    if (parentBlock.type == "if" || parentBlock.type == "elseif" || parentBlock.type == "else" || parentBlock.type == "function") {
                         for(var j=0; j < array_length(closingBlock.if_chain_jump_to_end_indices); j++) {
                             array_push(parentBlock.if_chain_jump_to_end_indices, closingBlock.if_chain_jump_to_end_indices[j]);
                         }
                    }
                }
            } else if (closingBlock.type == "else") {
                var currentInstructionPointer = array_length(compiledInstructions);
                for(var j=0; j < array_length(closingBlock.if_chain_jump_to_end_indices); j++) {
                    PatchJumpOffset(closingBlock.if_chain_jump_to_end_indices[j], currentInstructionPointer);
                }
                if (array_length(blockStack) > 0) {
                    var parentBlock = blockStack[array_length(blockStack)-1];
                     if (parentBlock.type == "if" || parentBlock.type == "elseif" || parentBlock.type == "else" || parentBlock.type == "function") {
                          parentBlock.if_chain_jump_to_end_indices = [];
                     }
                }
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": '}}' for unexpected block '", closingBlock.type, "'."));
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
                if (command == "") {
                    array_push(errors, string_concat("Line ", string(rawLineNumber), ": Missing command name."));
                    continue;
                }
                if (param == "") {
                    compiledLine = string_concat(command, "()");
                } else if (string_digits(param) == param) {
                    compiledLine = string_concat(command, "(", param, ")");
                } else if (string_starts_with(param, "\"") && string_ends_with(param, "\"")) {
                    var strVal = string_copy(param, 2, string_length(param) - 2);
                    if (string_pos("\"", strVal) == 0) {
                        compiledLine = string_concat(command, "(string:", strVal, ")");
                        memoryCost += string_length(strVal);
                    } else {
                        array_push(errors, string_concat("Line ", string(rawLineNumber), ": Strings cannot contain \". '", param, "'."));
                        compiledLine = string_concat(command, "(invalid_param)");
                    }
                } else {
                    var paramOpenParen = string_pos("(", param);
                    var paramCloseParen = string_last_pos(")", param);
                    if (paramOpenParen > 0 && paramCloseParen == string_length(param) && string_pos_ext(" ", param, paramOpenParen) == 0 && string_pos_ext("+", param, 0) == 0 && string_pos_ext("-", param, 0) == 0 && string_pos_ext("*", param, 0) == 0 && string_pos_ext("/", param, 0) == 0) {
                        var innerCmdName = string_trim(string_copy(param, 1, paramOpenParen - 1));
                        if (innerCmdName != "" && string_lettersdigits(innerCmdName) == innerCmdName) {
                            AddInstruction(param, rawLineNumber, GetInstructionMemoryCost(param));
                            compiledLine = string_concat(command, "([result])");
                        } else {
                            array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid nested call '", param, "'."));
                            compiledLine = string_concat(command, "(invalid_param)");
                        }
                    } else if (string_lettersdigits(param) == param && (string_char_at(param,1) >= "a" && string_char_at(param,1) <= "z" || string_char_at(param,1) >= "A" && string_char_at(param,1) <= "Z")) {
                        compiledLine = string_concat(command, "(lookup:", param, ")");
                    } else {
                        var rpnInstructions = ExpressionToRPNInstructions(param, rawLineNumber);
                        if (rpnInstructions != undefined) {
                            for (var rpn_idx = 0; rpn_idx < array_length(rpnInstructions); rpn_idx++) {
                                AddInstruction(rpnInstructions[rpn_idx], rawLineNumber, GetInstructionMemoryCost(rpnInstructions[rpn_idx]));
                            }
                            compiledLine = string_concat(command, "([expr_result])");
                        } else {
                            compiledLine = string_concat(command, "(invalid_param)");
                        }
                    }
                }
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Mismatched parens for '", string_copy(line, 1, openParen-1) ,"'."));
                continue;
            }
        } else {
            command = string_trim(line);
            if (command == "") {
                continue;
            }
            if (string_lettersdigits(command) == command) {
                compiledLine = command;
            } else {
                array_push(errors, string_concat("Line ", string(rawLineNumber), ": Invalid command name '", command, "'."));
                continue;
            }
        }
        if (compiledLine != "") {
            AddInstruction(compiledLine, rawLineNumber, (!string_ends_with(compiledLine, "([result])") && !string_ends_with(compiledLine, "([expr_result])") ? GetInstructionMemoryCost(compiledLine) : 1));
        }
    } // End of line loop

    // After all lines, resolve any remaining jumps for unclosed if/elseif chains
    while(array_length(blockStack) > 0) {
        var lastBlock = array_pop(blockStack);
        if (lastBlock.type == "if" || lastBlock.type == "elseif") {
            if (lastBlock.if_jump_false_idx != -1) {
                PatchJumpOffset(lastBlock.if_jump_false_idx, array_length(compiledInstructions));
            }
            for(var j=0; j < array_length(lastBlock.if_chain_jump_to_end_indices); j++) {
                PatchJumpOffset(lastBlock.if_chain_jump_to_end_indices[j], array_length(compiledInstructions));
            }
        } else if (lastBlock.type == "function" || lastBlock.type == "repeat") {
            array_push(errors, string_concat("Compilation Error: Unclosed '", lastBlock.type, "' block starting near line ", string(lastBlock.rawLineNumber), ". Missing '}'."));
        }
    }

    if (array_length(errors) > 0) {
        return { Errors: errors };
    } else {
        return {
            FunctionName: functionName,
            CompiledArray: compiledInstructions,
            LineMapping: instructionToRawLineMap,
            Cost: memoryCost,
            Errors: undefined
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
