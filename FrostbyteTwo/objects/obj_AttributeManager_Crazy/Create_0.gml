ready = false;
stats = new StatSystem(1, 1, 1, id);

totalPoints = 12;

str = 2;
dex = 2;
con = 2;

totalScoreRef = noone;
strengthScoreRef = noone;
dexterityScoreRef = noone;
constutitionScoreRef = noone;

strScoreIncreaseButton = noone;
strScoreDecreaseButton = noone;
dexScoreIncreaseButton = noone;
dexScoreDecreaseButton = noone;
conScoreIncreaseButton = noone;
conScoreDecreaseButton = noone;

readyButton = noone;

alarm[0] = 2;

function IncrementStatValue(_statType, _value)
{
    switch (_statType)
    {
        case StatType.Strength:
            if (str + _value <= 10 && totalPoints - _value >= 0 && str + _value >= 2)
            {
                str += _value;
                totalPoints -= _value;
            }
            totalScoreRef.Text = $"Total Points: {totalPoints}";
            strengthScoreRef.Text = $"{str}";
            break;
        case StatType.Dexterity:
            if (dex + _value <= 10 && totalPoints - _value >= 0 && dex + _value >= 2)
            {
                dex += _value;
                totalPoints -= _value;
            }
            totalScoreRef.Text = $"Total Points: {totalPoints}";
            dexterityScoreRef.Text = $"{dex}";
            break;
        case StatType.Constitution:
            if (con + _value <= 10 && totalPoints - _value >= 0 && con + _value >= 2)
            {
                con += _value;
                totalPoints -= _value;
            }
            totalScoreRef.Text = $"Total Points: {totalPoints}";
            constutitionScoreRef.Text = $"{con}";
            break;
    }
}