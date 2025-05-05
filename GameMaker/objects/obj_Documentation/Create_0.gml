event_inherited();

padding = 20;
textTransform = 0.75;

// add message for "function name() { // insert code here }"
AddMessage(@"[scale, 2][c_player]function [c_aqua]functionName[c_player]() 
{ 
    [slant][c_grey]//Insert Code Here[c_player]
}[/]
- This is the basic structure of a function.
- The function name can be anything you want, but it must follow the naming conventions of the language.
- The function name is what will be displayed in game.
- The code inside the curly braces is the code that will be executed when the function is called.
- Example: [slant][c_player]function [c_aqua]MoveForward[c_player]() 
{ 
    [c_player]Move([c_aqua]1[c_player]); 
}[/] 
        -> This function moves the player 1 step forward when called.
        
[c_grey]=================================================================================[/]");


AddMessage(@"[scale, 2][c_player]var ([c_aqua]variableName[c_player]) = ([c_aqua]variableValue[c_player]);[/]
- This stores the value of [c_aqua]variableValue[/] in the variable [c_aqua]variableName[/].
- These scope of the variable is limited to the function it is defined in.
- Currently, the only supported data type is [c_yellow]INTEGER[/]
- Also, as of right now, variabes are [c_yellow]IMMUTABLE[/], meaning they cannot be changed after they are defined. 
- Example: [slant][c_player]var [c_aqua]bungus[c_player] = [c_aqua]FindAngleToEnemy()[c_player];[/] 
        -> This stores the angle to the nearest enemy in the variable [c_aqua]bungus[/].
        
[c_grey]=================================================================================[/]");

AddMessage(@"[scale, 2][c_player]Move([c_aqua]numOfSteps[c_player] : [c_yellow]INTEGER[c_player]);[/]
- Moves the player in the direction it is facing by the number of steps specified in the [c_aqua]numOfSteps[/] variable. 
- Example: [slant][c_player]Move([c_aqua]5[c_player]);[/] 
        -> This moves the player 5 steps forward in the direction it is facing.
        
[c_grey]=================================================================================[/]");

// add message for Turn(angle)
AddMessage(@"[scale, 2][c_player]Turn([c_aqua]angle[c_player] : [c_yellow]INTEGER[c_player]);[/]
- Turns the player by the specified angle in degrees. Positive values turn right, and negative values turn left.
- Example: [slant][c_player]Turn([c_aqua]90[c_player]);[/] 
        -> This turns the player 90 degrees to the right.
        
[c_grey]=================================================================================[/]");

// add message for TurnTo(angle)
AddMessage(@"[scale, 2][c_player]TurnTo([c_aqua]angle[c_player] : [c_yellow]INTEGER[c_player]);[/]
- Turns the player to face the specified angle in degrees. Positive values turn right, and negative values turn left.
- Example: [slant][c_player]TurnTo([c_aqua]180[c_player]);[/] 
        -> This turns the player to face 180 degrees.

[c_grey]=================================================================================[/]");

// add message for Shoot(numOfShots)
AddMessage(@"[scale, 2][c_player]Shoot([c_aqua]numOfShots[c_player] : [c_yellow]INTEGER[c_player]);[/]
- Shoots the specified number of shots in the direction the player is facing.
- Example: [slant][c_player]Shoot([c_aqua]3[c_player]);[/] 
        -> This shoots 3 shots in the direction the player is facing.

[c_grey]=================================================================================[/]");

// add message for Repeat(numOfTimes) {}
AddMessage(@"[scale, 2][c_player]Repeat([c_aqua]numOfTimes[c_player] : [c_yellow]INTEGER[c_player]) 
{ 
    [slant][c_grey]//Add Instructions Here [c_player]
}
[/]
- Repeats the instructions inside the curly braces the specified number of times.
- Example: 
    [slant][c_player]Repeat([c_aqua]3[c_player]) 
    { 
        [c_player]Move([c_aqua]1[c_player]); 
    }[/] 
    
    This moves the player 1 step forward 3 times.

[c_grey]=================================================================================[/]");

AddMessage(@"[scale, 2.][c_player]FindAngleToEnemy(); -> [c_aqua]_angleToNearestEnemy[c_player] : [c_yellow]INTEGER[/]
- This function returns the angle to the nearest enemy as an [c_yellow]INTEGER[/] value.
- Example: [slant][c_player]TurnTo( [c_aqua]FindAngleToEnemy()[c_player] );[/] Turns the player to face the angle of the nearest enemy.");