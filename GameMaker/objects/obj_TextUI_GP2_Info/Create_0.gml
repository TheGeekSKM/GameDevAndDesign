arr = [10, 20, 30, 40, 50, 60];

var randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_LifeSim.InterestStat = arr[randomInd] + irandom_range(1, 10);
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_CyberpunkFPS.InterestStat = arr[randomInd] + irandom_range(1, 10);
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_DarkFantasyRPG.InterestStat = arr[randomInd] + irandom_range(1, 10);
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_LovecraftianRPG.InterestStat = arr[randomInd] + irandom_range(1, 10);
array_delete(arr, randomInd, 1);

randomInd = irandom_range(0, array_length(arr) - 1);
obj_Button_RM_GP2_MultiplayerFPS.InterestStat = arr[randomInd] + irandom_range(1, 10);
array_delete(arr, randomInd, 1);

obj_Button_RM_GP2_SurvivalHorror.InterestStat = arr[0] + irandom_range(1, 10);