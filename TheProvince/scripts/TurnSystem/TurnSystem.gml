function TurnData() constructor {
    Choices = [];
    function AddChoice(_choice) {
        array_push(Choices, _choice);
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
    ConditionFuncs = [];
    AllowedMoods = [];

    ReappearDelay = 2;
    LastSeenTurn = -999;
    
    Weight = 0; 
    IsPriority = false;  

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

    function SetReappearDelay(_delay) {
        ReappearDelay = _delay;
        return self;
    }

    function Selected()
    {
        LastSeenTurn = global.GameManager.TurnCount;
    }

    function CanSpawnChoice()
    {
        if (global.GameManager.TurnCount - LastSeenTurn < ReappearDelay) {
            echo($"Choice {Title} cannot spawn yet! {global.GameManager.TurnCount - LastSeenTurn} < {ReappearDelay}");
            return false;
        }
        else
        {
            echo($"Choice {Title} can spawn! {global.GameManager.TurnCount - LastSeenTurn} >= {ReappearDelay}");
        }

        if (array_length(AllowedMoods) > 0)
        {
            if (!array_contains(AllowedMoods, 
                global.GameManager.GetWorldState().CurrentWorldMood))
            {
                return false;
            }
        }

        var result = true;
        flags = variable_struct_get_names(global.GameManager.GetWorldState());

        for (var i = 0; i < array_length(RequiredFlags); i++) {
            if (!array_contains(flags, RequiredFlags[i])) {
                result = false;
                break;
            }
        }

        for (var i = 0; i < array_length(ConditionFuncs); i++) {
            if (!ConditionFuncs[i]()) {
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
        Title = _text;
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

    function AddConditionFunc(_func) {
        array_push(ConditionFuncs, _func);
        return self;
    }
}

function ChoiceModifer(_statType = StatType.GOLD, _value = 0, _delay = 0) constructor {
    statType = _statType;
    value = _value; // The value to add to the stat
    delay = _delay

    function SetStatType(_statType) {
        statType = _statType;
        return self;
    }

    function SetValue(_value) {
        value = _value;
        return self;
    }

    function SetDelay(_delay) {
        delay = _delay;
        return self;
    }
}