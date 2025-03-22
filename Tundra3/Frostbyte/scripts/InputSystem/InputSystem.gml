function PlayerInput(_left, _right, _up, _down, _action1, _action2, _menu) constructor 
{
    left = _left;
    right = _right;
    up = _up;
    down = _down;
    action1 = _action1;
    action2 = _action2;
    menu = _menu;
}

function InputSystem() constructor {
    player1 = new PlayerInput(ord("A"), ord("D"), ord("W"), ord("S"), ord("E"), ord("Q"), ord("R"));
    player2 = new PlayerInput(ord("J"), ord("L"), ord("I"), ord("K"), ord("O"), ord("U"), ord("P"));

    ///@desc Returns true if the action is pressed
    ///@param {Real} _playerIndex - The player index
    ///@param {enum} _actionType - The action type
    ///@return {bool} - True if the action is pressed
    function IsPressed(_playerIndex, _actionType)
    {
        var action = ActionTypeToString(_actionType);
        var _player = _playerIndex == 0 ? player1 : player2;
        return keyboard_check_pressed(_player[$ action]);
    }

    ///@desc Returns true if the action is down
    ///@param {Real} _playerIndex - The player index
    ///@param {enum} _actionType - The action type
    ///@return {bool} - True if the action is down
    function IsDown(_playerIndex, _actionType)
    {
        var action = ActionTypeToString(_actionType);
        var _player = _playerIndex == 0 ? player1 : player2;
        return keyboard_check(_player[$ action]);
    }

    ///@desc Returns true if the action is released
    ///@param {Real} _playerIndex - The player index
    ///@param {enum} _actionType - The action type
    ///@return {bool} - True if the action is released
    function IsReleased(_playerIndex, _actionType)
    {
        var action = ActionTypeToString(_actionType);
        var _player = _playerIndex == 0 ? player1 : player2;
        return keyboard_check_released(_player[$ action]);
    }

    ///@pure
    ///@desc Converts an ActionType to a string
    ///@param {enum} _type - The ActionType to convert
    ///@return {string} - The string representation of the ActionType
    function ActionTypeToString(_type)
    {
        switch(_type)
        {
            case ActionType.Left: return "left";
            case ActionType.Right: return "right";
            case ActionType.Up: return "up";
            case ActionType.Down: return "down";
            case ActionType.Action1: return "action1";
            case ActionType.Action2: return "action2";
            case ActionType.Menu: return "menu";
        }
    }

    ///@desc Changes the keybind for a player
    ///@param {Real} _playerIndex - The player index
    ///@param {enum} _actionType - The action type
    ///@param {Real} _key - The key to change to
    function ChangeKeybind(_playerIndex, _actionType, _key)
    {
        var action = ActionTypeToString(_actionType);
        var _player = _playerIndex == 1 ? player1 : player2;
        _player[$ action] = _key;
    }

    ///@desc Returns true if the player is moving
    ///@param {Real} _playerIndex - The player index
    ///@return {bool} - True if the player is moving
    function IsMoving(_playerIndex)
    {
        var _player = _playerIndex == 0 ? player1 : player2;
        return IsDown(_playerIndex, ActionType.Left) || 
            IsDown(_playerIndex, ActionType.Right) || 
            IsDown(_playerIndex, ActionType.Up) || 
            IsDown(_playerIndex, ActionType.Down);
    }

    function GetKey(_playerIndex, _actionType)
    {
        var action = ActionTypeToString(_actionType);
        var _player = _playerIndex == 0 ? player1 : player2;
        return _player[$ action];
    }
}

enum ActionType
{
    Left,
    Right,
    Up,
    Down,
    Action1,
    Action2,
    Menu
}

function KeybindToString(_key)
{
    switch(_key)
    {
        case ord("A"): return "A";
        case ord("B"): return "B";
        case ord("C"): return "C";
        case ord("D"): return "D";
        case ord("E"): return "E";
        case ord("F"): return "F";
        case ord("G"): return "G";
        case ord("H"): return "H";
        case ord("I"): return "I";
        case ord("J"): return "J";
        case ord("K"): return "K";
        case ord("L"): return "L";
        case ord("M"): return "M";
        case ord("N"): return "N";
        case ord("O"): return "O";
        case ord("P"): return "P";
        case ord("Q"): return "Q";
        case ord("R"): return "R";
        case ord("S"): return "S";
        case ord("T"): return "T";
        case ord("U"): return "U";
        case ord("V"): return "V";
        case ord("W"): return "W";
        case ord("X"): return "X";
        case ord("Y"): return "Y";
        case ord("Z"): return "Z";
    }
}