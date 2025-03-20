function HerbivoreAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.wanderRandomly = true;
            self.owner.StartCheckingForPredators();
            // canMove = true
            // wander randomly
        })
        .SetStep(function() {
            // if predator detected within range, change state to runAway
            if (self.owner.predatorsFound) {
                self.stateMachine.change("runAway");
            }
            
            // if hungry, change state to hungryWander
            if (self.owner.hunger.IsHungry() or self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("hungryWander");
            }
        })
        .SetLeave(function() {
            self.owner.wanderRandomly = false;
            self.owner.StopCheckingForPredators();
        });

    var hungryWander = new StateStruct("hungryWander")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.wanderRandomly = true;
            self.owner.StartCheckingForPredators();
            self.owner.StartCheckingForFood();
            // canMove = true
            // wander randomly
        })
        .SetStep(function() {
            // if predator detected within range, change state to runAway
            if (self.owner.predatorsFound) {
                self.stateMachine.change("runAway");
            }
            
            // if food source detected within range, change state to moveToFoodSource
            if (self.owner.foodFound) {
                self.stateMachine.change("moveToFoodSource");
            }
            
            // if no longer hungry, change state to idle
            if (!self.owner.hunger.IsHungry() and !self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.wanderRandomly = false;
            self.owner.StopCheckingForPredators();
            self.owner.StopCheckingForFood();
        });

    var moveToFoodSource = new StateStruct("moveToFoodSource")
        .SetEnter(function() {
            // canMove = true
            self.owner.canMove = true;
            
            // move towards food source
            self.owner.moveTowardsFoodSource = true;
        })
        .SetStep(function() {
            // if predator detected within range, change state to runAway
            if (self.owner.predatorsFound) {
                self.stateMachine.change("runAway");
            }
            
            // if food source is reached, change state to eat
            if (!instance_exists(self.owner.targetFoodSource)) {
                self.stateMachine.change("hungryWander");
            }

            // if food source is reached, change state to eat
            if (point_distance(self.owner.x, self.owner.y, self.owner.targetFoodSource.x, self.owner.targetFoodSource.y) <= self.owner.foodEatRange) {
                self.stateMachine.change("eat");
            }

            // if no longer hungry, change state to idle
            if (!self.owner.hunger.IsHungry() and !self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.moveTowardsFoodSource = false;
        });

    var eat = new StateStruct("eat")
        .SetEnter(function() {
            // canMove = false
            self.owner.canMove = false;
            self.owner.StartEating();
            // consume food source
            // if full, change state to wander
            // if interrupted (e.g., predator detected), change state to runAway
        })
        .SetStep(function() {
            // if predator detected within range, change state to runAway
            if (self.owner.predatorsFound) {
                self.stateMachine.change("runAway");
            }

            if (!instance_exists(self.owner.targetFoodSource)) {
                self.stateMachine.change("hungryWander");
            }
            
            // if no longer hungry, change state to idle
            if (!self.owner.hunger.IsHungry() and !self.owner.entityHealth.IsBadlyDamaged()) {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.StopEating();
        });

    var runAway = new StateStruct("runAway")
        .SetEnter(function() {
            self.owner.canMove = true;
            self.owner.fleeing = true;
            self.owner.fleePosition = new Vector2(random_range(0, room_width), random_range(0, room_height));
            // canMove = true
            // pick direction that is opposite of predator's position
            // run forward
            // if predator is no longer detected, change state to wander
        })
        .SetStep(function() {
            // if predator is no longer detected, change state to wander
            if (!self.owner.predatorsFound or 
                !instance_exists(self.owner.closestPredator) or 
                point_distance(self.owner.x, self.owner.y, self.owner.fleePosition.x, self.owner.fleePosition.y) < 10) {
                self.stateMachine.change("idle");
            }
        })
        .SetLeave(function() {
            self.owner.fleeing = false;
        });

    self.AddState(idle);
    self.AddState(hungryWander);
    self.AddState(moveToFoodSource);
    self.AddState(eat);
    self.AddState(runAway);
}

