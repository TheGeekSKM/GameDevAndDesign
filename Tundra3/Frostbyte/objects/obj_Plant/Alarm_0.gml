// increase the currentPlantState by 1
currentPlantState = max(0, currentPlantState - 1);
image_index = currentPlantState;

// set the alarm to a random value between the current range
alarm[0] = irandom_range(5, 20) * 60;