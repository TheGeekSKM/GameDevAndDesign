vis = false;

options = [
    "Resume",
    "Exit"
]

functions = [
    function() {
        vis = false;
        with (UIManager)
        {
            ShowUI(MenuState.NoMenu);    
        }
    },

    function() {
        game_end();
    }
]


selectedIndex = 0;

