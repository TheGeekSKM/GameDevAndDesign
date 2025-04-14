

function SelectChoicesForTurn(_count)
{
    var validChoices = [];

    for (var i = 0; i < array_length(global.ChoicePool); i += 1) {
        var choice = global.ChoicePool[i];
        if (choice != undefined && choice.CanSpawnChoice()) {
            array_push(validChoices, choice);
        }
    }

    if (array_length(validChoices) == 0) {
        return [];
    }

    var selected = [];

    //repeat (_count)
    //{
        //if (array_length(validChoices) == 0) {
            //break;
        //}
//
        ////var totalWeight = 0;
        ////for (var i = 0; i < array_length(validChoices); i += 1) {
            ////totalWeight += validChoices[i].Weight;
        ////}
//
        ////var randomValue = random(totalWeight);
        ////var cumulativeWeight = 0;
////
        ////for (var i = 0; i < array_length(validChoices); i += 1) {
            ////cumulativeWeight += validChoices[i].Weight;
            ////if (randomValue < cumulativeWeight) 
            ////{
                ////array_push(selected, validChoices[i]);
                ////validChoices[i].Selected();
                ////array_delete(validChoices, i, 1); // Remove the selected choice from validChoices
                ////break;
            ////}
        ////}
        //
        //
    //}
    
    
    
    validChoices = array_shuffle(validChoices);
    for (var i = 0; i < _count; i++) {
        if (i >= array_length(validChoices))
        {
            echo("Not enough valid choices, selecting random choice from global.ChoicePool")
            var choice = global.ChoicePool[irandom_range(0, array_length(global.ChoicePool) - 1)];
            choice.Selected();
            array_push(selected, choice);
        }
        else 
        {
            echo("Selecting choice from validChoices")
            validChoices[i].Selected();
            array_push(selected, validChoices[i]);
        }
    }

    if (global.GameManager.GetStats().Food <= 10)
    {
        var ch = new ChoiceData()
        .SetTitle("Food Shortage")
        .SetDescription("Sir, we have received reports of a food shortage in the province.\nThe farmers are complaining that they cannot grow enough food to feed the population.\n\nAn idea has been brought up by High Cleric Talve to send some of the soldiers into the woods to look for possible food sources.\nHowever, this may cause some unrest amongst the soldiers, as they are not trained to be foragers, nor are they trained to kill non-human entities.\n\nWhat say you, Sir?\n\n(People's Loyalty +1, Food +5, Army Strength -1, and Nobles' Loyalty -1) vs. (People's Loyalty -1, and Nobles' Loyalty +1)")
        .AddConditionFunc( function() { return (global.GameManager.GetStats().Food < 20); })
        .AddAcceptCallback(function() 
            { 
                SetFlag("FoodStocked"); 
                global.GameManager.GetStats().Loyalty++; 
                global.GameManager.AddDelayedCallback(function() 
                    {
                        global.GameManager.GetStats().AddToStat(StatType.FOOD, 5);
                    }
                , 1);
                global.GameManager.GetStats().ArmyStrength--;
                global.GameManager.GetStats().NobleLoyalty--;
            }
        )
        .AddRejectCallback(function() { SetFlag("FoodStocked", false); global.GameManager.GetStats().Loyalty--; global.GameManager.GetStats().NobleLoyalty++;});
        
        array_push(selected, ch);
    }

    return selected;
}

function CreateTurnFromChoiceSelection()
{
    var selected = SelectChoicesForTurn(irandom_range(1, 3));
    var newTurn = new TurnData()

    for (var i = 0; i < array_length(selected); i += 1) {
        newTurn.AddChoice(selected[i]);
        array_push(global.GameManager.ChoiceHistory, selected[i]);
    }

    return newTurn;
}