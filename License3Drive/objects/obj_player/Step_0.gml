moveX = (input_check("right") - input_check("left")) * moveSpeed;
moveY = (input_check("down") - input_check("up")) * moveSpeed;

if (moveX != 0) moveY = 0;
if (moveY != 0) moveX = 0;
    
if (moveX > 0) image_angle = 0;
if (moveX < 0) image_angle = 180;
if (moveY > 0) image_angle = 270;
if (moveY < 0) image_angle = 90; 
    
move_and_collide(moveX, moveY, collidables, 4, 0, 0, moveSpeed, -1);   

if (moveX + moveY != 0) { image_speed = 1; }
else { 
    image_speed = 0;
    image_index = 0; 
}    