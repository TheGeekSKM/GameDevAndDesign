enabled = false;

xLeftLimit = 288;
xRightLimit = 512;

yTopLimit = 120;
yBottomLimit = 312;

xChange = 224;
yChange = 96;

x = 288;
y = 120;

var buttonInstance = instance_place(x, y, obj_Button_RM_GP2_BASE);
if (instance_exists(buttonInstance)) {
    buttonInstance.OnMouseLeftClickRelease();
}

function Move(_x, _y)
{
    // Move delta
    var proposedX = x + xChange * _x;
    var proposedY = y + yChange * _y;

    // Wrap horizontally
    if (proposedX < xLeftLimit) proposedX = xRightLimit;
    else if (proposedX > xRightLimit) proposedX = xLeftLimit;

    // Wrap vertically
    if (proposedY < yTopLimit) proposedY = yBottomLimit;
    else if (proposedY > yBottomLimit) proposedY = yTopLimit;

    // Try snapping to a button
    var buttonInstance = instance_place(proposedX, proposedY, obj_Button_RM_GP2_BASE);
    if (instance_exists(buttonInstance)) {
        x = proposedX;
        y = proposedY;
        buttonInstance.OnMouseLeftClickRelease();
    }
}


Subscribe("Page2", function(_) {
    enabled = true;
})