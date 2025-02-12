if (!canMove) return;

counter++;
y = lerp(y, (sin(counter / 20) * 10), 0.5);    