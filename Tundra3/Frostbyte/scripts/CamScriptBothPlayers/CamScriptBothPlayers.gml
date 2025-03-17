var cam = global.vars.Cameras[0];

// Set the camera to the center of the players
var newX = (global.playerBounds[0] + global.playerBounds[2] - camera_get_view_width(cam)) * 0.5;
var newY = (global.playerBounds[1] + global.playerBounds[3] - camera_get_view_height(cam)) * 0.5;

camera_set_view_pos(cam, newX, newY);

