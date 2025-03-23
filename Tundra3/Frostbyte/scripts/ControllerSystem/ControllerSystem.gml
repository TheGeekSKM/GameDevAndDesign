function BaseController(_owner) constructor {
    owner = _owner;
    stateMachine = new SnowState("idle");

    function AddState(_stateStruct)
    {
        if (!instance_exists(owner)) return;
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
        if (!instance_exists(owner)) return;
        stateMachine.step();
    }

    function Draw()
    {
        if (!instance_exists(owner)) return;
        stateMachine.draw();
        
    }

    function DrawGUI()
    {
        if (!instance_exists(owner)) return;
        stateMachine.drawGUI();
    }
}




