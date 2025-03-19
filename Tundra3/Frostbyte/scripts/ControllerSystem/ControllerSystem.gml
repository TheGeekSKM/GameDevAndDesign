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

function StateStruct(_name) constructor 
{
    name = _name;
    enter = function () {};
    step = function () {};
    draw = function () {};
    drawGUI = function () {};
    leave = function () {};

    function SetEnter(_enter)
    {
        enter = _enter;
        return self;
    }

    function SetStep(_step)
    {
        step = _step;
        return self;
    }

    function SetDraw(_draw)
    {
        draw = _draw;
        return self;
    }

    function SetDrawGUI(_drawGUI)
    {
        drawGUI = _drawGUI;
        return self;
    }

    function SetLeave(_leave)
    {
        leave = _leave;
        return self;
    }
}

function PlayerController(_owner) : BaseController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetEnter(function() {
            self.owner.image_index = 1;
            self.owner.image_speed = 0;
        })
        .SetStep(function() {
            if (global.vars.InputManager.IsMoving(self.owner.PlayerIndex)) stateMachine.change("moving");
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Action2)) stateMachine.change("attacking");
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Menu)) stateMachine.change("paused");
        })
        .SetDraw(function() {
             draw_self();  
        });
    
    var moving = new StateStruct("moving")
        .SetEnter(function() {
            self.owner.image_speed = 1;
            self.owner.canMove = true;
        })
        .SetStep(function() {
            if (!global.vars.InputManager.IsMoving(self.owner.PlayerIndex)) stateMachine.change("idle");
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Action2)) stateMachine.change("attacking");
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Menu)) stateMachine.change("paused");
        })
        .SetLeave(function() {
            self.owner.canMove = false;   
        })
        .SetDraw(function() {
            draw_self();    
        });
    
    var attacking = new StateStruct("attacking")
        .SetEnter(function() {
            self.owner.image_index = 1;
            self.owner.image_speed = 0;
            self.owner.canAttack = true;            
        })
        .SetStep(function() {
            if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Action2)) stateMachine.change("idle");
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Menu)) stateMachine.change("paused");
        })
        .SetLeave(function() {
            self.owner.canAttack = false;   
        })    
        .SetDraw(function() {
            draw_self();
        });

    var paused = new StateStruct("paused")
        .SetEnter(function() {
            self.owner.canMove = false;
            self.owner.canAttack = false;
            Raise("MenuOpen", self.owner.PlayerIndex);
        })
        .SetStep(function() {
            if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Menu)) 
            {
                stateMachine.change("idle"); 
                Raise("MenuClose", self.owner.PlayerIndex);
            }
        })
        .SetDraw(function() {
            draw_self();
        });        
    
    self.AddState(idle);
    self.AddState(moving);
    self.AddState(attacking);
    self.AddState(paused);
}

function AIController(_owner) : BaseController(_owner) constructor 
{

}