playerIndex = 0;
txt = "";
image_blend = global.vars.PlayerColors[playerIndex];

Subscribe("SelectPlayer0", function(_index) {
    switch (_index)
    {
        case 0:
            txt = 
                "[c_black][scale, 1.5]Strength:[/s][/c]\n" + 
                "- [c_black]Health Bonus:[/c] Increases max health and hunger.\n" +
                "- [c_black]Carrying Capacity:[/c] Increases max carry weight and reduces encumbrance penalties.\n" +
                "- [c_black]Melee Combat:[/c] Boosts melee damage, attack speed, and knockback.\n" +
                "- [c_black]Defense Bonus:[/c] Improves natural resistance and armor effectiveness.\n" +
                "- [c_black]Critical Hits:[/c] Increases critical damage multiplier.\n" +
                "- [c_black]Survival Skills:[/c] Raises max temperature resistance but increases hunger and temperature drain.\n";
        break;
        case 1:
            txt = 
                "[c_black][scale, 1.5]Dexterity:[/s][/c]\n" + 
                "- [c_black]Stamina Bonus:[/c] Increases max stamina.\n" +
                "- [c_black]Movement Speed:[/c] Increases base movement speed.\n" +
                "- [c_black]Melee Combat:[/c] Boosts melee attack speed and slightly increases melee damage.\n" +
                "- [c_black]Ranged Combat:[/c] Increases ranged damage and attack speed.\n" +
                "- [c_black]Critical Hits:[/c] Increases critical hit chance.\n"
        break;
        case 2:
            txt = 
                "[c_black][scale, 1.5]Constitution:[/s][/c]\n" + 
                "- [c_black]Health Bonus:[/c] Increases max health and hunger capacity.\n" +
                "- [c_black]Stamina Bonus:[/c] Increases max stamina.\n" +
                "- [c_black]Carrying Capacity:[/c] Increases max carry weight.\n" +
                "- [c_black]Defense Bonus:[/c] Improves natural resistance and armor effectiveness.\n" +
                "- [c_black]Survival Skills:[/c] Improves temperature resistance and reduces hunger drain.\n";
        break;
    }
});