totalScoreRef = obj_TextDisplay_TotalScore;
strengthScoreRef = obj_TextDisplay_STR_Score;
dexterityScoreRef = obj_TextDisplay_DEX_Score;
constutitionScoreRef = obj_TextDisplay_CON_Score;

strScoreIncreaseButton = obj_Button_STR_Increase;
strScoreDecreaseButton = obj_Button_STR_Decrease;
dexScoreIncreaseButton = obj_Button_DEX_Increase;
dexScoreDecreaseButton = obj_Button_DEX_Decrease;
conScoreIncreaseButton = obj_Button_CON_Increase;
conScoreDecreaseButton = obj_Button_CON_Decrease;

readyButton = obj_Button_ATTR_Ready;

totalScoreRef.Text = $"Total Points: {totalPoints}";
strengthScoreRef.Text = $"{str}";
dexterityScoreRef.Text = $"{dex}";
constutitionScoreRef.Text = $"{con}";

strScoreIncreaseButton.AddCallback(function() {
    IncrementStatValue(StatType.Strength, 1);
});
strScoreDecreaseButton.AddCallback(function() {
    IncrementStatValue(StatType.Strength, -1);
});
dexScoreIncreaseButton.AddCallback(function() {
    IncrementStatValue(StatType.Dexterity, 1);
});
dexScoreDecreaseButton.AddCallback(function() {
    IncrementStatValue(StatType.Dexterity, -1);
});
conScoreIncreaseButton.AddCallback(function() {
    IncrementStatValue(StatType.Constitution, 1);
});
conScoreDecreaseButton.AddCallback(function() {
    IncrementStatValue(StatType.Constitution, -1);
});
readyButton.AddCallback(function() {
    if (totalPoints <= 0 or true)
    {
        ready = true;
        alarm[1] = 30;
    }
    else 
    {
        Raise("NotificationOpen", "Not all [wave]Points[/wave] have been spent!")
    }
});

obj_ASM_Constitution.AddMouseEnterCallback(function () {
    obj_AttributeDisplay_Panel.Hovering(2);
});

obj_ASM_Strength.AddMouseEnterCallback(function () {
    obj_AttributeDisplay_Panel.Hovering(0);
});

obj_ASM_Dexterity.AddMouseEnterCallback(function () {
    obj_AttributeDisplay_Panel.Hovering(1);
});

obj_AttributeDisplay_Panel.Hovering(0);

