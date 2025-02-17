moveX = (input_check("right") - input_check("left")) * moveSpeed;
moveY = (input_check("down") - input_check("up")) * moveSpeed;
if (keyboard_check_pressed(vk_period)) {
    AddItem(ItemType.CarParts, 50);
    AddItem(ItemType.Paper, 50);
    global.debug = !global.debug;
}
if (input_check_pressed("action")) Raise("K Pressed", id);  
    
if (global.pause) return;  
    
if (isDead) 
{
    bloodScale += 0.01;
    return;
}

if (collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_car, true, true))
{
    isDead = true;
    alarm[1] = 120;
    image_speed = 0;
} 




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

if (collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_oilSpill, true, true))
{
    moveSpeed = lerp(moveSpeed, defaultMoveSpeed + 3, 0.4);
}
else {
    moveSpeed = lerp(moveSpeed, defaultMoveSpeed, 0.01);
}    