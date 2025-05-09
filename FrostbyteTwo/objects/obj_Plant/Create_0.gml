// Inherit the parent event
event_inherited();

plantRanges = [
    [3, 5],
    [2, 3],
    [1, 2],
    [0, 0]
]

cherryItem = new ConsumableItem("Cherry", 1, 0, [], spr_CPU, 5); 

currentPlantState = 0;
image_index = currentPlantState;

function Collect(_id) 
{
    playerInRange = _id;
    echo($"CurrentPlantState: {currentPlantState}")
    if (irandom(100) >= 50) 
    {
        var cherryCount = irandom_range(plantRanges[currentPlantState][0], plantRanges[currentPlantState][1]);
        playerInRange.inventory.AddItem(global.vars.ItemLibrary.Cherry, cherryCount);
    } 
    else 
    {
        var stickCount = irandom_range(plantRanges[currentPlantState][0], plantRanges[currentPlantState][1]);
        playerInRange.inventory.AddItem(global.vars.ItemLibrary.Sticks, stickCount);
    } 
    DecreaseFood();
}

function DecreaseFood()
{
    currentPlantState = min(3, currentPlantState + 1);
    image_index = currentPlantState;
}

alarm[0] = irandom_range(5, 20) * 60;
image_angle = irandom(360);