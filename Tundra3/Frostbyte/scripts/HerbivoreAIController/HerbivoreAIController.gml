function HerbivoreAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetStep(function() {
            // canMove = true
            // wander randomly
            // if hungry, change state to hungryWander
            // if predator detected within range, change state to runAway
        });

    var hungryWander = new StateStruct("hungryWander")
        .SetStep(function() {
            // canMove = true
            // wander randomly
            // if food source detected within range, change state to moveToFoodSource
            // if no longer hungry, change to wander state
        });

    var moveToFoodSource = new StateStruct("moveToFoodSource")
        .SetStep(function() {
            // canMove = true
            // move towards food source
            // if food source is reached, change state to eat
            // if food source is lost, change state to hungryWander
        });

    var eat = new StateStruct("eat")
        .SetStep(function() {
            // canMove = false
            // consume food source
            // if full, change state to wander
            // if interrupted (e.g., predator detected), change state to runAway
        });

    var runAway = new StateStruct("runAway")
        .SetStep(function() {
            // canMove = true
            // pick direction that is opposite of predator's position
            // run forward
            // if predator is no longer detected, change state to wander
        });

    self.AddState(idle);
    self.AddState(hungryWander);
    self.AddState(moveToFoodSource);
    self.AddState(eat);
    self.AddState(runAway);
}

