AddCommandToLibrary(new Command("move", 5, 0, "Moves the player forward", function(_value) {
    show_message($"Moved by {_value} units.");    
}))

echo("bungus")

var findAngleCommand = new Command(
    "FindAngleToEnemy",     // Name
    5,                      // Cost (cost to "think" and find angle)
    0,                      // No input multiplier needed
    "Finds the angle to the nearest bug.", // Description
    function(_value) {
        // Example simple logic (replace with real gameplay logic)
        var angle = irandom(360); 
        return angle;
    },
    true
);

// Add it to the library
AddCommandToLibrary(findAngleCommand);