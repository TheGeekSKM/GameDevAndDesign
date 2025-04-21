/// @description Read and write JSON data to/from files safely
/// @param {string} filePath - The path to the file.
/// @param {string} jsonString - The JSON string to write to the file.
function SafeWriteJson(filePath, jsonString)
{
    var tempPath = filePath + ".tmp";

    var file = file_text_open_write(tempPath);
    if (file != -1)
    {
        file_text_write_string(file, jsonString);
        file_text_close(file);

        if (file_exists(tempPath))
        {
            file_delete(filePath); 
            file_rename(tempPath, filePath); 
        }
    }
    else
    {
        show_error("Failed to open file for writing: " + tempPath, true);
    }
}

/// @description Read JSON data from a file safely
/// @param {string} filePath - The path to the file.
/// @returns {object} - The parsed JSON object or undefined if the file doesn't exist or parsing fails.
function SafeReadJson(_path)
{
    if (!file_exists(_path)) {
        return undefined;
    }

    var jsonString = "";
    var file = file_text_open_read(_path);

    while (!file_text_eof(file)) {
        jsonString += file_text_read_string(file);
        file_text_readln(file);
    }

    file_text_close(file);


    // Prevent parse errors by checking if it's empty or corrupted
    if (string_length(jsonString) == 0) {
        show_debug_message("SafeReadJson: JSON string is empty!");
        return undefined;
    }

    var parsedData;

    try {
        parsedData = json_parse(jsonString);
    } catch(e) {
        show_debug_message("SafeReadJson: JSON parse error - " + e.message);
        return undefined;
    }

    return parsedData;
}
