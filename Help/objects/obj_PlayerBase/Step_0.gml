if (forward == undefined or 
    backward == undefined or 
    leftWard == undefined or 
    rightWard == undefined or 
    interact == undefined or 
    menu == undefined) return;


if (global.vars.pause or inputPause) return;
    
attributes.Step();

attackSpeed = max(10, 60 - (attributes.Dexterity * 4));
attackDamage = attributes.Strength * 2;

spd = attributes.Dexterity;

var up = keyboard_check(forward);
var down = keyboard_check(backward);
var left = keyboard_check(leftWard);
var right = keyboard_check(rightWard);

if (keyboard_check_pressed(menu)) Raise("PauseOpen", id);

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
    image_speed = spd / 2;
} 
else 
{
    doOnce = false;
    image_index = 1;
    image_speed = 0;
}
    
move_and_collide(moveX, moveY, collisionObjects, 4, 0, 0, spd, -1);

ds_list_clear(tempInteractableList);
collision_circle_list(x, y, interactionRange, obj_base_interactable, false, true, tempInteractableList, false);
for (var i = 0; i < ds_list_size(tempInteractableList); i++)
{ 
    if (instance_exists(tempInteractableList[| i]))
    {
        // if an item is in range and has no owner, become its owner
        if (tempInteractableList[| i].playerInRange == noone)
        {
            tempInteractableList[| i].playerInRange = id;
            array_push(interactableList, tempInteractableList[| i]);
        }
    }
}

for (var i = 0; i < array_length(interactableList); i++)
{
    if (!instance_exists(interactableList[i]))
    {
        array_delete(interactableList, i, 1);
        break;
    }
    var dist = point_distance(x, y, interactableList[i].x, interactableList[i].y);
    if (dist > interactionRange)
    {
        interactableList[i].playerInRange = noone;
        array_delete(interactableList, i, 1);
    }
}

if (keyboard_check_pressed(interact) and !inputPause)
{
    for (var i = 0; i < array_length(interactableList); i++)
    {
        interactableList[i].OnInteract();
    }
}

// show_debug_message(inventory.ToString());

// Check if inputPause is false
if (!inputPause) {
    var nearestEnemy = noone;
    var shortestDist = attackRange + 1; 

    // Find the nearest enemy
    with (obj_Enemy_Chase) {
        var dist = point_distance(x, y, other.x, other.y);
        if (dist < shortestDist) {
            shortestDist = dist;
            nearestEnemy = id;
        }
    }

    // If an enemy is in range and attack cooldown is ready, shoot a bullet
    if (nearestEnemy != noone && attackCooldown <= 0) {
        var bullet = instance_create_layer(x, y, "Bullets", obj_playerBullet);
        bullet.direction = point_direction(x, y, nearestEnemy.x, nearestEnemy.y);
        bullet.damage = attackDamage;
        
        attackCooldown = attackSpeed; // Reset cooldown
    }
}

// Reduce attack cooldown timer
if (attackCooldown > 0) attackCooldown--;