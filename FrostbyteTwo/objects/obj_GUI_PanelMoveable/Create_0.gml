// Inherit the parent event
event_inherited();
dragRect = new Rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2));
dragging = false;
windowMouseOffset = new Vector2(0, 0);
topLeft = new Vector2(x - (sprite_width / 2), y - (sprite_height / 2));

function OnMouseLeftClick()
{
    dragging = true;
    windowMouseOffset.x = guiMouseX - x;
    windowMouseOffset.y = guiMouseY - y;
}

function OnMouseLeftClickRelease()
{
    dragging = false;
}

function OpenMenu()
{
    stateMachine.change("movingToOnScreen");
}

function HideMenu()
{
    stateMachine.change("hidden");
}

stateMachine = new SnowState("hidden");

hiddenPos = new Vector2(x, y);
stateMachine.add("hidden", {
    step: function() {
        x = lerp(x, hiddenPos.x, 0.25);
        y = lerp(y, hiddenPos.y, 0.25);
    }
});

targetPos = new Vector2(0, 0);
stateMachine.add("movingToOnScreen", {
    enter: function() {
        // set the target position to the center of the screen
        targetPos.x = (GUI_DEFAULT_WIDTH / 2);
        targetPos.y = (GUI_DEFAULT_HEIGHT / 2);
    },
    step: function() {
        x = lerp(x, targetPos.x, 0.25);
        y = lerp(y, targetPos.y, 0.25);

        if (abs(x - targetPos.x) < 10 && abs(y - targetPos.y) < 10) {
            stateMachine.change("onScreen");
        }
    }
});

stateMachine.add("onScreen", {
    step: function() {
        if (dragging)
        {
            var mousePosX = guiMouseX - windowMouseOffset.x;
            var mousePosY = guiMouseY - windowMouseOffset.y;
            x = mousePosX;
            y = mousePosY;
        } 
    }
});

closeButtonCallback = function() {}
closeButton = instance_create_depth(topLeft.x + sprite_width, topLeft.y, depth, obj_BASE_Button);
closeButton.depth = depth - 1;
closeButton
    .SetText("X")
    .SetColors(make_color_rgb(255, 200, 200), c_red)
    .AddCallback(function() {
        stateMachine.change("hidden");
        closeButtonCallback();
    });

