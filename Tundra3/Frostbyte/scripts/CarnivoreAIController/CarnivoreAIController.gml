function CarnivoreAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.wanderRandomly = true;
            // canMove = true
            // wander randomly
        })
        .SetStep(function() {
            if (self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("lowHealth");
            }

            if (instance_exists(self.owner.entityHealth.recentAttacker)) {
                self.stateMachine.change("hunt");
            }

            if (self.owner.hunger.IsHungry()) {
                self.stateMachine.change("hungryWander");
            }
        })
        .SetLeave(function() {
            self.owner.wanderRandomly = false;
        });
    
    var hungryWander = new StateStruct("hungryWander")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.wanderRandomly = true;
            self.owner.StartCheckingForPrey();
            // canMove = true
            // wander randomly
            // if livingCreature detected within 120pixels, change state to hunt
            // if no longer hungry, change to idle state
        })
        .SetStep(function() {
            if (self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("lowHealth");
            }

            if (!self.owner.hunger.IsHungry()) {
                self.stateMachine.change("idle");
            }

            if (instance_exists(self.owner.preyTarget)) {
                self.stateMachine.change("hunt");
            }
        })
        .SetLeave(function() {
            self.owner.StopCheckingForPrey();
            self.owner.wanderRandomly = false;
        });

    var hunt = new StateStruct("hunt")
        .SetEnter(function() {
            // canMove = true
            self.owner.canMove = true;

            // chase after target
            self.owner.chaseTarget = true;
            
        })
        .SetStep(function() {
            if (self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("lowHealth");
            }

            if (!self.owner.hunger.IsHungry()) {
                self.stateMachine.change("idle");
            }

            if (!instance_exists(self.owner.preyTarget)) {
                self.stateMachine.change("hungryWander");
            }

            if (point_distance(self.owner.x, self.owner.y, self.owner.preyTarget.x, self.owner.preyTarget.y) < self.owner.attackRange) {
                self.stateMachine.change("attack");
            }
        })
        .SetLeave(function() {
            self.owner.chaseTarget = false;
        });

    var attack = new StateStruct("attack")
        .SetEnter(function() {
            self.owner.canMove = false;
            self.owner.canAttack = true;
            // canMove = false
            // rotate to face target
            // canAttack = true

            // canAttack is false on exit
            // if target it outside of attackRange, change state to hunt
            // each attack increases the hunger and health
            // if health is low, change state to lowHealth
            // if target is outside of 120pixels, change state to hungryWander
        })
        .SetStep(function() {
            self.owner.entityHealth.Heal(0.3);

            if (self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("lowHealth");
            }

            if (!instance_exists(self.owner.preyTarget)) {
                self.stateMachine.change("hungryWander");
            }

            if (point_distance(self.owner.x, self.owner.y, self.owner.preyTarget.x, self.owner.preyTarget.y) > self.owner.attackRange) {
                self.stateMachine.change("hunt");
            }
        })
        .SetLeave(function() {
            self.owner.canAttack = false;
        });

    var lowHealth = new StateStruct("lowHealth")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.fleeing = true;

            self.owner.fleePosition = new Vector2(irandom_range(0, room_width), irandom_range(0, room_height));
            // canMove = true;
            // pick direction that is opposite of image_angle
            // run forward for 1-3 seconds after, change state to heal
        })
        .SetStep(function() {
            if (!self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("idle");
            }

            if (self.owner.hunger.IsHungry()) {
                self.stateMachine.change("hungryWander");
            }

            if (point_distance(self.owner.x, self.owner.y, self.owner.fleePosition.x, self.owner.fleePosition.y) < 10) {
                self.stateMachine.change("heal");
            }
        })
        .SetLeave(function() {
            self.owner.fleeing = false;
        });
    
    var heal = new StateStruct("heal")
        .SetEnter(function() {
            // canMove = false
            self.owner.canMove = false;
            // canAttack = false
            // wait for 3 seconds
            // heal 10% of max health
            // change to idle state
        })
        .SetStep(function() {
            self.owner.entityHealth.Heal(1);

            if (!self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("idle");
            }
        });

    self.AddState(idle);
    self.AddState(hungryWander);
    self.AddState(hunt);
    self.AddState(attack);
    self.AddState(lowHealth);
    self.AddState(heal);
}

