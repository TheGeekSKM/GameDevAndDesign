drawDist = 10;
x = obj_Player.x;
y = obj_Player.y;

canDraw = false;

Subscribe("PickUp", function(_id) {
    x = _id.x;
    y = _id.y;    
})