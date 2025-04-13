enum StatType {
    GOLD,
    FOOD,
    LOYALTY,
    ARMY_STRENGTH,
    INTEL
}

function Stats(_name) constructor 
{
    ownerName = _name; // Name of the owner of the stats

    Gold = irandom_range(100, 200); // Random initial gold between 100 and 200
    Food = irandom_range(100, 200); // Random initial food between 100 and 200
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
        }
    }

    function ToString()
    {
        var result = "";
        string_concat(result, $"{ownerName} Information:\n");

        var goldString = "";
        if (Gold <= 3) goldString = "Poor";
        else if (Gold <= 6) goldString = "Average";
        else if (Gold <= 9) goldString = "Rich";
        else goldString = "Wealthy";
        string_concat(result, $"- Perceivable Wealth: {goldString}\n");

        var foodString = "";
        if (Food <= 3) foodString = "Starving";
        else if (Food <= 6) foodString = "Average";
        else if (Food <= 9) foodString = "Well-fed";
        else foodString = "Abundant";
        string_concat(result, $"- Perceivable Food: {foodString}\n");

        var loyaltyString = "";
        if (Loyalty <= 3) loyaltyString = "Disloyal";
        else if (Loyalty <= 6) loyaltyString = "Neutral";
        else if (Loyalty <= 9) loyaltyString = "Loyal";
        else loyaltyString = "Devoted";
        string_concat(result, $"- Perceivable Loyalty: {loyaltyString}\n");

        var armyStrengthString = "";
        if (ArmyStrength <= 3) armyStrengthString = "Weak";
        else if (ArmyStrength <= 6) armyStrengthString = "Average";
        else if (ArmyStrength <= 9) armyStrengthString = "Strong";
        else armyStrengthString = "Invincible";
        string_concat(result, $"- Perceivable Army Strength: {armyStrengthString}\n");

        var intelString = "";
        if (Intel <= 3) intelString = "Uninformed";
        else if (Intel <= 6) intelString = "Informed";
        else if (Intel <= 9) intelString = "Intelligent";
        else intelString = "Genius";
        string_concat(result, $"- State of Intelligence: {intelString}\n");
        
        return result;
    }
}


