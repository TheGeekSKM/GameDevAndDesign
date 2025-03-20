// increase the currentPlantState by 1
currentPlantState = min(array_length(plantRanges) - 1, currentPlantState + 1);
image_index = currentPlantState;

// set the alarm to a random value between the current range
alarm[0] = irandom_range(3, 5) * 60;