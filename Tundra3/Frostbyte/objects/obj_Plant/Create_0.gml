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
    currentPlantState = max(0, currentPlantState - 1);
    image_index = currentPlantState;

    playerInRange.inventory.AddItem(ITEM_cherry, irandom_range(plantRanges[currentPlantState][0], plantRanges[currentPlantState][1]));    
}

alarm[0] = 2;
image_angle = irandom(360);