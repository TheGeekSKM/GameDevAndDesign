function Vars() constructor {
	pause = false;
	
	static PauseGame = function(_id)
    {
        Raise("Pause", _id);
        self.pause = true;
    }
	
	static ResumeGame = function(_id)
    {
        Raise("Resume", _id);
        self.pause = false;
    }
    
    CommandLibrary = {};
}

global.vars = new Vars();

function string_last_index_of(source, target) {
    var sourceLen = string_length(source);
    var targetLen = string_length(target);
    
    if (targetLen == 0 || sourceLen == 0 || targetLen > sourceLen) return 0;

    for (var i = sourceLen - targetLen + 1; i >= 1; i--) {
        if (string_copy(source, i, targetLen) == target) {
            return i;
        }
    }

    return 0; // Not found
}

function Command(_name, _cost, _inputMultiplier, _description, _callBackFunc, _returnsValue = false) constructor {
    Name = string_lower(_name);
    Cost = _cost;
    InputMultiplier = _inputMultiplier;
    Description = _description;
    CallBackFunc = _callBackFunc;
    ReturnsValue = _returnsValue;
}

function AddCommandToLibrary(_command) {
    global.vars.CommandLibrary[$ _command.Name] = _command;
}


function OpenModalWindow(_title, _text, _onCloseCallBack = undefined)
{
    var inst = instance_create_depth(irandom_range(-120 + 600, 120 + 600), irandom_range(-120 + 224, 120 + 224), -10, obj_ModalWindow);
    inst.SetTitle(_title);
    inst.SetText(_text);
    inst.SetOnCloseCallback(_onCloseCallBack);
}
