// Find nearest player
var player1 = instance_exists(obj_Player1) ? obj_Player1 : noone;
var player2 = instance_exists(obj_Player2) ? obj_Player2 : noone;

// Default: No target
var target = noone;
var shortestDist = chaseRadius + 1; 

// Check Player 1
if (player1 != noone) {
    var distP1 = point_distance(x, y, player1.x, player1.y);
    if (distP1 < shortestDist) {
        shortestDist = distP1;
        target = player1;
    }
}

// Check Player 2
if (player2 != noone) {
    var distP2 = point_distance(x, y, player2.x, player2.y);
    if (distP2 < shortestDist) {
        shortestDist = distP2;
        target = player2;
    }
}

// Move toward the target if one is found
if (target != noone) {
    direction = point_direction(x, y, target.x, target.y);
    image_angle = direction;
    if (shortestDist > attackRadius) {
        // Move toward the player
        motion_set(direction, moveSpeed);
    } else {
        // Stop moving when close enough
        motion_set(direction, 0);

        // Attack if cooldown is over
        if (attackTimer <= 0) {
            show_debug_message("attacked")
            target.TakeDamage(attackDamage) // Deal damage
            var text = instance_create_depth(target.x, target.y, 0, obj_pickUpText)
            text.Init(string_concat(attackDamage), c_red);
            attackTimer = attackCooldown; // Reset cooldown
        }
    }
}

// Reduce attack cooldown
if (attackTimer > 0) attackTimer--;
