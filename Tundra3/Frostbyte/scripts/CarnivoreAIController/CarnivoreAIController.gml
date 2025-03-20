function CarnivoreAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetStep(function() {
            // canMove = true
            // wander randomly
            // if hungry, change state to hungryWander
            // if at low health, change state to lowHealth
        });
    
    var hungryWander = new StateStruct("hungryWander")
        .SetStep(function() {
            // canMove = true
            // wander randomly
            // if livingCreature detected within 120pixels, change state to hunt
            // if no longer hungry, change to idle state
        });

    var hunt = new StateStruct("hunt")
        .SetStep(function() {
            // canMove = true
            // chase after target
            // if target is within attackRange change state to attack
            // if target leaves 120 pixels range, change state to hungryWander
        });

    var attack = new StateStruct("attack")
        .SetStep(function() {
            // canMove = false
            // rotate to face target
            // canAttack = true

            // canAttack is false on exit
            // if target it outside of attackRange, change state to hunt
            // each attack increases the hunger and health
            // if health is low, change state to lowHealth
            // if target is outside of 120pixels, change state to hungryWander
        });

    var lowHealth = new StateStruct("lowHealth")
        .SetStep(function() {
            // canMove = true;
            // pick direction that is opposite of image_angle
            // run forward for 1-3 seconds after, change state to heal
        });
    
    var heal = new StateStruct("heal")
        .SetStep(function() {
            // canMove = false
            // canAttack = false
            // wait for 3 seconds
            // heal 10% of max health
            // change to idle state
        });

    self.AddState(idle);
    self.AddState(hungryWander);
    self.AddState(hunt);
    self.AddState(attack);
    self.AddState(lowHealth);
    self.AddState(heal);
}

