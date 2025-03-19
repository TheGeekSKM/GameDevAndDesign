function UndeadAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetStep(function() {
            // canMove = true
            // wander randomly
            // if livingCreature detected within 120 pixels, change state to chase
        });

    var chase = new StateStruct("chase")
        .SetStep(function() {
            // canMove = true
            // chase after target
            // if target is within attackRange, change state to attack
            // if target leaves 120 pixels range, change state to wander
        });

    var attack = new StateStruct("attack")
        .SetStep(function() {
            // canMove = false
            // rotate to face target
            // canAttack = true

            // canAttack is false on exit
            // if target is outside of attackRange, change state to chase
            // if target is outside of 120 pixels, change state to wander
        });

    self.AddState(idle);
    self.AddState(chase);
    self.AddState(attack);
}