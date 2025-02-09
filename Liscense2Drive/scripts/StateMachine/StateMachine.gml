function QuestData(_name, _assigner, _recipient, _state, _description) constructor 
{
    questName = _name;
    questAssigner = _assigner;
    questRecipient = _recipient;
    questState = _state;
    questDescription = _description;
}

function State() constructor 
{
    OnEnter = function() {};
    OnUpdate = function() {};
    OnExit = function() {};
    OnDraw = function() {};
}

function FSM() constructor 
{
    currentState = undefined;
    states = [];
    variables = {};
    
    AddState = function(_state)
    {
        array_push(states, _state);
    }
    
    InitState = function(_state)
    {
        currentState = _state;
        currentState.OnEnter();
    }
    
    ChangeState = function(_state)
    {
        currentState.OnExit();
        currentState = _state;
        currentState.OnEnter();
    }
    
    Update = function()
    {
        currentState.OnUpdate();
    }
    
    Draw = function()
    {
        currentState.OnDraw();
    }
}