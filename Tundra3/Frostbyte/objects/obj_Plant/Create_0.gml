event_inherited();

plantRanges = [
    [3, 5],
    [2, 3],
    [1, 2],
    [0, 0]
]

currentPlantState = 0;
image_index = currentPlantState;

function OnInteract() 
{
    var cherryItem = new ConsumableItem("Cherry", 1, 0, [], spr_pixel, 5); 
    echo($"CurrentPlantState: {currentPlantState}")
    playerInRange.inventory.AddItem(cherryItem, irandom_range(plantRanges[currentPlantState][0], plantRanges[currentPlantState][1]));    
    DecreaseFood();
}

function DecreaseFood()
{
    currentPlantState = min(3, currentPlantState + 1);
    image_index = currentPlantState;
}

alarm[0] = irandom_range(5, 20) * 60;
image_angle = irandom(360);