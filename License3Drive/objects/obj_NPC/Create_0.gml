image_blend = make_color_hsv(irandom(255), irandom(150), irandom(100));
timeToPickNewPoint = irandom_range(180, 360);
alarm[1] = (random(100) >= 30 ? timeToPickNewPoint : random(25));

bounds = noone;
newPos = new Vector2(x, y);
walking = false;
canWalk = false;
npcSpeed = 1;
image_speed = 0;

image_angle = random(360);