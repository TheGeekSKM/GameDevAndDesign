stats = new Stats("Viruvia");
worldState = new WorldState();
ChoiceHistory = [];
DelayedEffects = [];

function GetWorldState() {
    return worldState;
}
function GetStats() {
    return stats;
}

global.GameManager = id;

EventPool = [];
TurnCount = 0;
MonthsPerTurn = 2;

introTurnDescription = @"Good Morrow, Governer! 
On the behalf of the King and the Province, we would first like to take a moment to mourn the loss of your father, the late Governer of this province.
But enough of that, we are here to discuss the future of this province and your role in it. You will be responsible for managing the province's resources, and making its decisions. 
But first, some information about the Province you inherited, should you choose to accept it:";

introTurnDescription = string_concat(introTurnDescription, $"\n{stats.ToString()}");

IntroTurn = new TurnData()
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

function AddDelayedCallback(_callback, _turnsToWait) {
    array_push(DelayedEffects, [_callback, _turnsToWait + TurnCount]);
}

stateMachine = new SnowState("playerTurn")

stateMachine.add("playerTurn", {
    enter: function() {
        
        echo("bungus")
        Raise("NewTurn", EventPool[TurnCount]);
        var turn = CreateTurnFromChoiceSelection()
        array_push(EventPool, turn);
        
    },
    leave: function() {
        Raise("EndTurn", id);
    }
});

stateMachine.add("worldTurn", {
    enter: function() {
        TurnCount++;
        Raise("UpdateTimePassed", TurnCount);
        layer_sequence_headdir(timePassedSequence, seqdir_right)
        layer_sequence_play(timePassedSequence);
        alarm[0] = 300
        worldState.Step();
        stats.Step();
    },
    step: function() {},
    leave: function() {}
});

stateMachine.add("enemyTurn", {
    enter: function() {
        alarm[1] = 120;
    },
    step: function() {},
    leave: function() {
        layer_sequence_headdir(timePassedSequence, seqdir_left)
        layer_sequence_play(timePassedSequence);
    }
});


Subscribe("NewTurn", function(_turn) {
    if (array_length(DelayedEffects) > 0)
    {
        for (var i = array_length(DelayedEffects) - 1; i >= 0; i -= 1) {
            var effect = DelayedEffects[i];
            if (effect[1] <= TurnCount) 
            {
                effect[0]();
                array_delete(DelayedEffects, i, 1);
            }
        }
    }
});

