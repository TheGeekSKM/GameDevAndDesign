// Inherit the parent event
event_inherited();

Subscribe("DayDisplayOpen", function(id) {
    OpenMenu();
    alarm[0] = 3 * 60; 
});

depth = -9999
