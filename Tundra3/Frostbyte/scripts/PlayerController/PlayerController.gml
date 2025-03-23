function PlayerController(_owner) : BaseController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetEnter(function() {
            self.owner.image_index = 1;
            self.owner.image_speed = 0;
            self.owner.canMove = false;
        })
        .SetStep(function() {
            if (global.vars.InputManager.IsMoving(self.owner.PlayerIndex)) {
                stateMachine.change("moving");
            }
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Action2)) stateMachine.change("attacking");
        })
        .SetDraw(function() {
            with(self.owner) draw_self();
        })
        .SetLeave(function() {     
        });
    
    var moving = new StateStruct("moving")
        .SetEnter(function() {
            self.owner.image_speed = 1;
            self.owner.canMove = true;
            self.owner.image_index = ChooseFromArray([0, 2]);
            // echo($"Player {owner.PlayerIndex + 1} is moving with image_index {owner.image_index}", true);
        })
        .SetStep(function() {
            if (!instance_exists(self.owner)) return;
            if (!global.vars.InputManager.IsMoving(self.owner.PlayerIndex)) stateMachine.change("idle");
            else if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Action2)) stateMachine.change("attacking");
        })
        .SetLeave(function() {
            self.owner.canMove = false;   
        })
        .SetDraw(function() {
            with(self.owner) draw_self();   
        });
    
    var attacking = new StateStruct("attacking")
        .SetEnter(function() {
            self.owner.image_index = 1;
            self.owner.image_speed = 0;
            self.owner.canAttack = true;            
        })
        .SetStep(function() {
            if (global.vars.InputManager.IsPressed(self.owner.PlayerIndex, ActionType.Action2)) stateMachine.change("idle");
        })
        .SetLeave(function() {
            self.owner.canAttack = false;   
        })    
        .SetDraw(function() {
            with(self.owner) draw_self();
        });       
    
    self.AddState(idle);
    self.AddState(moving);
    self.AddState(attacking);
}