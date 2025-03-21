timeOfDay += (1 / dayLength) * dir;
if (timeOfDay >= 1)
{
    timeOfDay = 1;
    dir = -1;
}
else if (timeOfDay <= 0)
{
    timeOfDay = 0;
    dir = 1;
}
timeOfDay = clamp(timeOfDay, 0, 1);
alphaValue = timeOfDay * 0.85;
