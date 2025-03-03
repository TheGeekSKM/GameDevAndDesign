image_blend = make_color_rgb(200, 100, 50);
// Movement
moveSpeed = 1; // Speed of enemy movement
chaseRadius = 150; // Detection range
attackRadius = 10; // Distance required to attack

// Attack properties
attackDamage = 1; // Damage dealt per hit
attackCooldown = 180; // Time between attacks (frames)
attackTimer = 0; // Countdown before next attack

enemyHealth = 10;

function TakeDamage(dmg)
{
    enemyHealth -= dmg;
    if (enemyHealth <= 0) 
    {
        instance_create_layer(x, y, "Items", obj_computerPart);
        Raise("EnemyKilled", true);
        instance_destroy();
    }
}