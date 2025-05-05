AddCommandToLibrary(new Command("move", 2, 0, "Moves the player forward", function(_value) {
    Raise("Move", _value); 
}))

var findAngleCommand = new Command(
    "findangletoenemy",     // Name
    6,                      // Cost (cost to "think" and find angle)
    0,                      // No input multiplier needed
    "Finds the angle to the nearest bug.", // Description
    function(_value) {
        // Example simple logic (replace with real gameplay logic)
        var angle = irandom(360);
        show_message($"Angle: {angle}")
        return angle;
    },
    true
);


// Add it to the library
AddCommandToLibrary(findAngleCommand);

AddCommandToLibrary(
    new Command(
        "turn", 2, 0, "Turns the player by an angle", function(_value) {
            Raise("Turn", _value);
        }, false
    )
)

AddCommandToLibrary(
    new Command(
        "turnto", 2, 0, "Turns the player to face an angle", function(_value) {
            Raise("TurnTo", _value);
            show_message($"Turning to {_value}")
        }, false
    )
)

AddCommandToLibrary(
    new Command(
        "shoot", 3, 0, "Shoots forward", function(_value) {
            Raise("Shoot", _value);
        }, false
    )
)

if (file_exists(working_directory + "FunctionDisplay.json"))
{
    file_delete(working_directory + "FunctionDisplay.json")
}