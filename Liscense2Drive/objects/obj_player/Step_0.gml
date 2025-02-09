keyIntJ = keyboard_check_pressed(ord("J"));
keyIntL = keyboard_check_pressed(ord("L"));
keyIntI = keyboard_check_pressed(ord("I"));
keyEsc = keyboard_check_pressed(vk_escape);
keySpace = keyboard_check_pressed(vk_space);

if (keyIntL) Raise("L Pressed", id);
if (keyIntJ) Raise("J Pressed", id);
if (keyIntI) Raise("I Pressed", id);
if (keyEsc) Raise("Esc Pressed", id);
if (keySpace) Raise("Space Pressed", id);    

if (global.pause) {
    image_speed = 0;
    image_index = 0;
    return;
}


keyLeft =   keyboard_check(ord("A")) or keyboard_check(vk_left);
keyRight =  keyboard_check(ord("D")) or keyboard_check(vk_right);
keyUp =     keyboard_check(ord("W")) or keyboard_check(vk_up);
keyDown =   keyboard_check(ord("S")) or keyboard_check(vk_down);


moveX = (keyRight - keyLeft) * moveSpeed;
moveY = (keyDown - keyUp) * moveSpeed;

if (moveX != 0) moveY = 0;
if (moveY != 0) moveX = 0;
    
if (moveX > 0) image_angle = 0;
else if (moveX < 0) image_angle = 180; 
else if (moveY > 0) image_angle = 270; 
else if (moveY < 0) image_angle = 90; 

if (moveX == 0 and moveY == 0) {
    image_speed = 0;
    image_index = 0;
}
else image_speed = 2;
    
move_and_collide(moveX, moveY, [obj_block], 4, 0, 0, moveSpeed, -1);

