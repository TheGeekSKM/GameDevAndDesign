canSummon = false;
numToSpawnPerWave = 0;

Subscribe("Night", function(_id) {
    canSummon = true;
    alarm[0] = irandom_range(5, 20) * 30;
    numToSpawnPerWave = irandom_range(5, 10);
});

Subscribe("Day", function(_id) {
    canSummon = false;
    numToSpawnPerWave = 0;
});