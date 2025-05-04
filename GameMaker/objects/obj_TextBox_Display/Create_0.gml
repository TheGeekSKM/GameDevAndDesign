// Inherit the parent event
event_inherited();
title = "";

var displayStruct = SafeReadJson(working_directory + "FunctionDisplay.json");

if (displayStruct != undefined) {
    title = displayStruct[$ "title"];
    text = string_trim(displayStruct[$ "text"]);
} else {
    title = "ERROR: Failed to load JSON file.";
    text = "ERROR: Failed to load JSON file.";
}

AddMessage(text);