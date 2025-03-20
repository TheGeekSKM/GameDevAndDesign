if (bulletItem == undefined) {
    show_message("Bullet item not set for {id}");
    instance_destroy();
}

if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
image_angle = direction;

var nextPosition = new Vector2(x + lengthdir_x(speed, direction), y + lengthdir_y(speed, direction));
var collision = instance_place(x, y, targets);

if (instance_exists(collision)) {
    collision.TakeDamage(damage, damageType, shooter);
    instance_destroy();
}