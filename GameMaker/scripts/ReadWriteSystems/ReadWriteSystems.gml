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

        // Rename the temp file to the original file name
        if (file_exists(tempPath))
        {
            file_delete(filePath); // Delete the original file if it exists
            file_rename(tempPath, filePath); // Rename temp to original
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
function SafeReadJson(filePath)
{
    var waitTime = 1000; // Time to wait in milliseconds
    var startTime = current_time;
    while (!file_exists(filePath) && current_time - startTime < waitTime)
    {
        // Wait for the file to exist
    }
    if (!file_exists(filePath)) return undefined;
    
    var file = file_text_open_read(filePath);
    if (file != -1)
    {
        var jsonString = file_text_read_string(file);
        file_text_close(file);
        var parsedData = json_parse(jsonString);
        if (parsedData != undefined) return parsedData;
        else 
        {
            show_error("Failed to parse JSON data from file: " + filePath, true);
            return undefined;
        }
    }
    else
    {
        show_error("Failed to open file for reading: " + filePath, true);
        return undefined;
    }
}