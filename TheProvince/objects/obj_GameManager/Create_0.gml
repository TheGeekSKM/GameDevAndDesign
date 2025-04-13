stats = new Stats("Viruvia");
worldState = new WorldState();

function GetWorldState() {
    return worldState;
}
function GetStats() {
    return stats;
}

global.GameManager = id;

EventPool = [];
TurnCount = 0;

introTurnDescription = @" Good Morrow, Governer! 
On the behalf of the King and the Province, we would first like to take a moment to mourn the loss of your father, the late Governer of this province.
But enough of that, we are here to discuss the future of this province and your role in it. You will be responsible for managing the province's resources, and making its decisions. 
But first, some information about the Province you inherited, should you choose to accept it: 
    ";

introTurnDescription = string_concat(introTurnDescription, $"\n{stats.ToString()}");

IntroTurn = new TurnData()
    .SetID("intro")
    .SetTitle("Intro")
    .SetDescription(introTurnDescription)
    .AddWeight(50)
    .AddConditionFunc(function() { return true; })
    .AddChoice( new ChoiceData("Welcome, Governer!", [], function() {})
        .SetDescription(introTurnDescription)
        .AddAcceptCallback(function() {
            
        })
        .AddRejectCallback(function() {
            global.vars.SetLoseReason(LoseReason.DESERTED);
            Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }
    ));

array_push(EventPool, IntroTurn);

function FinishedPlayerTurn() {
    if (global.DocumentSpawner.AreAllChoicesMade())
    {
        stateMachine.change("worldTurn");
    }
}

stateMachine = new SnowState("playerTurn")

stateMachine.add("playerTurn", {
    enter: function() {
        echo("bungus")
        Raise("NewTurn", EventPool[TurnCount]);
        TurnCount++;
    },
    leave: function() {
        Raise("EndTurn", id);
    }
});

stateMachine.add("worldTurn", {
    enter: function() {},
    step: function() {},
    leave: function() {}
});

stateMachine.add("enemyTurn", {
    enter: function() {},
    step: function() {},
    leave: function() {}
});
