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