function TurnData() constructor {
    Id = "";
    Title = "";
    Description = "";

    IsPriority = false;
    RequiredFlags = []; // Array of flags that are required to spawn this turn
    PreventRepeat = true;

    Choices = [];
    ConditionFuncs = [];

    Weight = 0; // Weight of the turn, used for random selection
    function AddWeight(_weight) {
        Weight += _weight;
        return self;
    }

    function SetID(_id) {
        Id = _id;
        return self;
    }

    function SetTitle(_title) {
        Title = _title;
        return self;
    }

    function SetDescription(_description) {
        Description = _description;
        return self;
    }

    function AddChoice(_choice) {
        array_push(Choices, _choice);
        return self;
    }

    function AddConditionFunc(_func) {
        array_push(ConditionFuncs, _func);
        return self;
    }
}

function ChoiceData(_text = "", _effectsArray = [], _acceptCallback = undefined) constructor {
    Title = _text;
    Description = "";
    Effects = _effectsArray; // Array of ChoiceModifer objects
    AcceptCallbacks = [_acceptCallback];
    RejectCallbacks = []; // Array of functions to call when the choice is rejected
    RequiredFlags = []; 

    function Accept()
    {
        for (var i = 0; i < array_length(AcceptCallbacks); i++) {
            if (AcceptCallbacks[i] != undefined) {
                AcceptCallbacks[i]();
            }
        }
    }

    function Reject()
    {
        for (var i = 0; i < array_length(RejectCallbacks); i++) {
            if (RejectCallbacks[i] != undefined) {
                RejectCallbacks[i]();
            }
        }
    }

    function CanSpawnChoice()
    {
        var result = true;
        flags = variable_struct_get_names(global.GameManager.GetWorldState());

        for (var i = 0; i < array_length(RequiredFlags); i++) {
            if (!array_contains(flags, RequiredFlags[i])) {
                result = false;
                break;
            }
        }
        return result;
    }

    function AddEffect(_effect) {
        array_push(Effects, _effect);
        return self;
    }

    function AddAcceptCallback(_callback) {
        array_push(AcceptCallbacks, _callback);
        return self;
    }

    function AddRejectCallback(_callback) {
        array_push(RejectCallbacks, _callback);
        return self;
    }

    function SetTitle(_text) {
        Text = _text;
        return self;
    }

    function SetDescription(_text) {
        Description = _text;
        return self;
    }

    function AddRequiredFlag(_flag) {
        array_push(RequiredFlags, _flag);
        return self;
    }
}

function ChoiceModifer(_statType = StatType.GOLD, _value = 0) constructor {
    statType = _statType;
    value = _value; // The value to add to the stat

    function SetStatType(_statType) {
        statType = _statType;
        return self;
    }

    function SetValue(_value) {
        value = _value;
        return self;
    }
}