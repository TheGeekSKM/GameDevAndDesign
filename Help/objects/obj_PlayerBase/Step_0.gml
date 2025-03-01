if (forward == undefined or backward == undefined or leftWard == undefined or rightWard == undefined or interact == undefined) return;
    
var up = keyboard_check(forward);
var down = keyboard_check(backward);
var left = keyboard_check(leftWard);
var right = keyboard_check(rightWard);

moveX = (right - left) * spd;
moveY = (down - up) * spd;

if (moveX != 0) moveY = 0;
if (moveY != 0) moveX = 0;
    
if (moveX>0) image_angle = 0;
if (moveX<0) image_angle = 180; 
if (moveY>0) image_angle = 270;
if (moveY<0) image_angle = 90;
    
if (moveX != 0 or moveY != 0) {
    if (!doOnce) {
        image_index = ChooseFromArray([0, 2]);
        doOnce = true;
    }
    image_speed = 1;
} 
else 
{
    doOnce = false;
    image_index = 1;
    image_speed = 0;
}
    
move_and_collide(moveX, moveY, collisionObjects, 4, 0, 0, spd, -1);


