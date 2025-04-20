/*

chatMessages.json = 
[
    {"from": "Name", "text": "ExampleText"},
    {"from": "Name", "text": "ExampleText"}
]

*/
messageTextBox = new TextBox(id, spr_box, x, y, sprite_width, sprite_height);

function SaveMessage(_from, _text)
{
    var filePath = working_directory + "chatMessages.json";
    var chatMessages = SafeReadJson(filePath);
    
    if (chatMessages == undefined) chatMessages = []; // Initialize if file doesn't exist or is empty
    
    var newMessage = {"from": _from, "text": _text};
    array_push(chatMessages, newMessage); // Add the new message to the array
    
    var jsonString = json_stringify(chatMessages); // Convert the array to a JSON string
    SafeWriteJson(filePath, jsonString); // Write the JSON string to the file safely

    messageTextBox.AddMessage($"{_from}: {_text}"); // Add the message to the text box for display
}