function NPCAIController(_owner) : AIController(_owner) constructor 
{
    var idle = new StateStruct("idle")
        .SetStep(function() {
            // canMove = false
            // stand still
            // if attacked by another creature or if a zombie is nearby, change state to attack
        });

    var attack = new StateStruct("attack")
        .SetStep(function() {
            // canMove = true
            // engage in combat with the attacker or nearby zombie
            // if no threats are detected, change state to idle
        });

    self.AddState(idle);
    self.AddState(attack);
}

