if (point_distance(x, y, obj_player.x, obj_player.y)) playerInRange = true;
else playerInRange = false;
    
if (input_check_pressed("accept") && playerInRange) OnInteract();
if (playerInRange) WhilePlayerInRange();    