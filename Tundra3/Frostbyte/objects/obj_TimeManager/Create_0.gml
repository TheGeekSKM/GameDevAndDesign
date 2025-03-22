// Declare variables in the create event
timeOfDay = 1;       // 1 = Day, 0 = Night
dayLength = 60 * 60; // 1 minute transition (60 FPS * 60 sec)
holdTime = 4 * 60 * 60; // 4 minutes hold (60 FPS * 60 sec * 4)

transitionSpeed = 1 / dayLength;
holdTimer = 0;

state = "DAY_HOLD"; // Initial state