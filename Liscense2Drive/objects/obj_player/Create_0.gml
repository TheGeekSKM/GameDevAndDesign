keyLeft = 0;
keyRight = 0;
keyUp = 0;
keyDown = 0;

keyIntJ = 0;
keyIntL = 0;
keyIntI = 0;

keyEsc = 0;

moveSpeed = 3;

moveX = 0;
moveY = 0;

global.OldTimeStruct = {
	oldRealTime : global.TimeStruct.realTime,
	oldRealTimeNoMenu : global.TimeStruct.realTimeNoMenu
}

global.TimeStruct.realTimeNoMenu = 0;
global.TimeStruct.realTime = 0;

global.pause = false;

inventory = {
    coins : 0
};

enum QuestState {
    Idle,
    Started,
    InProgress,
    Completed
}



global.Inventory = 0;

global.QuestLibrary = [
    
];

deathCounter = 0;
deathTime = 45;
startDeathCounter = false;