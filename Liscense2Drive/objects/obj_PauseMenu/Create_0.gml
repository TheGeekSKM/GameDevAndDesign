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

Subscribe("Esc Pressed", function(_id) {
    vis = !vis;    
})

selectedIndex = 0;

