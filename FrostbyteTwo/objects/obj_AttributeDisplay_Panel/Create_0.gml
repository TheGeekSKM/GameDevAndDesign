// Inherit the parent event
event_inherited();
txt = "";

function Hovering(_index) {
    switch (_index)
    {
        case 0:
            txt = "[c_black][scale, 1.5]Strength[/s][/c]\n\n" + 
                "- [c_green][wave]Added[/wave][c_black] Health Bonus[/c]\n\n" +
                "- [c_green][wave]Increased[/wave][c_black] Carrying Capacity[/c]\n\n" +
                "- [c_green][wave]Stronger[/wave][c_black] Melee Combat[/c]\n\n" +
                "- [c_green][wave]Higher[/wave][c_black] Defense Bonus[/c]\n\n" +
                "- [c_green][wave]More[/wave][c_black] Critical Hits[/c]\n\n" +
                "- [c_green][wave]Improved[/wave][c_black] Survival Skills[/c]\n\n";
        break;
        case 1:
            txt = 
                "[c_black][scale, 1.5]Dexterity[/s][/c]\n\n" + 
                "- [c_green][wave]Added[/wave][c_black] Stamina Bonus[/c]\n\n" +
                "- [c_green][wave]Faster[/wave][c_black] Movement Speed[/c]\n\n" +
                "- [c_green][wave]Improved[/wave][c_black] Melee Combat[/c]\n\n" +
                "- [c_green][wave]Stronger[/wave][c_black] Ranged Combat[/c]\n\n" +
                "- [c_green][wave]More[/wave][c_black] Critical Hits[/c]\n\n"
        break;
        case 2:
            txt = 
                "[c_black][scale, 1.5]Constitution[/s][/c]\n\n" + 
                "- [c_green][wave]Added[/wave][c_black] Health Bonus[/c]\n\n" +
                "- [c_green][wave]Added[/wave][c_black] Stamina Bonus[/c]\n\n" +
                "- [c_green][wave]Increased[/wave][c_black] Carrying Capacity[/c]\n\n" +
                "- [c_green][wave]Increased[/wave][c_black] Defense Bonus[/c]\n\n" +
                "- [c_green][wave]Improved[/wave][c_black] Survival Skills[/c]\n\n";
        break;
    }
}

