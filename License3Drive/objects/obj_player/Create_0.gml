moveSpeed = 4;
defaultMoveSpeed = moveSpeed;
collidables = [obj_wall];
isDead = false;

paperAmount = 0;
carPartsAmount = 0;
recievedScanner = false;

bloodScale = 0.1;
bloodRot = random(360);

global.TimeStruct = {
    time : 0,
    timeNoMenu : 0,
    won : false
}


function AddItem(_type, _count)
{
    switch(_type)
    {
        case ItemType.Paper:
            paperAmount += _count;
            break;
        case ItemType.CarParts:
            carPartsAmount += _count;
            break;
        case ItemType.CrashDetector:
            Raise("CrashReciever Recieved", id);
            var p = instance_create_layer(x, y, "GUI", obj_pickUpText);
            p.Init(new ItemData("Crash Dectector", 1, new Vector2(x, y)));    
            break;
        case ItemType.Compass:
            Raise("Compass Recieved", id);
            var q = instance_create_layer(x, y, "GUI", obj_pickUpText);
            q.Init(new ItemData("Compass", 1, new Vector2(x, y)));        
            break;
    }
}


QuestLibrary = [ ];
lastCrash = new Vector2(0,0);

///@pure
function FindQuestIndex(_questData)
{
    var index = array_find_index(QuestLibrary, function(_element, _index) {
        return _element.questName == _questData.questName;
    });
    
    return index;
}