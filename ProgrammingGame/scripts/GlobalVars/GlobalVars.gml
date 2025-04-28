function Vars() constructor {
	pause = false;
	
	static PauseGame = function(_id)
    {
        Raise("Pause", _id);
        self.pause = true;
    }
	
	static ResumeGame = function(_id)
    {
        Raise("Resume", _id);
        self.pause = false;
    }
    
    CommandLibrary = {};
}

global.vars = new Vars();

function string_last_index_of(source, target) {
    var sourceLen = string_length(source);
    var targetLen = string_length(target);
    
    if (targetLen == 0 || sourceLen == 0 || targetLen > sourceLen) return 0;

    for (var i = sourceLen - targetLen + 1; i >= 1; i--) {
        if (string_copy(source, i, targetLen) == target) {
            return i;
        }
    }

    return 0; // Not found
}

function Command(_name, _cost, _inputMultiplier, _description, _callBackFunc, _returnsValue = false) constructor {
    Name = string_lower(_name);
    Cost = _cost;
    InputMultiplier = _inputMultiplier;
    Description = _description;
    CallBackFunc = _callBackFunc;
    ReturnsValue = _returnsValue;
}

function AddCommandToLibrary(_command) {
    global.vars.CommandLibrary[$ _command.Name] = _command;
}


function OpenModalWindow(_title, _text, _onCloseCallBack = undefined)
{
    var inst = instance_create_depth(irandom_range(-120 + 600, 120 + 600), irandom_range(-120 + 224, 120 + 224), -10, obj_ModalWindow);
    inst.SetTitle(_title);
    inst.SetText(_text);
    inst.SetOnCloseCallback(_onCloseCallBack);
}


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
    
    show_message(filePath)

}

/// @description Read JSON data from a file safely
/// @param {string} filePath - The path to the file.
/// @returns {struct} - The parsed JSON object or undefined if the file doesn't exist or parsing fails.
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

