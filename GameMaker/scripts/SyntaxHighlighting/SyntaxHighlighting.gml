/// @function                ScribbleHighlightSyntax(rawCode, [customKeywords], [colors], [caseSensitive])
/// @description             Parses a raw code string and returns a new string formatted with Scribble color tags for syntax highlighting, using standard GameMaker colors.
/// @param {String} rawCode The raw string of code to highlight.
/// @param {Struct} [customKeywords] Optional. A struct where keys are category names (e.g., "functions", "types") and values are arrays of keywords for that category.
///                                   Example: { functions: ["create_enemy", "player_jump"], types: ["EnemyState", "Vector2"] }
/// @param {Struct} [colors] Optional. A struct mapping element types to Scribble color tags using GameMaker c_* constants.
///                          Overrides default colors. Supported keys: "default", "command", "custom_[category]", "number", "string", "comment".
///                          Example: { command: "[c_red]", custom_functions: "[c_dkgray]" }
/// @param {Boolean} [caseSensitive] Optional. Whether keyword matching for customKeywords should be case-sensitive. CommandLibrary check is always case-insensitive. Defaults to true for customKeywords.
/// @returns {String}        The formatted string with Scribble color tags.

function ScribbleHighlightSyntax(rawCode, customKeywords = {}, colors = {}, caseSensitive = true) {

    // --- Argument Defaults & Color Setup (Using Standard GameMaker c_* Constants) ---
    var defaultColors = {
        // Note: Renamed 'def' back to 'default' as it's more standard and was likely a typo in the user's provided code.
        def: "[c_white]",
        command: "[c_aqua]",    // Color for global.vars.CommandLibrary keywords
        // Default colors for potential custom categories
        custom_functions: "[c_yellow]",
        custom_types: "[c_fuchsia]",
        custom_constants: "[c_purple]",
        custom_other: "[c_olive]",   // Fallback for unmapped custom categories
        number: "[c_lime]",
        string: "[c_green]",
        comment: "[c_gray]"
    };

    // Merge provided colors with defaults
    var finalColors = {};
    var defaultKeys = variable_struct_get_names(defaultColors);
    for (var i = 0; i < array_length(defaultKeys); i++) {
        var key = defaultKeys[i];
        // Use provided color if it exists, otherwise use the default
        finalColors[$ key] = variable_struct_exists(colors, key) ? colors[$ key] : defaultColors[$ key];
    }
    // Add any extra custom colors provided by the user (e.g., for specific custom_ categories not in defaults)
    var userColorKeys = variable_struct_get_names(colors);
    for (var i = 0; i < array_length(userColorKeys); i++) {
        var key = userColorKeys[i];
        if (!variable_struct_exists(finalColors, key)) {
            finalColors[$ key] = colors[$ key];
        }
    }

    // Use the correct key for the default color tag
    var colDefault = finalColors.def;

    // --- Helper Function to Process Words ---
    // Renamed back from static ProcessWord as it was defined inside another function in user code.
    // If this function is moved outside ScribbleHighlightSyntax later, 'static' can be added.
    var ProcessWord = function(word, customKwStruct, colsStruct, caseSens) {
        if (word == "") return ""; // Skip empty words

        // wordToCheck respects case sensitivity for custom keywords
        var wordToCheck = caseSens ? word : string_lower(word);
        var colorTag = ""; // The Scribble tag to apply (e.g., "[c_aqua]")

        // 1. Check global commands (Case-Insensitive) <<<< MODIFIED SECTION >>>>
        if (variable_global_exists("vars") && is_struct(global.vars) && variable_struct_exists(global.vars, "CommandLibrary") && is_struct(global.vars.CommandLibrary)) {
            var _cmdLibKeys = variable_struct_get_names(global.vars.CommandLibrary);
            var _wordLower = string_lower(word); // Always compare lowercase word for commands
            for (var k = 0; k < array_length(_cmdLibKeys); k++) {
                // Compare lowercase word to lowercase key from CommandLibrary
                if (_wordLower == string_lower(_cmdLibKeys[k])) {
                    colorTag = colsStruct.command;
                    break; // Found match, stop checking keys
                }
            }
        }

        // 2. Check custom keywords if no global command match
        // This check *still respects* the 'caseSens' parameter passed to the main function
        if (colorTag == "") {
            var customCategories = variable_struct_get_names(customKwStruct);
            for (var i = 0; i < array_length(customCategories); i++) {
                var cat = customCategories[i];
                var kwArray = customKwStruct[$ cat];
                if (is_array(kwArray)) {
                    for (var j = 0; j < array_length(kwArray); j++) {
                        var kw = kwArray[j];
                        // kwToCheck respects case sensitivity based on the 'caseSens' parameter
                        var kwToCheck = caseSens ? kw : string_lower(kw);
                        // Compare wordToCheck (respects caseSens) with kwToCheck (respects caseSens)
                        if (wordToCheck == kwToCheck) {
                            var customColorKey = "custom_" + cat;
                            colorTag = variable_struct_exists(colsStruct, customColorKey) ? colsStruct[$ customColorKey] : colsStruct.custom_other;
                            break;
                        }
                    }
                }
                if (colorTag != "") break;
            }
        }

        // 3. Check for numbers if not a keyword
        if (colorTag == "" && is_string(word)) {
            var firstChar = string_char_at(word, 1);
            var secondChar = string_length(word) > 1 ? string_char_at(word, 2) : "";
            if (string_digits(firstChar) != "" || (firstChar == "-" && string_digits(secondChar) != "")) {
                if (is_real(real(word))) { // Check if it can be converted to a real number
                    colorTag = colsStruct.number;
                }
            }
        }


        // Return word with or without color tags
        if (colorTag != "") {
            /
            return colorTag + word + colsStruct.def; // Use the original 'word' casing for display
        } else {
            return word;
        }
    } 

    // --- Main Parsing Logic (Character by Character) ---
    var result = colDefault; // Start with default color
    var currentWord = "";
    var state = "default"; // "default", "in_string", "line_comment"
    var stringChar = ""; // Stores '"' or "'"
    var codeLen = string_length(rawCode);
    var i = 1; // GML strings are 1-based

    while (i <= codeLen) {
        var char = string_char_at(rawCode, i);
        var nextChar = (i + 1 <= codeLen) ? string_char_at(rawCode, i + 1) : "";

        switch (state) {
            // --- Default State ---
            case "default":
                // Check for Line Comment Start "//"
                if (char == "/" && nextChar == "/") {
                    result += ProcessWord(currentWord, customKeywords, finalColors, caseSensitive); // Process word before comment
                    currentWord = "";
                    result += finalColors.comment + "//"; // Add comment color and slashes
                    state = "line_comment";
                    i += 2; // Skip both slashes
                    continue; // Go to next loop iteration
                }
                // Check for String Start " or '
                else if (char == "\"" || char == "'") {
                    result += ProcessWord(currentWord, customKeywords, finalColors, caseSensitive); // Process word before string
                    currentWord = "";
                    stringChar = char;
                    result += finalColors.string + char; // Add string color and the quote
                    state = "in_string";
                }
                // Check for Delimiters/Whitespace (customize this set as needed)
                else if (string_pos(char, " \t\n\r(){}[].,;:=+-*/<>!&|#") > 0) {
                    result += ProcessWord(currentWord, customKeywords, finalColors, caseSensitive); // Process word before delimiter
                    currentWord = "";
                    result += char; // Add the delimiter itself (inherits default color)
                }
                // Otherwise, it's part of a word
                else {
                    currentWord += char;
                }
                break;

            // --- In String State ---
            case "in_string":
                result += char; // Add character to result (already has string color)
                // Check for escape character (simple version: ignore next char if backslash)
                if (char == "\\") {
                    i++; // Skip the next character entirely
                    if (i <= codeLen) {
                        result += string_char_at(rawCode, i); // Add the escaped character
                    }
                }
                // Check for end of string
                else if (char == stringChar) {
                    result += colDefault; // Reset color
                    state = "default";
                }
                break;

            // --- In Line Comment State ---
            case "line_comment":
                result += char; // Add character to result (already has comment color)
                // Check for end of line
                if (char == "\n" || char == "\r") { // Check for both CR and LF
                    result += colDefault; // Reset color
                    state = "default";
                    // Handle CRLF sequence correctly
                    if (char == "\r" && nextChar == "\n") {
                        i++; // Skip the upcoming LF
                        result += "\n";
                    }
                }
                break;

        } 

        i++; // Move to next character

    } 

    // Process any remaining word after the loop finishes
    if (currentWord != "") {
        result += ProcessWord(currentWord, customKeywords, finalColors, caseSensitive);
    }

    // Ensure the final state resets color if needed (e.g., unterminated string/comment)
    if (state != "default") {
        result += colDefault;
    }

    return result;
} 




