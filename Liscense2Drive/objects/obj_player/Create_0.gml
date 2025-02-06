keyLeft = 0;
keyRight = 0;
keyUp = 0;
keyDown = 0;

keyIntJ = 0;
keyIntL = 0;
keyIntI = 0;

moveSpeed = 3;

moveX = 0;
moveY = 0;

inventory = {
    coins : 0
};

enum QuestState {
    Idle,
    Started,
    InProgress,
    Completed
}

questData = {
    findPapers1 : QuestState.Idle,
    findPapers2 : QuestState.Idle
}