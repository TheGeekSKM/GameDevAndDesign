// Inherit the parent event
event_inherited();

counter++;
y = lerp(y, y + (sin(counter / Frequency) * Amplitude), 0.1);