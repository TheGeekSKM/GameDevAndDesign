AddCommandToLibrary(new Command("move", 2, 0, "Moves the player forward", function(_value) {
    Raise("Move", _value); 
}))

var findAngleCommand = new Command(
    "findangletoenemy",     // Name
    6,                      // Cost (cost to "think" and find angle)
    0,                      // No input multiplier needed
    "Finds the angle to the nearest bug.", // Description
    function(_value) {
        var nearestBug = instance_nearest(obj_Player.x, obj_Player.y, obj_Enemy);
        
        if (instance_exists(nearestBug)) var angle = point_direction(obj_Player.x, obj_Player.y, nearestBug.x, nearestBug.y)
        else angle = random(360);
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