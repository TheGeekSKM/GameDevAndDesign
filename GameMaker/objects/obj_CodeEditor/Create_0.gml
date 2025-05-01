currentFunctionObject = noone;



global.CodeEditor = id;

font = "VCR_OSD_Mono";

padding = 5;
deleteTimer = 2;
deleteDelay = 15;
deleteRepeatRate = 3;
cursorBlinkRate = 30;
scrollSpeed = 0.2;
textScale = 0.75;
lineHeight = 24 * textScale;
editorWidth = sprite_width * 11.25;
editorHeight = sprite_height * 12.75;

lines = [""];
cursorLine = 0;
cursorCol = 0;
scrollOffset = 0;
keywords = ["move", "hotfix", "angle", "function", "var", "if", "else", "for", "while", "return", "true", "false"];
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

editorSurface = -1;
funcName = "";

Subscribe("NewFunctionSlotSelected", function(currentFuncObj) {
    if (currentFuncObj == currentFunctionObject) return;
    
    currentFunctionObject = currentFuncObj;
    funcName = "";
    
    lines = [""];
    cursorLine = 0;
    cursorCol = 0;
    scrollOffset = 0;
    keywords = ["move", "hotfix", "angle", "function", "var", "if", "else", "for", "while", "return", "true", "false"];
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
    
    if (currentFunctionObject.functionScript != "")
    {
        var _lines = string_split(currentFunctionObject.functionScript, "\n");
        for (var i = 0; i < array_length(_lines); i++) {
            lines[i] = _lines[i];
        } 
    }
})

Subscribe("Compiled", function(_id) 
{
    var str = ""; 
    for (var i = 0; i < array_length(lines); i++) {
        var line = lines[i];
        
        if (funcName == "" && string_starts_with(line, "function"))
        {
            var splitString = string_split_ext(line, [" ", "(", ")"])
            if (array_length(splitString) > 1) 
            {
                funcName = splitString[1];
            }
        }
        str = string_concat(str, lines[i], "\n");
    }
    
    var canCompile = ValidateSyntax(str);
    if (canCompile.Valid)
    {
        var compiledCodeStruct = CompileCode(str);
        if (compiledCodeStruct.Errors == undefined)
        {
            _id.compiledCode = compiledCodeStruct;
            OpenModalWindow("SUCCESS", "Successfully Compiled Code!")
        }
        else 
        {
            _id.compiledCode = undefined;
            for (var i = 0; i < array_length(compiledCodeStruct.Errors); i++) {
                OpenModalWindow("ERROR", compiledCodeStruct.Errors[i]);
            }
        }
    }
    else 
    {
        _id.compiledCode = undefined;
        OpenModalWindow("ERROR", canCompile.Error);
    }
    
    _id.functionScript = str;
    
    if (funcName != "")
    {
        _id.functionName = funcName + "()";
    }
    else {
        _id.functionName = "MAIN()";
    }
})


if (!surface_exists(editorSurface)) {
    editorSurface = surface_create(editorWidth, editorHeight);
}


// --- Helper Functions ---

/// @function            InsertText(input)
/// @description         Inserts text at the current cursor position, deleting selection if active.
/// @param {String} input The text string to insert.
function InsertText(input) {
    // If text is selected, delete it first
    if (selectionActive) {
        DeleteSelection();
    }

    // Split input text by newline characters to handle multi-line pastes
    var inputLines = string_split(input, "\n");

    // Get the current line
    var line = lines[cursorLine];

    // Insert the first part of the input into the current line
    lines[cursorLine] = string_insert(inputLines[0], line, cursorCol + 1);
    cursorCol += string_length(inputLines[0]);

    // If there are more lines in the input (multi-line paste)
    if (array_length(inputLines) > 1) {
        // Get the part of the current line that comes *after* the insertion point
        // Note: String indices are 1-based, cursorCol is 0-based index *before* char
        var textAfterCursor = string_copy(lines[cursorLine], cursorCol + 1, string_length(lines[cursorLine]) - cursorCol);
        // Trim the current line to only the part *before* the insertion point
        lines[cursorLine] = string_copy(lines[cursorLine], 1, cursorCol);

        // Insert the remaining lines from the input
        for (var i = 1; i < array_length(inputLines); i++) {
            cursorLine++;
            // The last line of the pasted content needs the textAfterCursor appended
            if (i == array_length(inputLines) - 1) {
                array_insert(lines, cursorLine, inputLines[i] + textAfterCursor);
                cursorCol = string_length(inputLines[i]); // Cursor at the end of the inserted part
            } else {
                array_insert(lines, cursorLine, inputLines[i]);
                cursorCol = string_length(inputLines[i]); // Cursor at the end of the full inserted line
            }
        }
    }
    ClampCursorCol(); // Ensure cursor column is valid after insertion
}


/// @function            NewLine()
/// @description         Inserts a new line break at the cursor position, deleting selection if active.
function NewLine() {
    // If text is selected, delete it first
    if (selectionActive) {
        DeleteSelection();
    }

    var line = lines[cursorLine];
    var left = string_copy(line, 1, cursorCol); // Text before cursor
    var right = string_copy(line, cursorCol + 1, string_length(line) - cursorCol); // Text after cursor

    lines[cursorLine] = left; // Update current line
    array_insert(lines, cursorLine + 1, right); // Insert new line with the text that was after the cursor
    cursorLine += 1;
    cursorCol = 0; // Move cursor to the beginning of the new line

    ClearSelection(); // A newline insertion clears any selection
}


/// @function            Backspace()
/// @description         Deletes the character before the cursor or merges lines, or deletes selection.
function Backspace() {
    // If text is selected, delete it
    if (selectionActive) {
        DeleteSelection();
        return; // Deleting selection is the only action
    }

    // If not at the beginning of the line, delete the character to the left
    if (cursorCol > 0) {
        var line = lines[cursorLine];
        lines[cursorLine] = string_delete(line, cursorCol, 1);
        cursorCol -= 1;
    }
    // If at the beginning of a line (but not the first line), merge with the previous line
    else if (cursorLine > 0) {
        var prevLine = lines[cursorLine - 1];
        var currentLineContent = lines[cursorLine];

        cursorCol = string_length(prevLine); // Move cursor to the end of the previous line
        lines[cursorLine - 1] = prevLine + currentLineContent; // Append current line content
        array_delete(lines, cursorLine, 1); // Delete the current line array element
        cursorLine -= 1; // Move cursor line index up
    }
    ClampCursorCol(); // Ensure cursor column is valid
    ClearSelection(); // Backspace clears selection
}

/// @function            Delete()
/// @description         Deletes the character after the cursor or merges lines, or deletes selection.
function Delete() {
    // If text is selected, delete it
    if (selectionActive) {
        DeleteSelection();
        return; // Deleting selection is the only action
    }

    var line = lines[cursorLine];
    var lineLen = string_length(line);

    // If not at the end of the line, delete the character to the right
    if (cursorCol < lineLen) {
        lines[cursorLine] = string_delete(line, cursorCol + 1, 1);
    }
    // If at the end of a line (but not the last line), merge with the next line
    else if (cursorLine < array_length(lines) - 1) {
        var nextLineContent = lines[cursorLine + 1];
        lines[cursorLine] = line + nextLineContent; // Append next line content to current line
        array_delete(lines, cursorLine + 1, 1); // Delete the next line array element
    }
    ClampCursorCol(); // Ensure cursor column is valid (shouldn't change here, but good practice)
    ClearSelection(); // Delete clears selection
}


/// @function            ClampCursorCol()
/// @description         Ensures the cursor column is within the valid range for the current line.
function ClampCursorCol() {
    if (cursorLine >= 0 && cursorLine < array_length(lines)) {
        cursorCol = clamp(cursorCol, 0, string_length(lines[cursorLine]));
    } else {
        // Handle potential errors if cursorLine is somehow out of bounds
        cursorLine = clamp(cursorLine, 0, max(0, array_length(lines) - 1));
        cursorCol = 0;
        if (array_length(lines) == 0) array_push(lines, ""); // Ensure there's at least one line
        if (cursorLine < array_length(lines)) { // Check again after potential fix
            cursorCol = clamp(cursorCol, 0, string_length(lines[cursorLine]));
        }
    }
}


/// @function            UpdateSelection(keepAnchor)
/// @description         Updates the selection end point based on the current cursor position.
/// @param {Bool} keepAnchor If true, keeps the original selection start point. If false, starts a new selection.
function UpdateSelection(keepAnchor) {
    if (!keepAnchor || !selectionActive) {
        // Start a new selection or reset if Shift is not held
        selectionStartLine = cursorLine;
        selectionStartCol = cursorCol;
        selectionActive = true; // Mark selection as potentially starting
    }

    // Always update the end point
    selectionEndLine = cursorLine;
    selectionEndCol = cursorCol;

    // Ensure selection is marked active only if start and end points differ
    selectionActive = (selectionStartLine != selectionEndLine || selectionStartCol != selectionEndCol);
}


/// @function            ClearSelection()
/// @description         Clears the current text selection.
function ClearSelection() {
    selectionActive = false;
    selectionStartLine = 0;
    selectionStartCol = 0;
    selectionEndLine = 0;
    selectionEndCol = 0;
}

/// @function            GetSelectionPoints()
/// @description         Gets the selection start and end points in the correct order (top-left to bottom-right).
/// @returns {Struct}    A struct containing { startL, startC, endL, endC }
function GetSelectionPoints() {
    var _startL, _startC, _endL, _endC;

    // Determine which point comes first (top-left)
    if (selectionStartLine < selectionEndLine || (selectionStartLine == selectionEndLine && selectionStartCol <= selectionEndCol)) {
        _startL = selectionStartLine;
        _startC = selectionStartCol;
        _endL = selectionEndLine;
        _endC = selectionEndCol;
    } else {
        _startL = selectionEndLine;
        _startC = selectionEndCol;
        _endL = selectionStartLine;
        _endC = selectionStartCol;
    }
    return { startL: _startL, startC: _startC, endL: _endL, endC: _endC };
}


/// @function            GetSelectedText()
/// @description         Returns the currently selected text.
/// @returns {String}    The selected text, including newlines.
function GetSelectedText() {
    if (!selectionActive) return "";

    var sel = GetSelectionPoints();
    var result = "";

    for (var i = sel.startL; i <= sel.endL; i++) {
        // Basic bounds check for safety
        if (i < 0 || i >= array_length(lines)) continue;

        var line = lines[i];
        var len = string_length(line);
        var copyStart = 0; // 0-based index
        var copyEnd = len;   // 0-based index (position *after* last char)

        if (i == sel.startL) {
            copyStart = sel.startC;
        }
        if (i == sel.endL) {
            copyEnd = sel.endC;
        }

        var count = max(0, copyEnd - copyStart); // Calculate number of characters
        if (count > 0) {
            // string_copy is 1-based, so add 1 to copyStart
            result += string_copy(line, copyStart + 1, count);
        }

        // Add newline character if not the last line of the selection
        if (i < sel.endL) {
            result += "\n";
        }
    }
    return result;
}


/// @function            DeleteSelection()
/// @description         Deletes the currently selected text and positions the cursor.
function DeleteSelection() {
    if (!selectionActive) return;

    var sel = GetSelectionPoints();

    // Basic bounds check for safety
    if (sel.startL < 0 || sel.endL >= array_length(lines)) {
        ClearSelection();
        return;
    }

    // Special case: Selection within a single line
    if (sel.startL == sel.endL) {
        var line = lines[sel.startL];
        // string_copy is 1-based
        var before = string_copy(line, 1, sel.startC);
        var after = string_copy(line, sel.endC + 1, string_length(line) - sel.endC);
        lines[sel.startL] = before + after;
    }
    // Multi-line selection
    else {
        // Modify the start line: keep text before selection start
        var startLine = lines[sel.startL];
        lines[sel.startL] = string_copy(startLine, 1, sel.startC);

        // Get text after selection end on the end line
        var endLine = lines[sel.endL];
        var textAfterEnd = string_copy(endLine, sel.endC + 1, string_length(endLine) - sel.endC);

        // Concatenate the start line part with the end line part
        lines[sel.startL] += textAfterEnd;

        // Delete lines between start and end (exclusive of start, inclusive of end)
        var linesToDelete = sel.endL - sel.startL;
        // Delete from higher index to lower index to avoid shifting issues
        for (var i = 0; i < linesToDelete; i++) {
            // Always delete the line *after* the modified start line's original index
            // Check bounds before deleting
            if (sel.startL + 1 < array_length(lines)) {
                array_delete(lines, sel.startL + 1, 1);
            }
        }
    }

    // Move cursor to the start of the deleted selection
    cursorLine = sel.startL;
    cursorCol = sel.startC;

    ClampCursorCol(); // Ensure cursor is valid
    ClearSelection(); // Selection is now gone
}


// --- Main Logic (Step Event) ---

function Step() {
    // --- Defensive Check ---
    // Ensure there's always at least one line, even if empty
    if (array_length(lines) == 0) {
        array_push(lines, "");
        cursorLine = 0;
        cursorCol = 0;
        ClearSelection(); // Clear selection if lines were reset
    }

    // --- Cursor Blinking ---
    cursorTimer++;
    if (cursorTimer >= cursorBlinkRate) {
        cursorVisible = !cursorVisible;
        cursorTimer = 0;
    }

    // --- Autocomplete Logic ---
    var lineSoFar = string_copy(lines[cursorLine], 1, cursorCol);
    var lastSpaceIndex = string_last_index_of(lineSoFar, " ");
    var base = (lastSpaceIndex > 0) 
        ? string_copy(lineSoFar, lastSpaceIndex + 1, cursorCol - lastSpaceIndex) 
        : lineSoFar;
    
    // Build autocomplete list from current word only
    var autocomplete = [];
    for (var i = 0; i < array_length(keywords); i++) {
        if (string_starts_with(keywords[i], base) && base != "") {
            array_push(autocomplete, keywords[i]);
        }
    }

    // --- Input Handling ---
    var shiftHeld = keyboard_check(vk_shift);
    var ctrlHeld = keyboard_check(vk_control);


    var movedCursor = false; // Flag to track if cursor moved this step
    var textChanged = false; // Flag to track if text content changed

    if (keyboard_check(vk_anykey))
    {
        // --- Basic Typing ---
        if (keyboard_string != "") {
            var input = keyboard_string;
            keyboard_string = ""; // Consume the input
    
            // Reset cursor blink on typing
            cursorVisible = true;
            cursorTimer = 0;
    
            InsertText(input); // Handles selection deletion internally
            autocompleteIndex = 0; // Reset autocomplete on typing
            movedCursor = true; // Typing moves the cursor implicitly
            textChanged = true;
            // Clear selection handled by InsertText
        }
    }

    // --- Cursor Movement Keys ---
    var moveAction = false;
    if (keyboard_check_pressed(vk_up)) {
        cursorLine = max(cursorLine - 1, 0);
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_down)) {
        cursorLine = min(cursorLine + 1, array_length(lines) - 1);
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_left)) {
        if (ctrlHeld) { // Ctrl + Left: Move to beginning of previous word
            var line = lines[cursorLine];
            var foundWordBoundary = false;
            // Search backwards from cursorCol - 1
            for (var i = cursorCol - 1; i >= 0; i--) {
                var char = string_char_at(line, i + 1);
                var prevChar = (i > 0) ? string_char_at(line, i) : " "; // Treat start of line as space
                // Boundary is space followed by non-space, or start of line
                if ((char != " " && prevChar == " ") || (i == 0 && char != " ")) {
                    cursorCol = i; // Move to the start of the word/line start
                    // Adjust if we landed on the space *before* the word
                    if (prevChar == " " && i > 0) cursorCol = i + 1;
                    foundWordBoundary = true;
                    break;
                }
            }
            // If no word boundary found moving left, move to start of line
            if (!foundWordBoundary) {
                cursorCol = 0;
            }
        } else {
            // Normal left arrow: If selection active and shift not held, move to start of selection
            if (selectionActive && !shiftHeld) {
                var sel = GetSelectionPoints();
                cursorLine = sel.startL;
                cursorCol = sel.startC;
                ClearSelection();
            } else {
                cursorCol = max(cursorCol - 1, 0);
            }
        }
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_right)) {
        if (ctrlHeld) { // Ctrl + Right: Move to beginning of next word
            var line = lines[cursorLine];
            var lineLen = string_length(line);
            var foundWordBoundary = false;
            // Search forwards from cursorCol
            for (var i = cursorCol; i < lineLen; i++) {
                var char = string_char_at(line, i + 1);
                var nextChar = (i < lineLen - 1) ? string_char_at(line, i + 2) : " "; // Treat end of line as space
                // Boundary is non-space followed by space, or end of line
                if ((char != " " && nextChar == " ") || (i == lineLen - 1 && char != " ")) {
                    cursorCol = i + 1; // Move to the position *after* the word (start of space/next word/end)
                    // Skip any further spaces immediately after
                    while (cursorCol < lineLen && string_char_at(line, cursorCol + 1) == " ") {
                        cursorCol++;
                    }
                    foundWordBoundary = true;
                    break;
                }
            }
            // If no word boundary found moving right, move to end of line
            if (!foundWordBoundary) {
                cursorCol = lineLen;
            }
        } else {
            // Normal right arrow: If selection active and shift not held, move to end of selection
            if (selectionActive && !shiftHeld) {
                var sel = GetSelectionPoints();
                cursorLine = sel.endL;
                cursorCol = sel.endC;
                ClearSelection();
            } else {
                cursorCol = min(cursorCol + 1, string_length(lines[cursorLine]));
            }
        }
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_home)) { // Home key
        cursorCol = 0;
        moveAction = true;
    }
    if (keyboard_check_pressed(vk_end)) { // End key
        cursorCol = string_length(lines[cursorLine]);
        moveAction = true;
    }

    // After any movement action, clamp cursor column and update selection
    if (moveAction) {
        ClampCursorCol();
        if (shiftHeld) {
            UpdateSelection(true); // Extend selection
        } else {
            // Only clear selection if it was a non-shift move
            if (!keyboard_check(vk_shift)) { // Double check shift wasn't pressed *during* the action check
                ClearSelection();
            }
        }
        movedCursor = true; // Mark cursor as moved
    }


    // --- Action Keys ---

    // Enter -> new line
    if (keyboard_check_pressed(vk_enter)) {
        NewLine(); // Handles selection deletion internally
        movedCursor = true;
        textChanged = true;
        // Clear selection handled by NewLine
    }

    // Backspace -> delete character/selection/merge line
    var backspacePressed = keyboard_check_pressed(vk_backspace);
    var backspaceCheck = keyboard_check(vk_backspace);
    if (backspacePressed || (backspaceCheck && backspaceHeld > deleteDelay && (game_get_speed(gamespeed_fps) % deleteRepeatRate == 0))) {
        // Only perform action if there's something to delete or merge
        if (selectionActive || cursorCol > 0 || cursorLine > 0) {
            Backspace(); // Handles selection deletion internally
            movedCursor = true;
            textChanged = true;
            // Clear selection handled by Backspace
        }
        // Reset hold timer on action, even if nothing happened (prevents rapid useless calls)
        if (backspacePressed) backspaceHeld = 1; else backspaceHeld = deleteDelay - deleteRepeatRate; // Allow immediate repeat after first hold action
    }
    // Handle backspace hold timing
    if (backspaceCheck) {
        if (!backspacePressed) backspaceHeld++; // Increment only if held, not on initial press
    } else {
        backspaceHeld = 0;
    }


    // Delete key -> delete character/selection/merge line
    var deletePressed = keyboard_check_pressed(vk_delete);
    var deleteCheck = keyboard_check(vk_delete);
    if (deletePressed || (deleteCheck && deleteHeld > deleteDelay && (game_get_speed(gamespeed_fps) % deleteRepeatRate == 0))) {
        // Only perform action if there's something to delete or merge
        var lineLen = string_length(lines[cursorLine]);
        if (selectionActive || cursorCol < lineLen || cursorLine < array_length(lines) - 1) {
            Delete(); // Handles selection deletion internally
            movedCursor = true; // Cursor doesn't visually move, but logically it might have (merging lines)
            textChanged = true;
            // Clear selection handled by Delete
        }
        // Reset hold timer on action
        if (deletePressed) deleteHeld = 1; else deleteHeld = deleteDelay - deleteRepeatRate;
    }
    // Handle delete hold timing
    if (deleteCheck) {
        if (!deletePressed) deleteHeld++; // Increment only if held
    } else {
        deleteHeld = 0;
    }
    
    // Autocomplete -> complete word
    if (keyboard_check_pressed(vk_tab)) {
        if (array_length(autocomplete) > 0) {
            // Cycle through autocomplete options
            autocompleteIndex = autocompleteIndex mod array_length(autocomplete);
            lines[cursorLine] = autocomplete[autocompleteIndex];
            cursorCol = string_length(lines[cursorLine]);
            autocompleteIndex += 1;
        }
        else {
            // No autocomplete? Insert 4 spaces at cursor
            var currentLine = lines[cursorLine];
            var before = string_copy(currentLine, 1, cursorCol);
            var after  = string_copy(currentLine, cursorCol + 1, string_length(currentLine) - cursorCol);
    
            lines[cursorLine] = before + "  " + after;
            cursorCol += 4;
        }
        movedCursor = true;
        textChanged = true;
    }

    // --- Clipboard Operations ---

    // Copy (Ctrl+C or Cmd+C)
    if (ctrlHeld && keyboard_check_pressed(ord("C"))) {
        if (selectionActive) {
            var selectedText = GetSelectedText();
            clipboard_set_text(selectedText);
        } else {
            // Optional: Copy the entire current line if nothing is selected
             if (cursorLine >= 0 && cursorLine < array_length(lines)) {
                 clipboard_set_text(lines[cursorLine] + "\n");
             }
        }
    }

    // Cut (Ctrl+X or Cmd+X)
    if (ctrlHeld && keyboard_check_pressed(ord("X"))) {
        if (selectionActive) {
            var selectedText = GetSelectedText();
            clipboard_set_text(selectedText);
            DeleteSelection(); // Delete after copying
            movedCursor = true;
            textChanged = true;
        }
    }

    // Paste (Ctrl+V or Cmd+V)
    if (ctrlHeld && keyboard_check_pressed(ord("V"))) {
        var clipboardText = clipboard_get_text();
        if (clipboardText != "") {
            InsertText(clipboardText); // Handles selection deletion internally
            movedCursor = true;
            textChanged = true;
        }
    }

    // --- Final Updates for the Step ---

    // Reset cursor blink if it moved or text changed
    if (movedCursor || textChanged) {
        cursorVisible = true;
        cursorTimer = 0;
    }

    // --- Scrolling Logic ---
    var viewHeight = editorHeight - (padding * 2); // Use surface height for calculation
    var targetY = cursorLine * lineHeight; // Target Y pos of the top of the cursor's line

    // Scroll down if cursor is below the viewable area
    if (targetY >= scrollOffset + viewHeight) {
        // Need to scroll down. Target offset should put the cursor line just above the bottom.
        var targetOffset = targetY - viewHeight + lineHeight;
        scrollOffset = lerp(scrollOffset, targetOffset, scrollSpeed);
    }
    // Scroll up if cursor is above the viewable area
    else if (targetY < scrollOffset) {
        // Need to scroll up. Target offset should put the cursor line at the top.
        var targetOffset = targetY;
        scrollOffset = lerp(scrollOffset, targetOffset, scrollSpeed);
    }
    // Ensure scrollOffset doesn't go negative or too far down
    var totalTextHeight = array_length(lines) * lineHeight;
    var maxScrollOffset = max(0, totalTextHeight - viewHeight);
    // Add a little buffer if viewHeight is less than lineHeight
    if (viewHeight < lineHeight) maxScrollOffset = max(0, totalTextHeight - lineHeight);

    scrollOffset = clamp(scrollOffset, 0, maxScrollOffset);

}


// --- Drawing Logic (Draw Event) ---

function Draw() {
    if (!surface_exists(editorSurface)) {
        editorSurface = surface_create(editorWidth, editorHeight);
        if (!surface_exists(editorSurface)) return;
    }

    surface_set_target(editorSurface);
    draw_clear_alpha(c_black, 0.8);

    var viewHeight = editorHeight - (padding * 2);
    var firstVisibleLine = floor(scrollOffset / lineHeight);
    var lastVisibleLine = ceil((scrollOffset + viewHeight) / lineHeight);
    firstVisibleLine = max(0, firstVisibleLine);
    lastVisibleLine = min(array_length(lines) - 1, lastVisibleLine);

    var sel = selectionActive ? GetSelectionPoints() : { startL: -1, startC: -1, endL: -1, endC: -1 };

    for (var i = firstVisibleLine; i <= lastVisibleLine; i++) {
        if (i < 0 || i >= array_length(lines)) continue;

        var line = lines[i];
        var drawX = padding;
        var drawY = padding + (i * lineHeight) - scrollOffset;

        // --- Draw Selection Background ---
        if (selectionActive && i >= sel.startL && i <= sel.endL) {
            var xStart = drawX;
            var xEnd = drawX;

            if (i == sel.startL) {
                var txt = string_copy(line, 1, sel.startC);
                xStart += string_width(txt) * textScale;
            }
            if (i == sel.endL) {
                var txt = string_copy(line, 1, sel.endC);
                xEnd += string_width(txt) * textScale;
            } else {
                xEnd += string_width(line) * textScale;
            }

            draw_set_color(c_dkgray);
            draw_set_alpha(0.6);
            draw_rectangle(xStart, drawY, xEnd, drawY + lineHeight, false);
            draw_set_alpha(1);
        }

        // --- Draw Line with Syntax Highlighting ---
        var words = string_split(line, " ");
        var charIndex = 0;
        var currentX = drawX;
        var cursorDrawn = false;

        for (var j = 0; j < array_length(words); j++) {
            var word = words[j];
            var wordLength = string_length(word);
            var isKeyword = array_contains(keywords, word);
            var color = isKeyword ? c_yellow : c_white;

            // --- Draw Cursor Inline If Needed ---
            if (!cursorDrawn && i == cursorLine && cursorVisible && !selectionActive && cursorCol >= charIndex && cursorCol <= charIndex + wordLength) {
                var relCol = cursorCol - charIndex;
                var partial = string_copy(word, 1, relCol);

                var partialScrib = scribble(partial)
                    .align(fa_left, fa_top)
                    .starting_format("VCR_OSD_Mono", color)
                    .transform(textScale, textScale, 0);

                var cursorX = currentX + partialScrib.get_width() * textScale;
                scribble("|")
                    .align(fa_left, fa_top)
                    .starting_format("VCR_OSD_Mono", c_white)
                    .transform(textScale, textScale, 0)
                    .draw(cursorX - 1, drawY);

                cursorDrawn = true;
            }

            // --- Draw Word ---
            scribble(word)
                .align(fa_left, fa_top)
                .starting_format("VCR_OSD_Mono", color)
                .transform(textScale, textScale, 0)
                .draw(currentX, drawY);

            // Move X forward
            var scrib = scribble(word)
                .align(fa_left, fa_top)
                .starting_format("VCR_OSD_Mono", c_white)
                .transform(textScale, textScale, 0);
            currentX += scrib.get_width() * textScale;

            // Space between words
            if (j < array_length(words) - 1) {
                var space = " ";
                scribble(space)
                    .align(fa_left, fa_top)
                    .starting_format("VCR_OSD_Mono", c_white)
                    .transform(textScale, textScale, 0)
                    .draw(currentX, drawY);
                currentX += scribble(space).get_width() * textScale;
            }

            charIndex += wordLength + 1;
        }

        // --- Draw Cursor at End of Line ---
        if (!cursorDrawn && i == cursorLine && cursorVisible && !selectionActive && cursorCol == string_length(line)) {
            var lineScrib = scribble(line)
                .align(fa_left, fa_top)
                .starting_format("VCR_OSD_Mono", c_white)
                .transform(textScale, textScale, 0);

            var cursorX = drawX + lineScrib.get_width() * textScale;
            scribble("|")
                .align(fa_left, fa_top)
                .starting_format(font, c_white)
                .transform(textScale, textScale, 0)
                .draw(cursorX - 1, drawY);
        }
    }

    surface_reset_target();
    //draw_surface(editorSurface, x - (editorWidth / 2), y - (editorHeight / 2));
    draw_surface_ext(editorSurface, x - (editorWidth / 2), y - (editorHeight / 2), 1, 1, 0, c_white, 1)
    draw_self();
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
// Create Event -> Execute Code: Contains Initialization code (variables, surface creation)
// Step Event   -> Execute Code: Step();
// Draw Event   -> Execute Code: Draw();
// Clean Up Event-> Execute Code: CleanUp();


