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

function QuestData(_name, _assigner, _recipient, _state) constructor 
{
	questName = _name;
	questAssigner = _assigner;
	questRecipient = _recipient;
	questState = _state;
}

global.QuestLibrary = [
    
];