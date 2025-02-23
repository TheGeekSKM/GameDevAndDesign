if (!canMove) return;

counter++;
y = lerp(y, defaultPos + (sin(counter / 20) * 10), 0.5);    