carDirection = CarDirection.Down;
carSpeed = 0;
carSpeed = irandom_range(3, 5);
if (carDirection == CarDirection.Up) carSpeed *= -1;

defaultSpeed = carSpeed;

image_blend = make_color_hsv(irandom(255), 75, 50);