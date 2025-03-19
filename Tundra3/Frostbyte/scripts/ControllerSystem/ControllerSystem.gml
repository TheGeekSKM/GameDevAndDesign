function BaseController(_owner) constructor {
    owner = _owner;
    stateMachine = new SnowState("idle");

    function AddState(_stateStruct)
    {
        stateMachine.add(_stateStruct.name, {
            enter: _stateStruct.enter,
            step: _stateStruct.step,
            draw: _stateStruct.draw,
            drawGUI: _stateStruct.drawGUI,
            leave: _stateStruct.leave
        })
    }

    function Step()
    {
        stateMachine.step();
    }

    function Draw()
    {
        stateMachine.draw();
        
    }

    function DrawGUI()
    {
        stateMachine.drawGUI();
    }
}




