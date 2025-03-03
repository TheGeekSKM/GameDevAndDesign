other.TakeDamage(damage);
var text = instance_create_depth(x, y, 0, obj_pickUpText)
text.Init(string_concat(damage), c_green);
instance_destroy()