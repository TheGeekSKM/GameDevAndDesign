moveSpeed = 4;
collidables = [obj_wall, obj_car];

paperAmount = 0;
carPartsAmount = 0;
recievedScanner = false;

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