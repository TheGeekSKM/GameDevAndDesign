

/*

chatMessages.json = 
[
    {"from": "Name", "text": "ExampleText"},
    {"from": "Name", "text": "ExampleText"}
]

*/

// Configuration
display_width = sprite_width;
display_height = sprite_height;
padding = 5;
line_height = 20;
font_used = VCR_OSD_Mono; // Optional: assign a font here
text_color = c_white;

topLeftX = 0;
topLeftY = 0;

// State
message_list = [];
__scroll_offset = 0;
__target_scroll_offset = 0;
scroll_speed = 0.2;

function AddMessage(_msg) {
    array_push(message_list, _msg);
    
    var scribbleStruct = scribble($"> {_msg}")
        .align(fa_left, fa_top)
        .starting_format("VCR_OSD_Mono")
        .transform(0.75, 0.75, 0)
        .wrap(780 * 1.333)
    
    line_height = scribbleStruct.get_height();
    
    var total_height = array_length(message_list) * (line_height + padding);
    if (total_height > display_height) {
        var overflow = total_height - display_height;
        target_scroll_offset = overflow;
    }
}

function ClearBox()
{
    message_list = [];
    scroll_offset = 0;
    target_scroll_offset = 0;
    scroll_speed = 0.2;
}



currentMessageLength = array_length(message_list);

function SaveMessage(_from, _text)
{
    var filePath = working_directory + "chatMessages.json";
    var chatMessages = SafeReadJson(filePath);
    
    if (chatMessages == undefined) chatMessages = []; // Initialize if file doesn't exist or is empty
    
    var newMessage = {"from": _from, "text": _text};
    array_push(chatMessages, newMessage); // Add the new message to the array
    
    var jsonString = json_stringify(chatMessages); // Convert the array to a JSON string
    SafeWriteJson(filePath, jsonString); // Write the JSON string to the file safely
}

function Read()
{
    var filePath = working_directory + "chatMessages.json";
    var chatMessages = SafeReadJson(filePath);
    
    if (array_length(chatMessages) > currentMessageLength)
    {
        for (var i = currentMessageLength; i < array_length(chatMessages); i++) {
            var message = chatMessages[i];
            AddMessage(message.from + ": " + message.text); // Add the new message to the text box
        }
        currentMessageLength = array_length(chatMessages); // Update the current message length
    }
    else 
    {
        ClearBox(); // Clear the text box if no new messages
        
        for (var i = 0; i < array_length(chatMessages); i += 1) {
            var message = chatMessages[i];
            AddMessage(message.from + ": " + message.text); // Add the new message to the text box
        }
    }
}