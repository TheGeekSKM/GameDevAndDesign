enum StatType {
    GOLD,
    FOOD,
    LOYALTY,
    ARMY_STRENGTH,
    INTEL,
    RESOURCES,
    POPULATION,
    NOBLELOYALTY
}

function Stats(_name) constructor 
{
    ownerName = _name; // Name of the owner of the stats

    Gold = irandom_range(5, 10); // Random initial gold between 100 and 200
    Resources = irandom_range(100, 200); // Random initial resources between 100 and 200
    Population = irandom_range(10, 50); // Random initial population between 100 and 200
    Food = irandom_range(100, 200); // Random initial food between 100 and 200
    NobleLoyalty = irandom_range(0, 10); // Random initial noble loyalty between 0 and 10
    Loyalty = irandom_range(0, 10); // Random initial loyalty between 0 and 10
    ArmyStrength = irandom_range(0, 10); // Random initial army strength between 0 and 10
    Intel = irandom_range(0, 10); // Random initial intel between 0 and 10
    IsAtWar = false; // Initial state of war

    function AddToStat(_statType, _value)
    {
        switch (_statType) {
            case StatType.GOLD:
                Gold += _value;
                break;
            case StatType.FOOD:
                Food += _value;
                break;
            case StatType.LOYALTY:
                Loyalty += _value;
                break;
            case StatType.ARMY_STRENGTH:
                ArmyStrength += _value;
                break;
            case StatType.INTEL:
                Intel += _value;
                break;
            case StatType.RESOURCES:
                Resources += _value;
                break;
            case StatType.POPULATION:
                Population += _value;
                break;
            case StatType.NOBLELOYALTY:
                NobleLoyalty += _value;
                break;
        }
    }

    function Step()
    {
        if (Gold <= 0)
        {
            global.vars.SetLoseReason(LoseReason.BANKRUPT);
            Transition(rmLose, seqTrans_In_CornerSlide, seqTrans_Out_CornerSlide);
        }
        
        Food -= Population * 2;

    }

    function ToString()
    {
        var result = "";
        result = string_concat(result, $"{ownerName} Information:\n");

        var goldString = "";
        if (Gold <= 3) goldString = "Poor";
        else if (Gold <= 6) goldString = "Average";
        else if (Gold <= 9) goldString = "Rich";
        else goldString = "Wealthy";
        result = string_concat(result, $"- Wealth: {goldString} {Gold} / 10\n");

        var foodString = "";
        if (Food <= 3) foodString = "Starving";
        else if (Food <= 6) foodString = "Average";
        else if (Food <= 9) foodString = "Well-fed";
        else foodString = "Abundant";
        result = string_concat(result, $"- Food: {foodString} {Food} / 200\n");

        var loyaltyString = "";
        if (Loyalty <= 3) loyaltyString = "Disloyal";
        else if (Loyalty <= 6 and Loyalty > 3) loyaltyString = "Neutral";
        else if (Loyalty <= 9 and Loyalty > 6) loyaltyString = "Loyal";
        else loyaltyString = "Devoted";
        result = string_concat(result, $"- Loyalty: {loyaltyString} {Loyalty} / 10\n");

        var nobleloyaltyString = "";
        if (NobleLoyalty <= 3) nobleloyaltyString = "Disloyal";
        else if (NobleLoyalty <= 6 and NobleLoyalty > 3) nobleloyaltyString = "Neutral";
        else if (NobleLoyalty <= 9 and NobleLoyalty > 6) nobleloyaltyString = "Loyal";
        else nobleloyaltyString = "Devoted";
        result = string_concat(result, $"- Noble's Loyalty: {nobleloyaltyString} {NobleLoyalty} / 10\n");

        var armyStrengthString = "";
        if (ArmyStrength <= 3) armyStrengthString = "Weak";
        else if (ArmyStrength <= 6) armyStrengthString = "Average";
        else if (ArmyStrength <= 9) armyStrengthString = "Strong";
        else armyStrengthString = "Invincible";
        result = string_concat(result, $"- Army Strength: {armyStrengthString} {ArmyStrength} / 10\n");

        var intelString = "";
        if (Intel <= 3) intelString = "Uninformed";
        else if (Intel <= 6) intelString = "Informed";
        else if (Intel <= 9) intelString = "Intelligent";
        else intelString = "Genius";
        result = string_concat(result, $"- State of Intelligence: {intelString} {Intel} / 10\n");
        
        echo(result, true)
        return result;
    }
}


