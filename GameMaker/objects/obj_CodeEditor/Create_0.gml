/// @description obj_CodeEditor - Create Event
/// Initializes the code editor with syntax highlighting capabilities.

// Ensure the ScribbleHighlightSyntax function is defined in a separate script asset!

currentFunctionObject = noone;

global.CodeEditor = id;

font = "VCR_OSD_Mono"; // Font used by Scribble

padding = 5;
deleteTimer = 2; // Not used in provided code?
deleteDelay = 15;
deleteRepeatRate = 3;
cursorBlinkRate = 30;
scrollSpeed = 0.2;
textScale = 0.75;
lineHeight = 24 * textScale; // Calculate based on font size and scale
editorWidth = sprite_width * 11.25; // Example size, adjust as needed
editorHeight = sprite_height * 12.75; // Example size, adjust as needed

lines = [""]; // Start with one empty line
cursorLine = 0;
cursorCol = 0;
scrollOffset = 0; // Vertical scroll offset in pixels

// --- Keywords for Highlighting ---
// Base keywords provided by user
var _baseKeywords = ["move", "hotfix", "angle", "function", "var", "if", "else", "for", "while", "return", "true", "false"];
// Format for the ScribbleHighlightSyntax function
// You can add more categories like "types", "constants" if needed
customKeywordsForHighlighter = {
    keywords: _baseKeywords
    // Example: types: ["PlayerState", "Vector2"]
};
// Define colors (can be overridden by passing a struct to ScribbleHighlightSyntax)
colorsForHighlighter = {
    def: "[c_white]",
    command: "[c_aqua]", // For global.vars.CommandLibrary if used
    custom_keywords: "[c_yellow]", // Color for the keywords in customKeywordsForHighlighter.keywords
    number: "[c_lime]",
    string: "[c_green]",
    comment: "[c_gray]"
    // Add other overrides or custom category colors here if needed
};


autocompleteIndex = 0; // For potential autocomplete feature
cursorVisible = true;
cursorTimer = 0;
backspaceHeld = 0;
deleteHeld = 0;

selectionActive = false;
selectionStartLine = 0;
selectionStartCol = 0;
selectionEndLine = 0;
selectionEndCol = 0;

editorSurface = -1; // Surface for drawing the editor onto
funcName = ""; // Name of the function being edited

// --- Event Subscriptions ---
// Assuming 'Subscribe', 'ValidateSyntax', 'CompileCode', 'OpenModalWindow' are defined elsewhere
Subscribe("NewFunctionSlotSelected", function(currentFuncObj) {
    if (currentFuncObj == currentFunctionObject) return;

    currentFunctionObject = currentFuncObj;
    funcName = "";

    // Reset editor state
    lines = [""];
    cursorLine = 0;
    cursorCol = 0;
    scrollOffset = 0;
    // keywords = _baseKeywords; // Reset keywords if they could change per function?
    autocompleteIndex = 0;
    cursorVisible = true;
    cursorTimer = 0;
    backspaceHeld = 0;
    deleteHeld = 0;
    selectionActive = false;
    selectionStartLine = 0;
    selectionStartCol = 0;
    selectionEndLine = 0;
    selectionEndCol = 0;

    // Load script content if it exists
    if (instance_exists(currentFunctionObject) && variable_instance_exists(currentFunctionObject, "functionScript") && currentFunctionObject.functionScript != "")
    {
        // Split script into lines, handling potential CRLF issues
        var _scriptContent = string_replace_all(currentFunctionObject.functionScript, "\r\n", "\n");
        var _loadedLines = string_split(_scriptContent, "\n");
        // Ensure lines array isn't empty if script was just "\n"
        if (array_length(_loadedLines) > 0 || _scriptContent == "\n") {
            lines = _loadedLines;
            // Ensure last line exists if script ended with newline
            if (string_char_at(_scriptContent, string_length(_scriptContent)) == "\n") {
                // array_push(lines, ""); // string_split usually handles this correctly
            }
        } else {
            lines = [""]; // Default to one empty line if split fails
        }
        // Ensure at least one line exists
        if (array_length(lines) == 0) {
            lines = [""];
        }
    } else {
        lines = [""]; // Default if no script
    }
    cursorLine = 0; // Reset cursor pos after loading
    cursorCol = 0;
})

Subscribe("Compiled", function(_id)
{
    var str = "";
    for (var i = 0; i < array_length(lines); i++) {
        var line = lines[i];

        // Find function name (simple parsing)
        if (funcName == "" && string_starts_with(line, "function"))
        {
            // Try to extract name between "function" and "("
            var openParenPos = string_pos("(", line);
            if (openParenPos > 0) {
                var potentialName = string_trim(string_copy(line, 10, openParenPos - 10)); // 10 = length of "function "
                if (potentialName != "") {
                    funcName = potentialName;
                }
            }
        }
        str += lines[i];
        // Add newline except for the very last line
        if (i < array_length(lines) - 1) {
            str += "\n";
        }
    }

    // --- Compilation Logic (Assuming functions exist) ---
    var canCompile = ValidateSyntax(str); // Assuming this returns { Valid: bool, Error: string }
    if (canCompile.Valid)
    {
        var compiledCodeStruct = CompileCode(str); // Assuming this returns compiled code or errors
        if (!variable_struct_exists(compiledCodeStruct, "Errors")) // Check if Errors key is missing (success)
        {
            if (instance_exists(_id)) _id.compiledCode = compiledCodeStruct;
            OpenModalWindow("SUCCESS", "Successfully Compiled Code!");
        }
        else
        {
            if (instance_exists(_id)) _id.compiledCode = undefined;
            for (var i = 0; i < array_length(compiledCodeStruct.Errors); i++) {
                OpenModalWindow("ERROR", compiledCodeStruct.Errors[i]);
            }
        }
    }
    else
    {
        if (instance_exists(_id)) _id.compiledCode = undefined;
        OpenModalWindow("ERROR", canCompile.Error);
    }

    // Update the function slot object
    if (instance_exists(_id)) {
        _id.functionScript = str;
        if (funcName != "") {
            _id.functionName = funcName + "()";
        } else {
            _id.functionName = "MAIN()"; // Default name?
        }
    }
})


// --- Surface Creation ---
// Ensure surface exists (can be recreated in Draw if lost)
if (!surface_exists(editorSurface)) {
    editorSurface = surface_create(editorWidth, editorHeight);
}


// --- Helper Functions (Defined in Create Event in user code) ---
// NOTE: Defining functions here works but is not standard practice.
// Consider moving these to Script assets or using Methods.

/// @function              InsertText(input)
function InsertText(input) {
    if (selectionActive) DeleteSelection();
    var inputLines = string_split(string_replace_all(input, "\r\n", "\n"), "\n"); // Normalize newlines
    var line = lines[cursorLine];
    var firstInputLine = inputLines[0];
    lines[cursorLine] = string_insert(firstInputLine, line, cursorCol + 1);
    cursorCol += string_length(firstInputLine);

    if (array_length(inputLines) > 1) {
        var textAfterCursor = string_copy(lines[cursorLine], cursorCol + 1, string_length(lines[cursorLine]) - cursorCol);
        lines[cursorLine] = string_copy(lines[cursorLine], 1, cursorCol); // Trim current line
        for (var i = 1; i < array_length(inputLines); i++) {
            cursorLine++;
            var lineToInsert = inputLines[i];
            if (i == array_length(inputLines) - 1) { // Last line of paste
                lineToInsert += textAfterCursor;
            }
            array_insert(lines, cursorLine, lineToInsert);
            cursorCol = string_length(inputLines[i]); // Col position depends on pasted line content
        }
    }
    ClampCursorCol();
}

/// @function              NewLine()
function NewLine() {
    if (selectionActive) DeleteSelection();
    var line = lines[cursorLine];
    var left = string_copy(line, 1, cursorCol);
    var right = string_copy(line, cursorCol + 1, string_length(line) - cursorCol);
    // TODO: Add auto-indentation based on previous line?
    lines[cursorLine] = left;
    array_insert(lines, cursorLine + 1, right);
    cursorLine += 1;
    cursorCol = 0; // TODO: Set cursorCol based on auto-indentation?
    ClearSelection();
}

/// @function              Backspace()
function Backspace() {
    if (selectionActive) { DeleteSelection(); return; }
    if (cursorCol > 0) {
        var line = lines[cursorLine];
        lines[cursorLine] = string_delete(line, cursorCol, 1);
        cursorCol -= 1;
    } else if (cursorLine > 0) {
        var prevLine = lines[cursorLine - 1];
        var currentLineContent = lines[cursorLine];
        cursorCol = string_length(prevLine);
        lines[cursorLine - 1] = prevLine + currentLineContent;
        array_delete(lines, cursorLine, 1);
        cursorLine -= 1;
    }
    ClampCursorCol();
    ClearSelection();
}

/// @function              Delete()
function Delete() {
    if (selectionActive) { DeleteSelection(); return; }
    var line = lines[cursorLine];
    var lineLen = string_length(line);
    if (cursorCol < lineLen) {
        lines[cursorLine] = string_delete(line, cursorCol + 1, 1);
    } else if (cursorLine < array_length(lines) - 1) {
        var nextLineContent = lines[cursorLine + 1];
        lines[cursorLine] = line + nextLineContent;
        array_delete(lines, cursorLine + 1, 1);
    }
    ClampCursorCol();
    ClearSelection();
}

/// @function              ClampCursorCol()
function ClampCursorCol() {
    if (cursorLine < 0) cursorLine = 0;
    if (cursorLine >= array_length(lines)) cursorLine = max(0, array_length(lines) - 1);
    // Ensure lines array isn't empty
    if (array_length(lines) == 0) array_push(lines, "");
    // Clamp column based on potentially corrected line index
    cursorCol = clamp(cursorCol, 0, string_length(lines[cursorLine]));
}

/// @function              UpdateSelection(keepAnchor)
function UpdateSelection(keepAnchor) {
    if (!keepAnchor || !selectionActive) {
        selectionStartLine = cursorLine;
        selectionStartCol = cursorCol;
        // selectionActive = true; // Mark active only if start/end differ
    }
    selectionEndLine = cursorLine;
    selectionEndCol = cursorCol;
    selectionActive = (selectionStartLine != selectionEndLine || selectionStartCol != selectionEndCol);
}

/// @function              ClearSelection()
function ClearSelection() {
    selectionActive = false;
    // Resetting points is optional but good practice
    selectionStartLine = cursorLine;
    selectionStartCol = cursorCol;
    selectionEndLine = cursorLine;
    selectionEndCol = cursorCol;
}

/// @function              GetSelectionPoints()
function GetSelectionPoints() {
    var _startL, _startC, _endL, _endC;
    if (selectionStartLine < selectionEndLine || (selectionStartLine == selectionEndLine && selectionStartCol <= selectionEndCol)) {
        _startL = selectionStartLine; _startC = selectionStartCol; _endL = selectionEndLine; _endC = selectionEndCol;
    } else {
        _startL = selectionEndLine; _startC = selectionEndCol; _endL = selectionStartLine; _endC = selectionStartCol;
    }
    return { startL: _startL, startC: _startC, endL: _endL, endC: _endC };
}

/// @function              GetSelectedText()
function GetSelectedText() {
    if (!selectionActive) return "";
    var sel = GetSelectionPoints();
    var result = "";
    for (var i = sel.startL; i <= sel.endL; i++) {
        if (i < 0 || i >= array_length(lines)) continue;
        var line = lines[i];
        var len = string_length(line);
        var copyStart = (i == sel.startL) ? sel.startC : 0;
        var copyEnd = (i == sel.endL) ? sel.endC : len;
        var count = max(0, copyEnd - copyStart);
        if (count > 0) result += string_copy(line, copyStart + 1, count);
        if (i < sel.endL) result += "\n";
    }
    return result;
}

/// @function              DeleteSelection()
function DeleteSelection() {
    if (!selectionActive) return;
    var sel = GetSelectionPoints();
    if (sel.startL < 0 || sel.endL >= array_length(lines)) { ClearSelection(); return; }

    if (sel.startL == sel.endL) {
        var line = lines[sel.startL];
        var before = string_copy(line, 1, sel.startC);
        var after = string_copy(line, sel.endC + 1, string_length(line) - sel.endC);
        lines[sel.startL] = before + after;
    } else {
        var startLine = lines[sel.startL];
        lines[sel.startL] = string_copy(startLine, 1, sel.startC); // Keep text before start
        var endLine = lines[sel.endL];
        var textAfterEnd = string_copy(endLine, sel.endC + 1, string_length(endLine) - sel.endC); // Keep text after end
        lines[sel.startL] += textAfterEnd; // Combine start and end parts
        var linesToDelete = sel.endL - sel.startL;
        for (var i = 0; i < linesToDelete; i++) {
            if (sel.startL + 1 < array_length(lines)) array_delete(lines, sel.startL + 1, 1);
        }
    }
    cursorLine = sel.startL;
    cursorCol = sel.startC;
    ClampCursorCol();
    ClearSelection();
}


// --- Main Logic (Step Event) ---
function Step() {
    // Ensure lines array isn't empty
    if (array_length(lines) == 0) {
        array_push(lines, ""); cursorLine = 0; cursorCol = 0; ClearSelection();
    }

    // Cursor Blinking
    cursorTimer++;
    if (cursorTimer >= cursorBlinkRate) { cursorVisible = !cursorVisible; cursorTimer = 0; }

    // Autocomplete Logic (Simplified - only uses predefined keywords)
    var autocomplete = [];
    // ... (Autocomplete list building logic - currently simplified in user code)

    // Input Handling
    var shiftHeld = keyboard_check(vk_shift);
    var ctrlHeld = keyboard_check(vk_control); // Or vk_command on macOS
    var movedCursor = false;
    var textChanged = false;

    // Typing Input
    if (keyboard_string != "") {
        var input = keyboard_string; keyboard_string = "";
        cursorVisible = true; cursorTimer = 0;
        InsertText(input);
        autocompleteIndex = 0;
        movedCursor = true; textChanged = true;
    }

    // Cursor Movement Keys
    var moveAction = false;
    if (keyboard_check_pressed(vk_up)) { cursorLine = max(cursorLine - 1, 0); moveAction = true; }
    if (keyboard_check_pressed(vk_down)) { cursorLine = min(cursorLine + 1, max(0, array_length(lines) - 1)); moveAction = true; }
    if (keyboard_check_pressed(vk_left)) {
        if (ctrlHeld) { /* Ctrl+Left logic */ }
        else if (selectionActive && !shiftHeld) { var sel = GetSelectionPoints(); cursorLine = sel.startL; cursorCol = sel.startC; ClearSelection(); }
        else { cursorCol = max(cursorCol - 1, 0); }
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_right)) {
        if (ctrlHeld) { /* Ctrl+Right logic */ }
        else if (selectionActive && !shiftHeld) { var sel = GetSelectionPoints(); cursorLine = sel.endL; cursorCol = sel.endC; ClearSelection(); }
        else { cursorCol = min(cursorCol + 1, string_length(lines[cursorLine])); }
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_home)) { cursorCol = 0; moveAction = true; }
    if (keyboard_check_pressed(vk_end)) { cursorCol = string_length(lines[cursorLine]); moveAction = true; }

    if (moveAction) {
        ClampCursorCol();
        if (shiftHeld) UpdateSelection(true);
        else ClearSelection(); // Clear selection if shift wasn't held for the move
        movedCursor = true;
    }

    // Action Keys
    if (keyboard_check_pressed(vk_enter)) { NewLine(); movedCursor = true; textChanged = true; }

    // Backspace
    var backspacePressed = keyboard_check_pressed(vk_backspace);
    var backspaceCheck = keyboard_check(vk_backspace);
    if (backspacePressed || (backspaceCheck && backspaceHeld > deleteDelay && (current_time % (deleteRepeatRate * (1000/60)) < (1000/60)))) { // Frame-based repeat
        if (selectionActive || cursorCol > 0 || cursorLine > 0) { Backspace(); movedCursor = true; textChanged = true; }
        if (backspacePressed) backspaceHeld = 1; else backspaceHeld = deleteDelay - deleteRepeatRate + 1; // Allow immediate repeat
    }
    if (backspaceCheck) { if (!backspacePressed) backspaceHeld++; } else { backspaceHeld = 0; }

    // Delete
    var deletePressed = keyboard_check_pressed(vk_delete);
    var deleteCheck = keyboard_check(vk_delete);
    if (deletePressed || (deleteCheck && deleteHeld > deleteDelay && (current_time % (deleteRepeatRate * (1000/60)) < (1000/60)))) { // Frame-based repeat
        var lineLen = string_length(lines[cursorLine]);
        if (selectionActive || cursorCol < lineLen || cursorLine < array_length(lines) - 1) { Delete(); movedCursor = true; textChanged = true; }
        if (deletePressed) deleteHeld = 1; else deleteHeld = deleteDelay - deleteRepeatRate + 1;
    }
    if (deleteCheck) { if (!deletePressed) deleteHeld++; } else { deleteHeld = 0; }

    // Tab (Simplified: Indent or Autocomplete)
    if (keyboard_check_pressed(vk_tab)) {
        // TODO: Implement proper autocomplete cycling or standard indentation
        InsertText("    "); // Simple 4-space indent for now
        movedCursor = true; textChanged = true;
    }

    // Clipboard
    if (ctrlHeld && keyboard_check_pressed(ord("C"))) { if (selectionActive) clipboard_set_text(GetSelectedText()); else if (cursorLine < array_length(lines)) clipboard_set_text(lines[cursorLine] + "\n"); }
    if (ctrlHeld && keyboard_check_pressed(ord("X"))) { if (selectionActive) { clipboard_set_text(GetSelectedText()); DeleteSelection(); movedCursor = true; textChanged = true; } }
    if (ctrlHeld && keyboard_check_pressed(ord("V"))) { var clipboardText = clipboard_get_text(); if (clipboardText != "") { InsertText(clipboardText); movedCursor = true; textChanged = true; } }

    // Final Updates
    if (movedCursor || textChanged) { cursorVisible = true; cursorTimer = 0; }

    // Scrolling Logic
    var viewHeight = editorHeight - (padding * 2);
    var targetY = cursorLine * lineHeight;
    var targetOffset = scrollOffset; // Keep current offset unless needs changing
    if (targetY >= scrollOffset + viewHeight) { targetOffset = targetY - viewHeight + lineHeight; }
    else if (targetY < scrollOffset) { targetOffset = targetY; }
    scrollOffset = lerp(scrollOffset, targetOffset, scrollSpeed);
    var totalTextHeight = array_length(lines) * lineHeight;
    var maxScrollOffset = max(0, totalTextHeight - viewHeight);
    if (viewHeight < lineHeight) maxScrollOffset = max(0, totalTextHeight - lineHeight);
    scrollOffset = clamp(scrollOffset, 0, maxScrollOffset);
}


// --- Drawing Logic (Draw Event) ---
function Draw() {
    // --- Surface Management ---
    if (!surface_exists(editorSurface)) {
        editorSurface = surface_create(editorWidth, editorHeight);
        if (!surface_exists(editorSurface)) return; // Bail if creation failed
    }
    surface_set_target(editorSurface);
    draw_clear_alpha(c_black, 0.8); // Background

    // --- Calculation for Visible Lines ---
    var viewHeight = editorHeight - (padding * 2);
    var firstVisibleLine = floor(scrollOffset / lineHeight);
    var lastVisibleLine = ceil((scrollOffset + viewHeight) / lineHeight);
    firstVisibleLine = max(0, firstVisibleLine);
    lastVisibleLine = min(array_length(lines) - 1, lastVisibleLine);

    // --- Get Selection Info ---
    var sel = selectionActive ? GetSelectionPoints() : { startL: -1, startC: -1, endL: -1, endC: -1 };

    draw_set_font(VCR_OSD_Mono); // Set font for string_width calculations
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // --- Draw Visible Lines ---
    for (var i = firstVisibleLine; i <= lastVisibleLine; i++) {
        if (i < 0 || i >= array_length(lines)) continue; // Safety check

        var rawLine = lines[i]; // The original line text
        var drawX = padding;
        var drawY = padding + (i * lineHeight) - scrollOffset;

        // --- Draw Selection Background ---
        if (selectionActive && i >= sel.startL && i <= sel.endL) {
            var xStart = drawX;
            var xEnd = drawX;
            var lineLen = string_length(rawLine);

            // Calculate start X pos for selection on this line
            var startColOnLine = (i == sel.startL) ? sel.startC : 0;
            var textBeforeStart = string_copy(rawLine, 1, startColOnLine);
            // Use string_width_ext for accurate width with the correct font and scale
            xStart += string_width_ext(textBeforeStart, -1, -1) * textScale;

            // Calculate end X pos for selection on this line
            var endColOnLine = (i == sel.endL) ? sel.endC : lineLen;
            var textBeforeEnd = string_copy(rawLine, 1, endColOnLine);
            xEnd += string_width_ext(textBeforeEnd, -1, -1) * textScale;

            // Draw the selection rectangle
            draw_set_color(c_dkgray); // Selection color
            draw_set_alpha(0.6);
            draw_rectangle(xStart, drawY, xEnd, drawY + lineHeight, false);
            draw_set_alpha(1); // Reset alpha
            draw_set_color(c_white); // Reset color
        }

        // --- Draw Line with Syntax Highlighting ---
        // Call the highlighter function (ensure it's accessible)
        var highlightedLine = ScribbleHighlightSyntax(rawLine, customKeywordsForHighlighter, colorsForHighlighter);

        // Draw the highlighted line using Scribble
        scribble(highlightedLine)
            .align(fa_left, fa_top)
            .starting_format(font, c_white) // Use the editor's font
            .transform(textScale, textScale, 0) // Apply scaling
            .draw(drawX, drawY);

        // --- Draw Cursor ---
        if (i == cursorLine && cursorVisible && !selectionActive) {
            // Calculate cursor X position based on *unhighlighted* text width
            var textBeforeCursor = string_copy(rawLine, 1, cursorCol);
            // Use string_width_ext for accuracy with scale
            var cursorX = drawX + (string_width_ext(textBeforeCursor, -1, -1) * textScale);

            // Draw a simple cursor line
            draw_set_color(c_white);
            draw_line_width(cursorX, drawY, cursorX, drawY + lineHeight, 1); // Thin line cursor
        }
    } // End loop through visible lines

    // --- Reset Target and Draw Surface ---
    surface_reset_target();
    draw_surface_ext(editorSurface, x - (editorWidth / 2), y - (editorHeight / 2), 1, 1, 0, c_white, 1);
    // draw_self(); // Draw the object's sprite if needed (e.g., editor frame)
}



// --- Cleanup (Clean Up Event) ---
// Make sure to add a Clean Up event to your object!
function CleanUp() {
    // Free the surface memory when the object is destroyed
    if (surface_exists(editorSurface)) {
        surface_free(editorSurface);
    }
}

// --- Event Assignment (In the Object Editor) ---
// Assign the functions/code blocks to the corresponding events:
// Create Event -> Execute Code: Contains Initialization code (variables, surface creation, function definitions)
// Step Event   -> Execute Code: Step();
// Draw Event   -> Execute Code: Draw();
// Clean Up Event-> Execute Code: CleanUp();


