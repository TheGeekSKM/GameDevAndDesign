AddCommandToLibrary(new Command("move", 2, 0, "Moves the player forward", function(_value) {
    show_message($"Moved by {_value} units.");    
}))

var findAngleCommand = new Command(
    "FindAngleToEnemy",     // Name
    6,                      // Cost (cost to "think" and find angle)
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

AddCommandToLibrary(
    new Command(
        "turn", 2, 0, "Turns the player by an angle", function(_value) {
            show_message($"Turned by {_value} degrees");
        }, false
    )
)

AddCommandToLibrary(
    new Command(
        "turnto", 2, 0, "Turns the player to face an angle", function(_value) {
            show_message($"Turned to face {_value} degrees");
        }, false
    )
)

AddCommandToLibrary(
    new Command(
        "shoot", 3, 0, "Shoots forward", function(_value) {
            show_message($"Shot forward {_value} times");
        }, false
    )
)