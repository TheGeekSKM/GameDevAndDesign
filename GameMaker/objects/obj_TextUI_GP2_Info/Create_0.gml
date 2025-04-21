arr = [1, 2, 3, 4, 5, 6];

var randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_LifeSim.InterestStat = arr[randomInd];
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_CyberpunkFPS.InterestStat = arr[randomInd];
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_DarkFantasyRPG.InterestStat = arr[randomInd];
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_LovecraftianRPG.InterestStat = arr[randomInd];
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_MultiplayerFPS.InterestStat = arr[randomInd];
array_delete(arr, randomInd, 1);

obj_Button_RM_GP2_SurvivalHorror.InterestStat = arr[0];