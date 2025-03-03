// Find the nearest player
var p1 = instance_exists(obj_Player1) ? obj_Player1 : noone;
var p2 = instance_exists(obj_Player2) ? obj_Player2 : noone;

// Default: No target
var target = noone;
var shortestDist = detectionRadius + 1; // Start with a max range

// Check Player 1
if (p1 != noone) {
    var dist_p1 = point_distance(x, y, p1.x, p1.y);
    if (dist_p1 < shortestDist) {
        shortestDist = dist_p1;
        target = p1;
    }
}

// Check Player 2
if (p2 != noone) {
    var dist_p2 = point_distance(x, y, p2.x, p2.y);
    if (dist_p2 < shortestDist) {
        shortestDist = dist_p2;
        target = p2;
    }
}

// If a player is detected, rotate and shoot
if (target != noone) {
    // Rotate towards the target
    direction = point_direction(x, y, target.x, target.y);
    image_angle = direction;

    // Fire bullets on interval
    fireTimer--;
    if (fireTimer <= 0) {
        var bullet = instance_create_layer(x, y, "Bullets", obj_bullet); // Create bullet
        bullet.direction = direction; // Match turret's direction
        bullet.speed = bulletSpeed;
        bullet.damage = bulletDamage;
        fireTimer = fireRate; // Reset timer
    }
}
