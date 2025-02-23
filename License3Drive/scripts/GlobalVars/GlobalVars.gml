

enum ButtonState {
    Idle,
    Hovered,
    Clicked
}

font_enable_effects(VCR_OS_Mono_Effects, true, {
    dropShadowEnable: true,
    dropShadowSoftness: 7,
    dropShadowOffsetX: 2,
    dropShadowOffsetY: 2,
    dropShadowAlpha: 1
});

enum CarDirection {
    Up,
    Down
}


enum ItemType {
    Paper,
    CarParts,
    CrashDetector,
    Compass
}

///@pure
function ItemTypeToString(_type)
{
    var rtr = "";
    switch(_type)
    {
        case ItemType.Paper:
            rtr = "Documents";
            break;
        case ItemType.CarParts:
            rtr = "Car Parts";            
            break;
        case ItemType.CrashDetector:
            rtr = "Crash Detector";            
            break;
        case ItemType.Compass:
            rtr = "Compass";            
            break;
    }
    return rtr;
}


enum QuestState {
    Started,
    Completed
}

function QuestData(_name, _desc) constructor 
{
    questName = _name;
    questDescription = _desc;
    questState = QuestState.Started;
    
}

enum ItemState {
    Unequipped,
    Equipped
}

function EquippableItemData(_name, _state) constructor
{
    name = _name;
    state = _state;
}

function ItemStateToString(_state)
{
    var returnStr = "";
    switch (_state)
    {
        case ItemState.Unequipped:
            returnStr = ": Unequipped"
            break;
        case ItemState.Equipped:
            returnStr = ": Equipped";
            break;
    }
    
    return returnStr;
}

///@pure
function ConvertStateToString(_state)
{
    var _returnString = "";
    switch (_state)
    {
        case QuestState.Started:
            _returnString = ": Started"
            break;
        case QuestState.Completed:
            _returnString = ": Completed"
            break;
    }
    
    return _returnString;
}

function DialogueData(_speakerColor, _text) constructor 
{
    color = _speakerColor;
    text = _text;
}

function ItemData (_itemType, _itemCount, _pickUpLocation) constructor 
{
    itemType = _itemType;
    itemCount = _itemCount;
    pickUpLocation = _pickUpLocation;
}
