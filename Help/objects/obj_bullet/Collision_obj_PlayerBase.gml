other.TakeDamage(damage); // Reduce player health
var text = instance_create_depth(x, y, 0, obj_pickUpText)
text.Init(string_concat(damage), c_red);
instance_destroy(); // Destroy bullet