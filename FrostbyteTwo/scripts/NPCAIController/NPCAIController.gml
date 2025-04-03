function NPCAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetEnter(function() {
            self.owner.canMove = false;
            self.owner.canAttack = false;
            self.owner.image_speed = 0;
        })
        .SetStep(function() {
            if (self.owner.entityHealth.recentAttacker != noone) 
            {
                self.stateMachine.change("attack");
            }
        });

    var attack = new StateStruct("attack")
        .SetEnter(function() {
            self.owner.canAttack = true;
            self.owner.canMove = false;
            self.owner.image_speed = 0;
        })
        .SetStep(function() {
            if (self.owner.entityHealth.IsBadlyDamaged())
            {
                self.stateMachine.change("flee");
            }

            var attacker = self.owner.entityHealth.recentAttacker;
            if (!instance_exists(attacker) or point_distance(self.owner.x, self.owner.y, attacker.x, attacker.y) > self.owner.attackRange)
            {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.canAttack = false;
        });
    
    var flee = new StateStruct("flee")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.canAttack = false;
            self.owner.fleeing = true;
        })
        .SetStep(function() {
            if (point_distance(self.owner.x, self.owner.y, self.owner.startingPos.x, self.owner.startingPos.y) > 256)
            {
                self.stateMachine.change("walkToStartingPos");
            }

            self.owner.entityHealth.Heal(0.5);
            if (!self.owner.entityHealth.IsBadlyDamaged()) self.stateMachine.change("walkToStartingPos");
        })
        .SetLeave(function() {
            self.owner.fleeing = false;
        })

    var walkToStartingPos = new StateStruct("walkToStartingPos")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.canAttack = false;
            self.owner.walkToStartingPos = true;
        })
        .SetStep(function() {
            if (point_distance(self.owner.x, self.owner.y, self.owner.startingPos.x, self.owner.startingPos.y) < 16)
            {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.walkToStartingPos = false;
        });

    self.AddState(idle);
    self.AddState(attack);
    self.AddState(flee);
    self.AddState(walkToStartingPos);
}

