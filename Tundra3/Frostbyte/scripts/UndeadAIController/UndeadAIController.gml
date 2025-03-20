function UndeadAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.wanderRandomly = true;
            self.owner.StartCheckingForPrey();
            // canMove = true
            // wander randomly
            // if livingCreature detected within 120 pixels, change state to chase
        })
        .SetStep(function() {
            // if prey is detected, change state to chase
            if (instance_exists(self.owner.prey)) {
                self.stateMachine.change("chase");
            }
        })
        .SetLeave(function() {
            self.owner.canMove = false;
            self.owner.wanderRandomly = false;
            self.owner.StopCheckingForPrey();
        });

    var chase = new StateStruct("chase")
        .SetEnter(function() {
            // canMove = true
            self.owner.canMove = true;
            
            // chase after target
            self.owner.chase = true;
            
        })
        .SetStep(function() {
            if (!instance_exists(self.owner.prey)) {
                self.stateMachine.change("idle");
            }

            // if target is within attackRange, change state to attack
            if (point_distance(self.owner.x, self.owner.y, self.owner.prey.x, self.owner.prey.y) <= self.owner.attackRange) {
                self.stateMachine.change("attack");
            }

            // if target is outside of 120 pixels, change state to wander
            if (point_distance(self.owner.x, self.owner.y, self.owner.prey.x, self.owner.prey.y) > 120) {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.chase = false;
        });

    var attack = new StateStruct("attack")
        .SetEnter(function() {
            self.owner.canMove = false;
            self.owner.canAttack = true;
            
        })
        .SetStep(function() {
            self.owner.canMove = false;
            // if target is outside of attackRange, change state to chase
            // if target is outside of 120 pixels, change state to wander

            if (!instance_exists(self.owner.prey)) {
                self.stateMachine.change("idle");
            }

            if (point_distance(self.owner.x, self.owner.y, self.owner.prey.x, self.owner.prey.y) > self.owner.attackRange) {
                self.stateMachine.change("chase");
            }

            if (point_distance(self.owner.x, self.owner.y, self.owner.prey.x, self.owner.prey.y) > self.owner.chaseRange) {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.canAttack = false;
        });

    self.AddState(idle);
    self.AddState(chase);
    self.AddState(attack);
}