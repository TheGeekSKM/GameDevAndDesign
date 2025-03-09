// Inherit the parent event
event_inherited();

collidables = [];

entityMovementData = new EntityMovementData()
    .SetDistances(64, 8, 1)
    .SetSpeeds(4, 2, 1);

hoverColor = make_color_rgb(0, 255, 0);
healthSystem = new HealthSystem(50, id);