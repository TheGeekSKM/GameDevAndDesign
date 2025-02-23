moveX = (input_check("right") - input_check("left")) * moveSpeed;
moveY = (input_check("down") - input_check("up")) * moveSpeed;
if (keyboard_check_pressed(vk_period)) {
    AddItem(ItemType.CarParts, 50);
    AddItem(ItemType.Paper, 50);
    global.debug = !global.debug;
    Raise("NotificationIn", "Debug Mode Engaged")
}
if (input_check_pressed("menu")) Raise("Menu", id);  
if (input_check_pressed("back")) Raise("K Pressed", id);  

global.TimeStruct.timeNoMenu += 1/game_get_speed(gamespeed_fps);
    
if (global.pause) return;
    
global.TimeStruct.time += 1/game_get_speed(gamespeed_fps);  
    
if (isDead) 
{
    bloodScale += 0.01;
    return;
}

if (!global.debug)
{
    var otherCar = collision_rectangle(x - (sprite_width / 2), y - (sprite_height / 2), x + (sprite_width / 2), y + (sprite_height / 2), obj_car, true, true)
    if (otherCar)
    {
        isDead = true;
        alarm[1] = 180;
        image_speed = 0;
        instance_create_layer(x, y, "Explosions", obj_explosion);
        instance_destroy(otherCar);
        instance_create_layer(x, y, "NPCs", obj_bloodSpill);
    } 
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
    moveSpeed = lerp(moveSpeed, defaultMoveSpeed, 0.1);
}    